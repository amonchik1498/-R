## ---------- 1 ----------
## Створити змінні базових (atomic) типів. Базові типи: character, numeric, integer, complex, logical.
my_character <- 'A'
print(class(my_character))

my_numeric <- 10
print(class(my_numeric))

my_integer <- 100
print(class(my_integer))

my_compl <- complex(real = stats::rnorm(2), imaginary = stats::rnorm(2))
print(class(my_compl))

my_logic <- TRUE
print(class(my_logic))
## ---------- 2 ----------
## Створити вектори, які: містить послідовність з 5 до 75; містить числа 3.14, 2.71, 0, 13; 100 значень TRUE.
my_vector1 <- c(5:75)
print(my_vector1)
my_vector2 <- c(3.14,2.71,0,13)
print(my_vector2)
my_vector3 <- rep(TRUE, times=100)
print(my-vector3)
## ---------- 3 ----------
## Створити наступну матрицю за допомогою matrix, та за допомогою cbind або rbind

matrix_val <- c(0.5,3.9,0,2,1.3,131,2.2,7,3.5,2.8,4.6,5.1)
matrix(matrix_val, nrow = 4)

col1 <- matrix_val[1:4]
col2 <- matrix_val[5:8]
col3 <- matrix_val[9:12]
cbind(col1,col2,col3)
# ---------- 4 ----------
# Створити довільний список (list), в який включити всі базові типи.
list(my_character,my_compl,my_integer,my_logic,my_numeric)
# ---------- 5 ----------
# Створити фактор з трьома рівнями «baby», «child», «adult».
my_factor <- factor(c('baby', 'child', 'adult'))
# ---------- 6 ----------
# Знайти індекс першого значення NA в векторі 1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11. Знайти кількість значень NA.
my_vec <- c(1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11)
print(match(NA,my_vec))
print(sum(is.na(my_vec)))
# ---------- 7 ----------
# Створити довільний data frame та вивести в консоль.
my_df <- data.frame(col1,col2)
my_df
# ---------- 8 ----------
# Змінити імена стовпців цього data frame.
colnames(my_df) <- c('New1','New2')
my_df