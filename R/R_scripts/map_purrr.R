#' ---
#' title: "Funciones map_*, map2_* y pmap_*"
#' author: "Yolanda García Ruiz"
#' ---



library(purrr)
library(dplyr)


## ---------------------------------------------------------------------------------------------------
# Crear un tibble de ejemplo
df <- tibble(
  A = c(1, 2, 3, 4, 5),
  B = c(6, 7, 8, 9, 10),
  C = c(10, 11, 12, 13, 14)
)

print(df)


## ---------------------------------------------------------------------------------------------------
# Calcular la media de cada columna
map_dbl(df, mean)
# Calcular la media de cada columna usando el operador pipe
means <- df %>% 
  map_dbl(mean)


## ---------------------------------------------------------------------------------------------------
# Si queremos realizar la resta de columnas
nueva <-  map2_dbl(df$A, df$B, ~ .x - .y)
df <- mutate(df, dif = nueva)
df


## ---------------------------------------------------------------------------------------------------
# Restar los valores de la columna B a la columna A
df <- mutate(df, nueva =  map2_dbl(A, B, function(x, y) x - y))
df



## ---------------------------------------------------------------------------------------------------
# media por columnas
column_means <- df %>%
  summarise(across(everything(), mean))
column_means


## ---------------------------------------------------------------------------------------------------
# media por filas
# Los ... representan todos los argumentos que se están pasando a la función en cada fila.
# ..1 se usa para referirse a la primera columna
# ..2 se usa para referirse a la segunda columna
df <- df %>%
  mutate(Row_Mean = pmap_dbl(df, function(...) mean(c(...), na.rm= T)))
df


## ---------------------------------------------------------------------------------------------------
# suma de los valores  de las filas
df <- df %>%
  mutate(suma = pmap_dbl(df, ~ sum(c(...), na.rm=T)))
df

