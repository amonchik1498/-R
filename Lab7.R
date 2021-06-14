# "olympics.csv"
library(stringr)

prep_set <- function(file_path){
  my_df <- read_file(file_path)
  my_df <- remove_invalid_rows(my_df)
  my_df <- rename_columns(my_df)
  my_df <- add_country_id(my_df)
  my_df <- trim_county_names(my_df)
  return (my_df)
}

read_file <- function(file_path){
  return (read.csv(file_path, skip = 1, header = TRUE, encoding="UTF-8", stringsAsFactors = FALSE))
}

remove_invalid_rows <- function(my_df){
  my_df <- remove_totals(my_df)
  return (my_df)
}

remove_totals <- function(my_df){
  return (my_df[!my_df[1] == "Totals", ])
}

rename_col <- function(my_df){
  for (col_name in colnames(my_df))
    names(my_df)[names(my_df) == col_name] <- get_new_col_name(col_name) 
  return (my_df)
}

get_new_col_name <- function(old_col_name){
  
  if (old_col_name == 'X') return ('Country')
  # 'X..' -> ''
  if (grepl('X\\.\\.', old_col_name)) return (gsub(pattern = 'X\\.\\.',replacement = '',x = old_col_name))
  # 'X01..' -> 'Gold'
  if (grepl('X01\\.\\.', old_col_name)) return (gsub(pattern = 'X01\\.\\.',replacement = 'Gold',x = old_col_name))
  # 'X02..' -> 'Silver'
  if (grepl('X02\\.\\.', old_col_name)) return (gsub(pattern = 'X02\\.\\.',replacement = 'Silver',x = old_col_name))
  # 'X03..' -> 'Bronze'
  if (grepl('X03\\.\\.', old_col_name)) return (gsub(pattern = 'X03\\.\\.',replacement = 'Bronze',x = old_col_name))
  # else -> no changes
  return (old_col_name)
}

add_country_id <- function(my_df, column_name = 'Country'){
  my_df['ID'] <- str_match(df[[column_name]], '(.*\\()([A-Z0-9]{3})(\\).*)')[,3]
  return (my_df)
}

trim_county_names <- function(df, column_name = 'Country'){
  my_df[[column_name]] <- str_match(my_df[[column_name]], '([A-Za-z\\s]*)(\\s\\(.*)')[,2]
  return (my_df)
}


olympics <- prep_set("C:\\Users\\r123a\\Desktop\\R_CourseKNU\\olympics.csv")

answer_one <- function(my_df){
  return (my_df[df$'Gold' == max(df$'Gold'),'Country'])
}

answer_two <- function(my_df){
  diff <- get_absolute_summer_winter_diff(my_df)
  country_with_max_diff <- my_df[diff == max(diff),'Country']
  return (country_with_max_diff)
}

get_absolute_summer_winter_diff <- function(my_df){
  return (abs(my_df$'Total' - df$'Total.1'))
}

answer_three <- function(my_df){
  my_df <- filter_out_losers(my_df)
  diff <- get_relative_summer_winter_diff(my_df)
  country_with_max_diff <- my_df[diff == max(diff),'Country']
  return (country_with_max_diff)
}

filter_out_losers <- function(my_df){
  return (my_df[
    my_df$'Gold' > 0 & 
      my_df$'Gold.1' > 0
    ,])
}

get_relative_summer_winter_diff <- function(my_df){
  relative_diff <- (my_df$'Gold' - my_df$'Gold.1') / my_df$'Gold.2'
  return (relative_diff)
}

answer_four <- function(my_df){
  points <- get_points(my_df)
  return (data.frame(
    Country=my_df$'Country',
    Points=points))
}

get_points <- function(my_df, gold_reward = 3, silver_reward = 2, bronze_reward = 1){
  gold_points = my_df$'Gold.2'*gold_reward
  silver_points = my_df$'Silver.2'*silver_reward
  bronze_points = my_df$'Bronze.2'*bronze_reward
  total_points = gold_points + silver_points + bronze_points
  return (total_points)
}

# ------------ second part --------------------
# census.csv
cens_file_path <- "C:\\Users\\r123a\\Desktop\\R_CourseKNU\\census.csv"
cens_df <- read.csv(census_file_path, stringsAsFactors = FALSE)

answer_five <- function(my_df){
  counties_count_by_state <- get_counties_count_by_state(my_df)
  max_counties <- max(counties_count_by_state$'COUNTY')
  state_with_max_counties <- counties_count_by_state[
    counties_count_by_state$'COUNTY' == max_counties,
    'STNAME']
  return (state_with_max_counties)
}

get_counties_count_by_state <- function(my_df){
  return (aggregate(COUNTY ~ STNAME, my_df, function(x) length(unique(x))))
}

answer_six <- function(my_df){
  my_df <- my_df[ my_df$SUMLEV != 040 ,]
  pop_by_state <- get_population_by_state(my_df)
  sorted_pop_by_state <- pop_by_state[order(-pop_by_state[,'CENSUS2010POP']), ]
  return (sorted_pop_by_state[1:3,'STNAME'])
}

get_population_by_state <- function(my_df){
  return (aggregate(CENSUS2010POP ~ STNAME, my_df, function (state) get_population_in_largest_counties(state)))
}

get_population_in_largest_counties <- function(state, largest_counties_number = 3){
  return (sum(sort(state, decreasing = TRUE)[1:largest_counties_number]))
}

answer_seven <- function(my_df){
  my_df <- my_df[ my_df$SUMLEV != 040 ,]
  changes_by_county <- get_pop_changes_by_county(my_df)
  sorted_changes_by_county <- changes_by_county[order(-changes_by_county[,'range']), ]
  return(sorted_changes_by_county[1,'CTYNAME'])
}

get_pop_changes_by_county <- function(my_df){
  columns = c("POPESTIMATE2010",
              "POPESTIMATE2011",
              "POPESTIMATE2012",
              "POPESTIMATE2013",
              "POPESTIMATE2014",
              "POPESTIMATE2015" )
  my_df$range <- apply(my_df, 1, function (county) get_county_changes_range(county[columns]))
  return (my_df[c('CTYNAME','range')])
}

get_county_changes_range <- function(county){
  estimates <- as.numeric(county)
  return (max(estimates) - min(estimates))
}

answer_eight <- function(my_df){
  filtered <- my_df[
    ( my_df$REGION == '1' | my_df$REGION == '2' ) 
    & (grepl('^Washington', my_df$CTYNAME))
    & (as.numeric(my_df$POPESTIMATE2015) > as.numeric(my_df$POPESTIMATE2014))
    ,]
  
  return (filtered[c("STNAME", "CTYNAME")])
}