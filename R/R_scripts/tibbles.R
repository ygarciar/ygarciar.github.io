#' ---
#' title: "Dataframes (tibbles)"
#' author: "Yolanda García Ruiz"
#' ---



# --------------------------------------------------------
## Carga de librerías
#---------------------------------------------------------
library(tibble)
library(dplyr)

library(readr)        # carga de la librería para leer ficheros 
library(stringr)      # para trabajar con strings





## ---------------------------------------------------------------------------------------------------
# Creación de un tibble (dataframe)
## --------------------------------------------------------
edad <- c(20,45, 34)
altura <- c(1.56,1.72, 1.9)
sexo <- c('Male','Male', 'Female')


tb <-tibble(edad, altura, sexo)
tb






## ---------------------------------------------------------------------------------------------------
# Creación de un dataframe a partir de un fichero de datos
## --------------------------------------------------------
filmin <- read_csv("../data/filmin.csv", n_max = 80)
filmin


## --------------------------------------------------------
## Características generales de dataframes
# ---------------------------------------------------------------------------------------------------
# Dimensión de un dataframe
dim(filmin)


## ---------------------------------------------------------------------------------------------------
# Número de columnas
length(filmin)
ncol(filmin)


# Número de filas
nrow(filmin)

# Nombres de las columnas
colnames(filmin)


## ---------------------------------------------------------------------------------------------------
View(filmin)







## --------------------------------------------------------
## Operaciones
## --------------------------------------------------------

# primeros estadísticos
## --------------------------------------------------------
summary(filmin)


# Acceso a una columna
## -----------------------------------------
filmin$Genero


## Frecuencia de los valores de una columna
# ----------------------------------------
# frecuencia
table(filmin$Genero)

# distintos valores existentes en la columna genero
unique(filmin$Genero)








## Transformación de datos con la biblioteca dplyr
## -------------------------------------------------------------------------

### Operaciones con filas: FILTER. SLICE_HEAD, SLICE_TAIL, SLICE_SAMPLE, ARRANGE
---------------------------------------------------------------------------------
filter(filmin, Genero == 'Drama')


## ---------------------------------------------------------------------------------------------------
filter(filmin, (Genero == 'Drama') & (Valoracion > 6))


## ---------------------------------------------------------------------------------------------------
df <-filter(filmin, Genero %in% c('Romántica' , 'Comedia'))
df




## ---------------------------------------------------------------------------------------------------
# mostrar un número determinado de filas
slice_head(filmin, n=2)  # muestra las 2 primeras filas

## ---------------------------------------------------------------------------------------------------
# muestra el 50% de las ultimas filas
slice_tail(filmin, prop=0.5)    


## ---------------------------------------------------------------------------------------------------
# obtiene una muestra aleatoria de n filas (o proporción prop)
set.seed(1)  # Para que la muestra aleatoria sea reproducible
slice_sample(filmin, n = 3) 



## --------------------------------------------------------
# Ordenación
## --------------------------------------------------------

## ---------------------------------------------------------------------------------------------------
# Ordenar ascendente de 'número' y luego descendente de  'sexo' 
df_ordenado <- arrange(filmin,  Anio, desc(Valoracion))
print(df_ordenado)


## ---------------------------------------------------------------------------------------------------
# Ordenar descendente de 'número' y luego ascendente de 'Genero' 
df_ordenado <- arrange(filmin,  desc(Anio), Genero)
print(df_ordenado)





# Operaciones con columnas: SELECT, MUTATE, RENAME
## ---------------------------------------------------------------------------------------------------
a <- select(filmin, 2, 1)
slice_tail(a, n = 7)



## ---------------------------------------------------------------------------------------------------
a <- select(filmin, "Valoracion", "Genero")
slice_head(a, n = 5)


## ---------------------------------------------------------------------------------------------------
a <- select(filmin, 2:4)
slice_tail(a, n = 5)


## ---------------------------------------------------------------------------------------------------
inicio <-length(filmin)-2
fin <- length(filmin)
a <- select(filmin, inicio:fin)
slice_tail(a, n = 5)


## ---------------------------------------------------------------------------------------------------
a <- select(filmin, -(inicio:fin))
slice_tail(a, n = 5)


## ---------------------------------------------------------------------------------------------------
a <- select(filmin, starts_with("Ge"))
tail(a)


## ---------------------------------------------------------------------------------------------------
a <- select(filmin, ends_with("o"))
slice_tail(a, n = 5)


## ---------------------------------------------------------------------------------------------------
a <- select(filmin, contains("i"))
slice_tail(a, n = 5)




## -------------------------------------------
## mutate
## ---------------------------------------------------------------------------------------------------


filmin <- mutate(filmin, 
        redondeo = round(Valoracion),  # nueva 
        escala5 = Valoracion / 2,      # nueva 
        Year  = as.character(Anio),    # modificamos el tipo de columna fecha   
        YY = str_sub(Year, 3, 4),      # nueva 
        Anio = NULL)                 # BORRADO DE COLUMNA


## ---------------------------------------------
slice_head(filmin, n = 10)


## --------------------------------------------

filmin <- rename(filmin, 'Round' = redondeo)
select(filmin, 5:6)


## --------------------------------------------
nuevos_nombres <- c(Title = 'Titulo', 
                    Rate = 'Valoracion',
                    Genre = 'Genero')

filmin_2 <- rename(filmin, all_of(nuevos_nombres))
slice_head(filmin_2, n=5)









# Operaciones de resumen y agrupación: GLIMPSE, sumarise y group_by

## ---------------------------------------------------------------------------------------------------
# Resumen de la estructura de un dataframe
glimpse(filmin)


## ---------------------------------------------------------------------------------------------------
# para crear resúmenes de variables en un dataframe
# argumento na.rm que puede ser establecido en TRUE para omitir valores 
# NA en los cálculos

summarise(filmin, media_val=mean(Valoracion , na.rm = TRUE),
                  count = n(),    #número de filas
          )



## ---------------------------------------------------------------------------------------------------
summarise(filmin, 
          count_years = n_distinct(Year),   # Número de años distintos
          total = n(), # número de filas
          media = mean(Valoracion, na.rm = TRUE),# media de las valoraciones
          min_val = min(Valoracion, na.rm = TRUE),
          max_val = max(Valoracion))  


## ---------------------------------------------------------------------------------------------------
# EJEMPLO 1: el número de valoraciones por  Genero,
grupos <- group_by(filmin, Genero)
summarise(grupos, 
          media = mean(Valoracion, na.rm =T))


## ---------------------------------------------------------------------------------------------------
# USANDO PIPES %>%
# EJEMPLO 1: el número de valoraciones por  Genero,
resultado <- filmin %>% 
                group_by(Genero) %>%
                summarise(media = mean(Valoracion, na.rm =T))
resultado




## ---------------------------------------------------------------------------------------------------
# EJEMPLO 2: el número de valoraciones por Anio y Genero,
grupos <- group_by(filmin, Year, Genero)
res <-summarise(grupos, 
            numero_registros = n(),    # cuenta
            q25 = quantile(Valoracion, 0.25, na.rm = T), 
            .groups = 'drop')
res



#  Operador pipe  %>%    -------------------------------
## -----------------------------------------------------
# EJEMPLO 3: 
t1 <- select(filmin, -Titulo)
t2 <- filter(t1, Year %in% c(2017, 2015) )
t3 <- group_by(t2, Periodo = Year, Categoria = Genero )
t4 <- summarise(t3, total = sum(Valoracion, na.rm =T),
                    media = mean(Valoracion, na.rm =T),
                .groups = 'drop')

t4


## ---------------------------------------------------------------------------------------------------
# EJEMPLO 3: USANDO PIPES
t4 <- filmin %>% 
           select(-Titulo) %>%
           filter(Year %in% c('2017', '2015') ) %>%
           group_by(Periodo = Year, Categoria = Genero ) %>%
           summarise(total = sum(Valoracion, na.rm =T) ,
                     media = mean(Valoracion, na.rm =T),
                     .groups = 'drop')

t4






# Sobre los Valores NA
## ---------------------------------------------------------------------------------------------------
# Número de NA's en cada una de las columnas
colSums(is.na(filmin))

# Representación gráfica
barplot(colSums(is.na(filmin)))


## ---------------------------------------------------------------------------------------------------
summarise(filmin, media = mean(Valoracion))


## ---------------------------------------------------------------------------------------------------
# argumento na.rm que puede ser establecido en TRUE para omitir valores 
# NA en los cálculos
summarise(filmin, media = mean(Valoracion, na.rm = T))

