#' ---
#' title: "Limpieza de datos (duplicados, missing, outliers"
#' author: "Yolanda García Ruiz"
#' ---




library(tidyverse)


## ---------------------------------------------------------------------------------------------------
# Crear un data frame
acciones <- tibble(
  anio = c(NA, 2015, 2015, 2015, 2015,2016, 2016, 2016, 2017),
  trimestre = c(1, NA, 4, 4, 2, 3, 3, NA, 3),
  retorno = c(1.88, 0.59, 0.35, NA, 0.92, 0,  0.00, 5.66, -3)
)
acciones


## ---------------------------------------------------------------------------------------------------
# Filas completamente duplicadas
duplicated(acciones)


## ---------------------------------------------------------------------------------------------------
# filas duplicadas en base a las dos primeras columnas
duplicated(select(acciones, -retorno))


## ---------------------------------------------------------------------------------------------------
# Selección de las filas no duplicadas:
filter(acciones, !duplicated(select(acciones, -retorno)))


## ---------------------------------------------------------------------------------------------------
# Eliminar duplicados basados en las columnas A y B
distinct(acciones, anio, trimestre, .keep_all = T)


## ---------------------------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------------------------



## ----message=FALSE, warning=FALSE-------------------------------------------------------------------
library(dlookr)


## ---------------------------------------------------------------------------------------------------
# comprobar que la columna retorno tiene un outlier
diag <- diagnose_numeric(acciones)
diag


## ---------------------------------------------------------------------------------------------------
G$
  
  
  


## ---------------------------------------------------------------------------------------------------
# preguntamos por los atípicos
atipicos <- g$out
atipicos


## ---------------------------------------------------------------------------------------------------
# aplicamos un filtro para seleccionar lo no atípicos
filter(acciones, !(retorno %in% atipicos))


## ----message=FALSE, warning=FALSE-------------------------------------------------------------------
library(dplyr)


## ---------------------------------------------------------------------------------------------------
# Crear un data frame con NA
acciones <- tibble(
  anio = c(NA, 2015, 2015, 2015, 2016, 2016, 2016),
  trimestre = c(1, NA, 3, 4, 2, 3, NA),
  retorno = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)
acciones


## ---------------------------------------------------------------------------------------------------
is.na(acciones)  # Devuelve una matriz lógica


## ---------------------------------------------------------------------------------------------------
# Contar NA en cada columna de un dataframe
colSums(is.na(acciones))
# Contar NA en cada fila de un dataframe
rowSums(is.na(acciones))


## ---------------------------------------------------------------------------------------------------
filter(acciones, !(is.na(retorno)))


## ----message=FALSE, warning=FALSE-------------------------------------------------------------------
library(tidyr)


## ---------------------------------------------------------------------------------------------------
# Borrado de filas con algún NA
drop_na(acciones)


## ---------------------------------------------------------------------------------------------------
# Borrado de filas con algún NA en las columnas anio y retorno
drop_na(acciones, c(anio,retorno))


## ---------------------------------------------------------------------------------------------------
mutate(acciones, retorno = if_else(is.na(retorno), 0, retorno))


## ---------------------------------------------------------------------------------------------------
library(tidyr)
mutate(acciones, retorno = replace_na(retorno, 0))


## ---------------------------------------------------------------------------------------------------
mutate(acciones, 
       retorno = if_else(is.na(retorno), mean(retorno, na.rm =T), retorno))


## ---------------------------------------------------------------------------------------------------
data_frame <- data.frame(
  A = c(1, 2, NA, 4),
  B = c(NA, 2, 3, 4),
  C = c(5, NA, NA, 8)
)

# Rellenar NAs en cada columna con un valor específico
data_filled <- data_frame %>%
                mutate(A = ifelse(is.na(A), -1, A),
                       B = ifelse(is.na(B), -2, B),
                       C = ifelse(is.na(C), -3, C))

# Ver el resultado
data_filled


## ---------------------------------------------------------------------------------------------------
# Crear una función personalizada para reemplazar NA por el valor medio de la columna
replace_na_with_mean <- function(column) {
  column[is.na(column)] <- mean(column, na.rm = TRUE)
  return(column)
}

# Aplicar la función a todas las columnas
mutate(acciones, across(everything(), replace_na_with_mean))

# Aplicar la función a las columnas deseadas
mutate(acciones, across(c(retorno), replace_na_with_mean))


## ---------------------------------------------------------------------------------------------------
# Calcular la suma de una columna en un data frame, omitiendo NA
sum(data_frame$A, na.rm = TRUE)
mean(data_frame$A, na.rm = TRUE)


## ---------------------------------------------------------------------------------------------------
fill
fill(acciones, retorno)
fill(acciones, retorno, .direction = 'up')


## ---------------------------------------------------------------------------------------------------
library("caret")
# Se realiza el preprocesamiento(dataframe en lugar de tibble)
a <- as.data.frame(acciones)
pre_knn <- preProcess(a, method = "knnImpute", k = 2)
# Se obtienen los datos
imputed_knn <- predict(pre_knn, a)
# Se comprueba que se ha imputado el valor faltante 
rowSums(is.na(imputed_knn))


## ---------------------------------------------------------------------------------------------------
imputed_knn


## ---------------------------------------------------------------------------------------------------
# Se realiza el preprocesamiento: 
pre_median <- preProcess(acciones, method = "medianImpute") 
# Se obtienen los datos 
imputed_median <- predict(pre_median, acciones) 
# Se comprueba que se ha imputado el valor faltante 
imputed_median


## ---------------------------------------------------------------------------------------------------
library(readxl)
clientes <- read_excel("../data/clientes.xlsx", 
    sheet = "Hoja2")
mutate(clientes, nueva = 1:7)


## ---------------------------------------------------------------------------------------------------
library(stringr)
mutate(clientes, NUMBER = str_remove(CODCLI, 'CLI-'))


