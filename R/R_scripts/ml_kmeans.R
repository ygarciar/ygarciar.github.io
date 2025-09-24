#' ---
#' title: "Clasificación con Decision Trees"
#' author: "Yolanda García Ruiz"
#' ---


library(tidyverse)


# CArga de datos
CCAAagregados <- read_csv("../data/CCAAagregados.csv" )

## --------------------------------------------------------------------------------------------
slice_head(CCAAagregados, n= 5)


## --------------------------------------------------------------------------------------------
# Los datos para kmeans usa solo las columnas numéricas 
datoskm <- CCAAagregados %>%
  select(-c(CCAA, descripcion )) %>%
  scale() %>%            # normalización de las variables
  as_tibble()            # convertir en tibble
datoskm


## --------------------------------------------------------------------------------------------
# asignamos una semilla para garantizar la aleatoriedad de la primera asignacion
set.seed(123)
## Creamos los clusteres mediante kmeans 
k <- 4
modelo_kmeans <- kmeans(datoskm, centers = k)         # k = centers
#observamos los resultados y la calidad de los mismos
modelo_kmeans


## --------------------------------------------------------------------------------------------
#INERCIA ENTRE GRUPOS:  mayor es mejor
modelo_kmeans$betweenss
#INERCIA INTRA GRUPOS:  menor es mejor
modelo_kmeans$withinss
#INERCIA TOTAL INTRA GRUPOS:  menor es mejor
modelo_kmeans$tot.withinss



## --------------------------------------------------------------------------------------------
#representamos los resultados
comunidades<-CCAAagregados$descripcion
grupo<-modelo_kmeans$cluster
datosc<-tibble(comunidades, grupo)
library(ggplot2)
ggplot(datosc)+
  geom_point(mapping=aes(x=grupo, y=comunidades),color=grupo, size=5)


## --------------------------------------------------------------------------------------------
## Creamos los clusteres mediante kmeans 
k <- 6
modelo_kmeans <- kmeans(datoskm, centers = k)         # k = centers
#observamos los resultados y la calidad de los mismos
#INERCIA ENTRE GRUPOS:  mayor es mejor
modelo_kmeans$betweenss
#INERCIA INTRA GRUPOS:  menor es mejor
modelo_kmeans$withinss
#INERCIA TOTAL INTRA GRUPOS:  menor es mejor
modelo_kmeans$tot.withinss


## --------------------------------------------------------------------------------------------
comunidades<-CCAAagregados$descripcion
grupo<-modelo_kmeans$cluster
datosc<-tibble(comunidades, grupo)
library(ggplot2)
ggplot(datosc)+
  geom_point(mapping=aes(x=grupo, y=comunidades),color=grupo, size=5)


## --------------------------------------------------------------------------------------------
set.seed(123)
inercia <- numeric()  # Vector para guardar within-cluster sum of squares

# Calcular k-means para k entre 1 y 10 clústeres
for (k in 1:10) {
  kmeans_result <- kmeans(datoskm, centers = k, nstart = 25) # el algoritmo se ejecute 25 veces con diferentes posiciones iniciales de los clústeres y seleccione el mejor resultado
  inercia[k] <- kmeans_result$tot.withinss  # Guardar la suma de cuadrados dentro de los clústeres
}

# Graficar el método del codo
ggplot() + 
  geom_point(aes(x = 1:10, y = inercia), color = 'blue') + 
  geom_line(aes(x = 1:10, y = inercia), color = 'blue') + 
  ggtitle("Método del Codo") + 
  xlab('Cantidad de Centroides k') + 
  ylab('inercia (tot.withinss)')

