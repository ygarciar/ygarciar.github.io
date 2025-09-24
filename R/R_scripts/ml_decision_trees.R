#' ---
#' title: "Clasificación con Decision Trees"
#' author: "Yolanda García Ruiz"
#' ---



library('tidymodels')
library('tidyverse')
library("caret")
library("rpart")
library("rpart.plot")

## -------------------------------------------------------------
## Aproximación inicial
## -------------------------------------------------------------


## Carga de datos
## --------------------------------------------------------------------------------------------
heart <- read_csv("./data/HeartDisease.csv", col_types = cols(edad = col_integer(), 
    presion_arterial = col_integer(), colesterol = col_integer(), 
    glucosa = col_integer(), max_frecuencia_cardiaca = col_integer(), 
    HeartDisease = col_character()))

heart <- mutate(heart, HeartDisease = as_factor(HeartDisease))
names(heart)


## --------------------------------------------------------------------------------------------
# Comprobar el tipo de las variables
slice_head(heart, n = 5)


# 
# 1. División en entrenamiento y test
## --------------------------------------------------------------------------------------------
split_inicial <- initial_split(
                    data   = heart,
                    prop   = 0.8,
                    strata = HeartDisease 
                 )
datos_train <- training(split_inicial)  # 80%
datos_test  <- testing(split_inicial)   # 20%


## --------------------------------------------------------------------------------------------
table(heart$HeartDisease)


## --------------------------------------------------------------------------------------------
table(datos_train$HeartDisease)


## --------------------------------------------------------------------------------------------
table(datos_test$HeartDisease)

## 2. Creación del modelo inicial
## --------------------------------------------------------------------------------------------
# creamos y entrenamos un modelo 
arbol_1 <- rpart(formula = HeartDisease ~ ., 
                 data = datos_train)
rpart.plot(arbol_1)


## --------------------------------------------------------------------------------------------
# importancia relativa de las variables utilizadas para dividir los nodos del árbol 
# as variables con mayor puntuación son aquellas que contribuyeron más a la predicción final.
arbol_1$variable.importance


## --------------------------------------------------------------------------------------------
barplot(arbol_1$variable.importance, 
        main = "Importancia de las variables",
        xlab = "Importancia", 
        #ylab = "Variables", 
        horiz = TRUE,  # Hacer las barras horizontales
        col = "lightblue",  # Color de las barras
        las = 1,  # Girar las etiquetas del eje Y para que sean legibles
        cex.names = 0.8)  # Ajustar el tamaño del texto


## 3. Validación
## --------------------------------------------------------------------------------------------
# Calculo las predicciones sobre los datos de test
prediccion_1 <- predict(arbol_1, newdata = datos_test, type = "class")
# Calculamos la matriz de confusión
confusionMatrix(prediccion_1, datos_test$HeartDisease)



## -----------------------------------------------------------------------------
## Repetimos el proceso con otro conjunto de entrenamiento
## -----------------------------------------------------------------------------

 
## -------------------------------------------------------------------------------------------
split_inicial <- initial_split(
                    data   = heart,
                    prop   = 0.8,
                    strata = HeartDisease
                 )
datos_train <- training(split_inicial)  # 80%
datos_test  <- testing(split_inicial)   # 20%

arbol_1 <- rpart(formula = HeartDisease ~ ., 
                 data = datos_train)
prediccion_1 <- predict(arbol_1, newdata = datos_test, type = "class")
confusionMatrix(prediccion_1, datos_test$HeartDisease)



## Hiperparámetros
## --------------------------------------------------------------------------------------------
# creamos y entrenamos un modelo 
arbol_2 <- rpart(formula = HeartDisease ~ ., 
                 data = datos_train,
                 control = list(minsplit = 10, 
                                maxdepth = 5, cp = 0.9 ))


prediccion_2 <- predict(arbol_2, newdata = datos_test,
                        type = "class")
confusionMatrix(prediccion_1, datos_test$HeartDisease)








## ---------------------------------------------------------------------
## Decision Tree con Tidymodels
## ---------------------------------------------------------------------


## --------------------------------------------------------------------------------------------
# FASE I : Búsqueda del mejor modelo
# ----------------------------------
# 1. División: entrenamiento y test
# =============================================
split_inicial <- initial_split(
                    data   = heart,
                    prop   = 0.8,
                    strata = HeartDisease
                 )
datos_train <- training(split_inicial)  # 80%
datos_test  <- testing(split_inicial)   # 20%

# 2. Preprocesado: Tratamiento de nulos, estandarizar, normalizar, eliminación de varaibles con varianza 0, etc.
# =============================================================================
# Se almacenan en un objeto `recipe` todos los pasos de preprocesado y, finalmente,
# se aplican a los datos.
# se encarga de definir cómo se transformarán los datos antes de ajustar el modelo
transformer <- recipe(
                  formula = HeartDisease ~ .,   # Fórmula
                  data =  datos_train           # datos de entrenamiento
               ) %>%
               step_naomit(all_predictors()) %>%
               step_nzv(all_predictors()) %>%
               step_center(all_numeric(), -all_outcomes()) %>%
               step_scale(all_numeric(), -all_outcomes()) %>%
               step_dummy(all_nominal(), -all_outcomes())


# 3. Configuramos el modelo a crear con hiperparámetros que se van a tunear.
# ==========================================================================
modelo_tree <- decision_tree(mode = "classification",      # árbol de decisión
                        tree_depth = tune(),               # Profundidad del árbol a tunear
                        min_n = tune()                     # Min. obs. por nodo a tunear
               ) %>%
               set_engine(engine = "rpart")                # implementación de la librería rpart

# 4. DEFINICIÓN DE LA ESTRATEGIA DE VALIDACIÓN Y CREACIÓN DE PARTICIONES
# =============================================================================
cv_folds <- vfold_cv(
              data    = datos_train,        # datos de entrenamiento sin procesar
              v       = 5,                  # 5 particiones
              strata  = HeartDisease        # Varaible respuesta
             )

# 5. EJECUCIÓN PARA LA BÚSQUEDA DE LOS MEJORES VALORES PARA LOS HIPERPARÁMETROS
# =============================================================================
grid_fit <- tune_grid(
              object       = modelo_tree,    # modelo del paso 3
              preprocessor = transformer,    # El objeto recipe (formula y pasos de preprocesado)
              resamples    = cv_folds,       # Información para cross-validation
              metrics      = metric_set(accuracy),                   # métrica de evaluación
              control      = control_grid(save_pred = TRUE),         # guarda las predicciones de cada fold.
              grid         = 70              # Número de combinaciones generadas automáticamente
            )


## --------------------------------------------------------------------------------------------
collect_metrics(grid_fit)


## --------------------------------------------------------------------------------------------
show_best(grid_fit, metric = 'accuracy')


## --------------------------------------------------------------------------------------------
grid_fit %>%
  collect_metrics(summarize = TRUE) %>%
  filter(.metric == "accuracy") %>%
  select(-c(.estimator, n)) %>%
  pivot_longer(
    cols = c(tree_depth, min_n),
    values_to = "value",
    names_to = "parameter"
  ) %>%
  ggplot(aes(x = value, y = mean, color = parameter)) +
  geom_point() +
  geom_line() + 
  labs(title = "Evolución de Accuracy en función de los hiperparámetros") +
  facet_wrap(facets = vars(parameter), nrow = 2, scales = "free") +
  theme_bw() + 
  theme(legend.position = "none")


## --------------------------------------------------------------------------------------------
mejores_hiperpar <- select_best(grid_fit, metric = "accuracy")
mejores_hiperpar


## --------------------------------------------------------------------------------------------
# 6. Creamos el modelo definitivo con los mejores hiperparámetros
# ====================================================================
modelo_tree_final <- finalize_model(x = modelo_tree, parameters = mejores_hiperpar)

# 7. Se aplican las transformaciones al conjunto de entrenamiento y de test
# =========================================================
datos_train_prep <- bake(prep(transformer), new_data = datos_train)
datos_test_prep  <- bake(prep(transformer), new_data = datos_test)

# 8. Se netrena el modelo con todos los datos de entrenamiento preprocesados
# ==============================================================================
modelo_tree_final_fit  <- modelo_tree_final %>%
                          fit(
                            formula = HeartDisease ~ .,
                            data    = datos_train_prep       # datos de entrenamiento preporcesados
                          )

# 9. Validación con el conjunto de test
# ==============================================================================
# calculamos las predicciones sobre el conjunto de test
predicciones <- modelo_tree_final_fit %>%
                predict(
                  new_data = datos_test_prep  # datos de test preporcesados
                ) %>% 
                bind_cols(datos_test_prep %>% select(HeartDisease))

accuracy(predicciones, truth = HeartDisease, .pred_class, na_rm = TRUE)







## --------------------------------------------------------------------------------------------
# FASE II. PRODUCCIÓN
# 1. Creamos el modelo productivo mediante un  flujo
# ====================================================================
modelo_productivo <- workflow() %>%
                        add_model(modelo_tree) %>%
                        add_recipe(transformer) %>%
                        finalize_workflow(  parameters = mejores_hiperpar ) %>%
                        fit( data = heart )



# 2. Guardar el modelo en disco para uso posterior
saveRDS(modelo_productivo, file = "model_dt.rds")

modelo_productivo


## --------------------------------------------------------------------------------------------
# 
# 3. Leer el modelo
# ==============================================================================
modelo_productivo <- readRDS("model_dt.rds")

# 4. Nuevas predicciones
# ======================
data_new <- tibble(edad=41, 
                       sexo="M",
                       tipo_dolor_torax="NAP",
                       presion_arterial=130,
                       colesterol=320,
                       glucosa=0,
                       ECG="Normal",
                       max_frecuencia_cardiaca=170,
                       angina_ejercicio="N",
                       depresion_ST=0.0,
                       segmento_ST="Up")



preds <- predict(modelo_productivo, data_new)
preds

