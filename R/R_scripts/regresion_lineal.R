#' ---
#' title: "Regresión lineal"
#' author: "Yolanda García Ruiz"
#' ---

## ==============================================================
## Ejemplo 1   
## ==============================================================

library(ggplot2)
library(dplyr)
library(readr)
library(ggpubr)
library(patchwork)


## Carga de datos

income_data <- read_csv("./data/income_data.csv", 
    col_types = cols(...1 = col_skip()))
income_data


## Scater plot para comprobar si se muestra una relación lineal
## entre la variable explicativa y la variable respuesta.

ggplot(income_data, aes(x = income, y = happiness    )) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Ingresos", y = "Nivel de satisfacción") 


## -----------------------------------------------------------------------------------
## 1. Construcción del modelo usando lm() por mínimos cuadrados ordinarios
income_lm <- lm(happiness ~ income,
                data = income_data)

## resumen completo
summary(income_lm)


## -----------------------------------------------------------------------------------
## 2. Validación del modelo 
## 2.1. Análisis de los residuos
# 
library("ggfortify")
autoplot(income_lm) +
  theme_minimal()
# Scale-Location: utilizado para evaluar la homocedasticidad (varianza constante de los errores)
# Residuals vs Fitted: permite detectar patrones en los residuos que podrían indicar problemas en el modelo. 
#                      utilizado para evaluar la linealidad y la homocedasticidad
# leverage: utilizado para detectar valores atípicos


## -----------------------------------------------------------------------------------
# contrastar normalidad con Shapiro-Wilk
# Si p-value > 0.05 no se rechaza la hipótesis de normalidad
shapiro.test(income_lm$residuals)


## -----------------------------------------------------------------------------------
# Contrastar la homocedasticidad con Breusch-Pagan
lmtest::bptest(income_lm)
# Si p-value > 0.05 no se rechaza la hipótesis de homocedasticidad


## 2.2. Análisis de normalidad de la variable respuesta
ggplot(income_data) +
  geom_histogram(mapping = aes(happiness))


## -----------------------------------------------------------------------------------
## 3. Realizar predicciones
# Creamos nuevos datos
nuevo <- tibble(income=c(3.9, 4.6))
# Calculamos las predicciones con la función predict()
nuevo <- mutate(nuevo, 
                happiness = predict(income_lm, nuevo, interval = "confidence"))  
nuevo




## ==============================================================
## Ejemplo 2   
## ==============================================================


## Carga de datos 
## -----------------------------------------------------------------------------------
data <- airquality
slice_head(data, n= 5)


## Vamos a dibujar mediante nube de puntos (scatter plot) y 
##      linea de regresión la relación que existe entre cada 
##      variable explicativa con la variable respuesta.
## ---------------------------------------------------
g1 <-ggplot(data, aes(x= Solar.R, y= Ozone)) +
  geom_point()+
  geom_smooth(method='lm')
g2 <-ggplot(data, aes(x= Wind, y= Ozone)) +
  geom_point()+
  geom_smooth(method='lm')
g3 <-ggplot(data, aes(x= Temp, y= Ozone)) +
  geom_point()+
  geom_smooth(method='lm')

g1 + g2 + g3



## Vamos a crear un modelo de regresión múltiple
## -----------------------------------------------------------------------------------
airq_lm <- lm(Ozone ~ Solar.R + Wind + Temp, 
              data = airquality)
summary(airq_lm)

## -----------------------------------------------------------------------------------
## 2. Validación del modelo 
## 2.1. Análisis de los residuos
## -----------------------------------------------------------------------------------
library("ggfortify")
autoplot(airq_lm) +
  theme_minimal()

## -----------------------------------------------------------------------------------
# Contraste Shapiro-Wilk  para ver la normalidad
# Si p-value > 0.05 no se rechaza la hipótesis de normalidad
shapiro.test(airq_lm$residuals)
# Se confirma la falta de normalidad de residuos
#       (p-value = 0.0000036 < 0.05) 

## -----------------------------------------------------------------------------------
# Contraste Breusch-Pagan para ver la homocedasticidad
lmtest::bptest(airq_lm)
#     No se rechaza la hipótesis de homocedasticidad (p-valor > 0,05).


## 2.2. Análisis de normalidad de la variable explicativa
## -----------------------------------------------------------------------------------
ggplot(airquality, aes(x=Ozone)) + 
  geom_histogram(color= 'black', fill= 'red')




## 2.3. Análisis de correlación entre variables explicativas
## -----------------------------------------------------------------------------------
# (a) Se pueden representar gráficos 2 a 2 de las variables explicativas,
#   para comprobar si están o no correlacionadas
library("GGally")
ggpairs(airquality[, 2:4])


# (b) Conviene calcular también los factores de inflación de la varianza (VIF),
# que indican el incremento de la varianza estimada del 
# coeficiente de regresión de una determinada variable explicativa
# como consecuencia de la colinealidad con las demás
## -----------------------------------------------------------------------------------
car::vif(airq_lm)

# Si VIF está entre 1 y 5, la correlación es moderada y no provoca graves problemas.
# Si VIF es mayor que 5, la correlación es fuerte y las estimaciones de los coeficientes
# y los p–valores resultantes de la estimación del modelo no sean confiables.

