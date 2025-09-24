#' ---
#' title: "Manejo de fechas con Lubridate en R"
#' author: "Yolanda García Ruiz"
#' ---


# carga del paquete
library(lubridate)    # para manejo de fechas
library(dplyr)
library(readr)


# Para obtener la fecha o fecha-hora actual
## ---------------------------------------------------------------------------------------------------
today()
now()



# Podemos crear fechas a partir de un string o números sin comillas
## ---------------------------------------------------------------------------------------------------
ymd("2022-02-20")    # año, mes, día
dmy(31012024)   # día, mes , año

## ---------------------------------------------------------------------------------------------------
ymd_hms("2017-01-31 20:11:59")







# Obtener componentes de una fecha
## ---------------------------------------------------------------------------------------------------
# dada la fecha actual
fecha <- now()
fecha


## ---------------------------------------------------------------------------------------------------
# Trimestre
quarter(fecha)

# preguntamos por el mes
month(fecha)

# preguntamos por el nombre mes 
month(fecha, label = T, abbr = FALSE)
year(fecha)
day(fecha)
hour(fecha)





# Redondeos de fechas
## ---------------------------------------------------------------------------------------------------
floor_date(fecha, unit = "week")   # devuelve el lunes anterior

## ---------------------------------------------------------------------------------------------------
ceiling_date(fecha, unit = "week")   # devuelve el lunes posterior







## ---------------------------------------------------------------
# Fechas en dataframes (tibbles)
## ---------------------------------------------------------------------------------------------------
fight_data <- read_delim("../data/fight_data.csv", 
              delim = ";" ,
              col_select = c("R_fighter","last_round_time" ,"date" ))
head(fight_data)


## ---------------------------------------------------------------------------------------------------
mdy('June 08, 2019')


## ---------------------------------------------------------------------------------------------------

fight_data <- mutate(fight_data, fecha = mdy(date))
fight_data


## ---------------------------------------------------------------------------------------------------

mini_vuelos <- read_csv("../data/mini_vuelos.csv")
slice_head(mini_vuelos, n =10)

# En caso de que la información de fecha se encuentre en el dataframe dividida
# en varias columnas, podemos usar la función make_date()
## ---------------------------------------------------------------------------------------------------
mini_vuelos <- mutate(mini_vuelos, nueva_fecha = make_date(anio, mes, dia))
mini_vuelos

