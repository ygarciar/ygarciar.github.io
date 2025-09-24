#' ---
#' title: "Combinación de dataframes en R"
#' author: "Yolanda García Ruiz"
#' ---


## ---------------------------------------------------------------------------------------------------
library(dplyr)


## ---------------------------------------------------------------------------------------------------

t1 <- tibble(
  País = c('Estonia', 'Estonia', 'Ireland', 'Spain'),
  Cantidad = c(8.4, 6.7, 227, 58.9),
  Producto = c('A', 'B', 'A', 'Z')
)

# Definir los datos del segundo tibble
t2 <- tibble(
  Producto = c('A', 'B', 'C'),
  Descripción = c('Leche', 'Cereales', 'Aceite')
)


## ---------------------------------------------------------------------------------------------------
t1
t2


## -----------------------------------------------------
# Operaciones de la familia join
## ---------------------------------------------------------------------------------------------------
result <- inner_join(t1, t2, by = "Producto")
result


## ---------------------------------------------------------------------------------------------------
result <- left_join(t1, t2, by = "Producto")
result


## ---------------------------------------------------------------------------------------------------
result <- right_join(t1, t2, by = "Producto")
result


## ---------------------------------------------------------------------------------------------------
result <- full_join(t1, t2, by = "Producto")
result


## ---------------------------------------------------------------------------------------------------
result <- anti_join(t1, t2, by = "Producto")
result




## ----------------------------------------------------------------------------
# Combinación con distintos nombres de columnas o/y varias columnas de combinación
## ---------------------------------------------------------------------------------------------------
# 
t1 <- tibble(
  Country = c('Estonia', 'Estonia', 'Ireland', 'Spain'),
  Amount = c(8.4, 6.7, 227, 58.9),
  ProductCode = c('A', 'B', 'A', 'Z')
)

# Tibble 2
t2 <- tibble(
  ProductID = c('A', 'B', 'C'),
  Description = c('Leche', 'Cereales', 'Aceite')
)


## ---------------------------------------------------------------------------------------------------
result <- full_join(t1, t2, 
        by = c("ProductCode" = "ProductID"))
result


## ---------------------------------------------------------------------------------------------------

# Cantidad de producción por año y país
t1 <- tibble(
  Country = c('Estonia', 'Estonia', 'Ireland', 'Spain'),
  Year = c(2020, 2021, 2020, 2021),
  Amount = c(8.4, 6.7, 227, 58.9)
)

# Productos en producción por año y país
t2 <- tibble(
  Country = c('Estonia', 'Estonia', 'Ireland'),
  Period = c(2020, 2021, 2020),
  Product = c('Leche', 'Cereales', 'Leche')
)


## -----------------------------------------------------------------
result <- full_join(t1, t2, by = c("Country", "Year" = "Period"))
result





## ------------------------------------------------------------------
# Unión de dataframes con bind_rows()
## ------------------------------------------------------------------
# Crear dos data frames
grupo1 <- data.frame( nombre = c("Juan", "Ana", "Luis"),
                     edad = c(12, 15, 34), nota = c(10,9, 8))
grupo2 <- data.frame( nombre = c("María", "José", "Luis"),
                     edad = c(25, 32, NA))

# Usar bind_rows() para combinarlos
resultado <- bind_rows(grupo1, grupo2)

resultado





## ------------------------------------------------------------------------
# Operaciones de conjunto
## -----------------------------------------------------------------------

## ---------------------------------------------------------------------------------------------------
pyme1 <- tibble(
  Country = c('Estonia', 'Estonia', 'Ireland', 'Spain'),
  Year = c(2020, 2021, 2020, 2021),
  Amount = c(8.4, 6.7, 227, 58.9)
)

pyme2 <- tibble(
  Country = c('Francia', 'Italia', 'Spain'),
  Year = c(2021,  2021, 2021),
  Amount = c(60.2, 12.4, 58.9)
)



# operación de conjunto unión (sin repeticiones)
union(pyme1, pyme2)


## ---------------------------------------------------------------------------------------------------
intersect(pyme1, pyme2)


## ---------------------------------------------------------------------------------------------------
setdiff(pyme1, pyme2)

