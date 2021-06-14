# ------- 1 -------
# Створити матрицю mat з 5 стовпцями та 10 строками за допомогою matrix з випадковими даними (функція rnorm(50)).
my_mat <- matrix(rnorm(50), nrow = 10)
# ------- 2 -------
# Знайти максимальне значення в кожному стовпці.
apply(mat, 2, my_max)
# ------- 3 -------
# Знайти середнє (mean) значення кожного стовпця.
colMeans(my_mat)
apply(my_mat, 2, mean)
# ------- 4 -------
# Знайти мінімальне значення в кожному рядку.
apply(my_mat, 1, min)
# ------- 5 -------
# Відсортувати кожен стовбець таблиці.
apply(my_mat, 2, sort)
# ------- 6 -------
# Знайти кількість значень < 0 для кожного стовпця
apply(my_mat, 2, function (x) sum(x < 0))
# ------- 7 -------
# Вивести вектор з булевими значеннями TRUE та FALSE. TRUE, якщо в стовпці є елементи >2, FALSE – якщо немає.
apply(my_mat, 2, function (x) any(x > 2))
# ------- 8 -------
# Створить список list1 <- list(observationA = c(1:5, 7:3), observationB = matrix(1:6, nrow=2)). 
# Для цього списку знайдіть sum за допомогою lapply.
list1 <- list(observationA = c(1:5, 7:3), observationB = matrix(1:6, nrow=2))
lapply(list1, sum)
# ------- 9 -------
# Для кожного елементу списку list1 знайдіть максимальне та мінімальне значення (range) за допомогою lapply та sapply.
lapply(list1, range)
sapply(list1, range)
# ------- 10 -------
# Для вбудованого набору даних InsectSprays знайти середнє count для кожного spray.
aggregate(
  x=list(mean=InsectSprays$count), 
  by=list(spray=InsectSprays$spray), 
  FUN=mean)