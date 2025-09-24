#' ---
#' title: "Manejo de fechas con Lubridate en R"
#' author: "Yolanda García Ruiz"
#' ---
#-----------------------------------------------------
# instalar librería tidyverse si no está ya instalada
if (!"tidyverse" %in% rownames(installed.packages())) {
  cat("La librería tidyverse se va a instalar...\n")
  install.packages("tidyverse")
} else {
    cat("La librería tidyverse está instalada.\n")
}

if (!"datos" %in% rownames(installed.packages())) {
  cat("La librería datos se va a instalar...\n")
  install.packages("datos")
} else {
    cat("La librería datos está instalada.\n")
}


# ----------------------
# cargar la librerías
library(tidyverse)
library(plotly)       # para gráficos interactivos
library(datos)        # conjunto de datos con los que vamos a trabajar


## ----------------------------------------------------------------------------------------------------------------------------
millas


## ----------------------------------------------------------------------------------------------------------------------------
# Lo asignamos a un objeto con el mismo nombre
millas <- millas


## ----------------------------------------------------------------------------------------------------------------------------
help(millas)


# -------------------------------------------
## 1. lienzo -----------------------------------
# -------------------------------------------
# Crea el lienzo donde se dibujarán los datos
ggplot(data = millas)


# -------------------------------------------
## 2. Propiedades estéticas a las variables
# -------------------------------------------
# aes en la función ggplot
ggplot(data = millas, aes(x = cilindrada,
                          y = autopista))


# -------------------------------------------
## 3. Capa de geometría (puntos)
# -------------------------------------------

ggplot(data = millas, aes(x = cilindrada, y = autopista)) +
  geom_point()


# -------------------------------------------
## 4. Capa de geometría (puntos)
#     Propiedad color para la variable clase
# -------------------------------------------
# aes en capa geom. 
# x    : cilindrada
# y    : autopista
# color: clase
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, 
                           y = autopista, 
                           color = clase))


# --------------------------------------------------
## 5. Capa de geometría (puntos)
#     Todos los puntos iguales : color fuera de aes
# -------------------------------------------------

ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, 
                           y = autopista), 
             color = 'blue')


# --------------------------------------------------
## 6. Capa de geometría (puntos)
#     Forma de los puntos: shape
# -------------------------------------------------
# forma específica para todos los puntos
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, 
                           y = autopista, 
                           color = clase),
             shape = 4)



# --------------------------------------------------
## 7. Capa de geometría (puntos)
#     Tamaño de los puntos: size
# -------------------------------------------------
ggplot(data = millas) +
  geom_point(aes(x = cilindrada, 
                 y = autopista, 
                 size = cilindros),
             color = "coral")

# Para ver la gama de colores:
demo("colors")



# --------------------------------------------------
## 8. Capa labs (títulos y etiquetas)
#     
# -------------------------------------------------
g <-ggplot(millas, aes(x = cilindrada, 
                       y = ciudad, 
                       color = clase)) +
  geom_point() +
  labs(
    title = "Relación entre cilindrada y Consumo en ciudad",
    subtitle = "Consumo de combustible de varios modelos de autos",
    x = "Cilindrada del Motor",
    y = "Recorrido en ciudad (millas por galón)",
    color = "Tipo de Vehículo",
    caption = "Fuente: Dataset millas"
  )
g


## ------------------------------------------------------------
p <-ggplotly(g)
p

htmlwidgets::saveWidget(p, "grafico_interactivo.html", selfcontained = TRUE)

# ------------------------------------------------------------------------------------
## 8. Capa facets 
#     facet_wrap() : Crea una matriz de subgráficos para una única variable categórica
#                    de facetado. 
#                    Cada valor de la variable tiene su propio subgráfico.
# -------------------------------------------------------------------------------------
# Gráfico de dispersión con facetas  para cada clase de vehículo
ggplot(millas, aes(x = cilindrada, y = ciudad)) +
  geom_point() +
  facet_wrap(~ traccion) +
  labs(
    title = "Relación entre Cilindrada y Consumo en Ciudad",
    x = "Cilindrada",
    y = "Consumo en Ciudad (millas por galón)"
  )


# ------------------------------------------------------------------------------------
## 9. Capa facets 
#     facet_grid() : Crea una cuadrícula de subgráficos basados en una o dos variables
#                    de facetado
# -------------------------------------------------------------------------------------
# Gráfico de dispersión con facetas para combinaciones de combustible  y tracción
ggplot(millas, aes(x = cilindrada, y = ciudad, color = clase)) +
  geom_point() +
  facet_grid(combustible ~ traccion) 



# ------------------------------------------------------------------------------------
## 10. Capa Themes : estilo de gráfico: colores, líneas y bordes, títulos, fondo, ...
#
# -------------------------------------------------------------------------------------
ggplot(millas, aes(x = cilindrada, y = ciudad, color = clase)) +
  geom_point() +
  facet_grid(combustible ~ traccion) +
  theme_bw()


## ----------------------------------------------------------------------------------------------------------------------------
ggplot(millas, aes(x = clase, y = ciudad)) +
  geom_point() +
  labs(
    title = "Relación clase - eficiencia en ciudad",
    x = "Clase de vehículo",
    y = "eficiencia en ciudad"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold", color = "blue"),  # Título más grande y en negrita
    axis.title.y = element_text(size = 20),
    axis.title.x = element_text(size = 10),  # # Tamaño del texto de los ejes
    axis.text = element_text(color = "red"),  # Color rojo para los números de los ejes
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.background = element_rect(fill = "white"),  # Fondo blanco en el panel
    plot.background = element_rect(fill = "lightyellow")  # Fondo amarillo claro para todo el gráfico
  )


# ------------------------------------------------------------------------------------
## TIPOS DE GRÁFICOS
# -------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------------
## 1. BARRAS (VARIABLE DISCRETA)
# -------------------------------------------------------------------------------------
# eje y se muestra el recuento (count)
ggplot(data=millas)+
  geom_bar(mapping=aes(x=clase), 
          # stat = "count"              # estadística por defecto
           )


## ----------------------------------------------------------------------------------------------------------------------------
# eje y se muestra una proporción
ggplot(data = millas) +
  geom_bar(mapping = aes(x = clase, 
                         y = after_stat(prop), 
                         group = 1))

# ------------------------------------------------------------------------------------
## 2. BARRAS (VARIABLE DISCRETA) - Propiedad : fill para el color de relleno
# -------------------------------------------------------------------------------------
ggplot(data=millas)+
  geom_bar(mapping=aes(x=traccion, fill = clase) )

# ------------------------------------------------------------------------------------
## 3. BARRAS (VARIABLE DISCRETA) - Propiedad : fill para el color de relleno
# -------------------------------------------------------------------------------------
# Posición de las barras
ggplot(data=millas)+
  geom_bar(mapping=aes(x=traccion, fill = clase),
           position = 'dodge')



## ----------------------------------------------------------------------------------------------------------------------------
ggplot(data=millas)+
  geom_bar(mapping=aes(x=traccion, fill = clase),
           color = 'black',
           position = 'dodge')


# ------------------------------------------------------------------------------------
## 4. HISTOGRAMA (VARIABLE CONTINUA) 
# -------------------------------------------------------------------------------------
ggplot(data=millas)+
  geom_histogram(mapping=aes(x=autopista) ) +
  labs(title = "Distribución de Autonomía en autopista",
       x = "Autonomía en Carretera (mpg)",
       y = "Frecuencia") 

# ------------------------------------------------------------------------------------
## 5. HISTOGRAMA (VARIABLE CONTINUA)  - Propiedad fill: para diferenciar por una varaible
# -------------------------------------------------------------------------------------

# millas recorridas por litro de combustible en autopista 
ggplot(data=millas)+
  geom_histogram(mapping=aes(x=autopista, fill = traccion)) +
  labs(title = "Distribución de Autonomía en autopista",
       x = "Millas recorridas por litro en autopista",
       y = "Frecuencia") 



# ------------------------------------------------------------------------------------
## 6. DENSIDAD (VARIABLE CONTINUA)  - Propiedad fill: para diferenciar por una variable
# -------------------------------------------------------------------------------------
# El eje y representa la densidad en lugar de los conteos. 
# Si sumas el área de todas las barras, dará 1.
ggplot(data = millas, aes(x = autopista)) +
  geom_histogram(aes(y = after_stat(density)))+
  geom_density( alpha = 0.5,
               fill = 'red') +
  labs(title = "Distribución de Densidad de Autonomía en autopista",
       x = "Millas recorridas por litro en autopista",
       y = "Densidad") 


# ------------------------------------------------------------------------------------
## 7. DENSIDAD (VARIABLE CONTINUA)  - Propiedad fill: para diferenciar por una variable
# -------------------------------------------------------------------------------------
ggplot(data = millas) +
  geom_density(aes(x = autopista, fill = traccion),
               alpha = 0.7) +
  labs(title = "Distribución de Densidad de Autonomía en autopista",
       x = "Millas recorridas por litro en autopista",
       y = "Densidad") 



# ------------------------------------------------------------------------------------
## 8. Scatter Plot - Diagramas de dispersión
# -------------------------------------------------------------------------------------
ggplot(data = millas) +
  geom_point(mapping = aes(x = cilindrada, 
                           y = autopista, 
                           color = clase))


## ----------------------------------------------------------------------------------------------------------------------------
ggplot(data = millas) +
  geom_point(aes(x = ciudad, y = autopista, color = traccion),
             alpha = 0.7) +
  labs(title = "Relación entre Millas por Galón en Ciudad y autopista",
       x = "Millas por Galón en Ciudad",
       y = "Millas por Galón en autopista",
       color = "Tracción")

# ------------------------------------------------------------------------------------
## 9. Líneas de tendencia
# geom_smooth() se utiliza para agregar líneas de tendencia
# o curvas de suavizado 
# -------------------------------------------------------------------------------------
ggplot(data=millas)+
  geom_point(mapping=aes(x=ciudad, y=cilindrada), color="Blue") +
  geom_smooth(mapping=aes(x=ciudad, y=cilindrada), color="Red") +
  labs(title = "Relación entre consumo en Ciudad y \ncilindrada con Línea de Tendencia",
       x = "Millas por Galón en Ciudad",
       y = "Cilindrada del motor")


# ------------------------------------------------------------------------------------
## 10. Líneas de tendencia
# geom_smooth() se utiliza para agregar líneas de tendencia o curvas de suavizado 
#
# loess(suavizado local): Para una relación no lineal. 
# LOESS realiza ajustes en segmentos locales de los datos, 
# lo que permite capturar patrones no lineales.
# lm (regresión lineal): Para una relación lineal
## ----------------------------------------------------------------------------------------------------------------------------
ggplot(data=millas)+
  geom_point(mapping=aes(x=ciudad, y=cilindrada), color="Blue") +
  geom_smooth(mapping=aes(x=ciudad, y=cilindrada),
              method = 'lm',
              color="Red") +
  labs(title = "Relación entre consumo en Ciudad y \ncilindrada con Línea de Tendencia",
       x = "Millas por Galón en Ciudad",
       y = "Cilindrada del motor")


## ----------------------------------------------------------------------------------------------------------------------------
ggplot(data=millas)+
  geom_point(mapping=aes(x=ciudad, y=cilindrada), color="Blue") +
  geom_smooth(mapping=aes(x=ciudad, y=cilindrada),
              level = 0.95,   # nivel de confianza
              color="Red")



# ------------------------------------------------------------------------------------
## 11. BARRAS - Una variable discreta y una continua
## ----------------------------------------------------------------------------------
# calculo la media de millas recorridas en ciudad 
# por clase de vehículo
eficiencia <- millas %>%
  group_by(clase) %>% 
  summarise(recorrido_medio = mean(ciudad))
eficiencia


## ----------------------------------------------------------------------------------------------------------------------------
ggplot(data = eficiencia) +
  geom_col(aes(x = clase, y = recorrido_medio),
          fill = "skyblue", 
          color = "black") +
  labs(title = "Recorrido Promedio por clase de vehículo",
       x = "Clase de vehículo",
       y = "Recorrido Promedio (Millas)")

# ------------------------------------------------------------------------------------
## 12. BARRAS Y ETIQUETAS
## ----------------------------------------------------------------------------------
ggplot(data = eficiencia) +
  geom_col(aes(x = clase, 
               y = recorrido_medio),
           fill = "skyblue", color = "black") +
  geom_text(aes(x = clase, 
                y = recorrido_medio,
                label = round(recorrido_medio, 2)), vjust = 1.5
            ) +
  labs(title = "Recorrido Promedio por clase de vehículo",
       x = "Clase de vehículo",
       y = "Recorrido Promedio (Millas)")



# ------------------------------------------------------------------------------------
## 13. CAJAS Y BIGOTES - Una variable continua
## ----------------------------------------------------------------------------------
# Diagrama de cajas y bigotes para la variable continua ciudad
ggplot(data = millas) +
  geom_boxplot(aes(x = ciudad), 
               color = "black", outlier.colour = "red") 



## ----------------------------------------------------------------------------------------------------------------------------
# Diagrama de cajas y bigotes para la variable continua ciudad
# por clase de vehículo
ggplot(data = millas) +
  geom_boxplot(aes(x = clase, 
                   y = ciudad), 
               outlier.colour = "red") 



## ----------------------------------------------------------------------------------------------------------------------------
g <- ggplot(data = millas) +
        geom_point(aes(x = cilindrada, 
                       y = autopista, 
                       color = clase))
p <-ggplotly(g)
#htmlwidgets::saveWidget(p, "grafico_interactivo.html", selfcontained = TRUE)
show(p)

