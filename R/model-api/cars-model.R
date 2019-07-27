# Build simple model 
library(xgboost)
## ---- model
# Model ---- (insert fancy model here)
ANZSIC = 123
xgb_model <- xgb.load("xgboost.model")
newdata <- xgb.DMatrix(matrix(ANZSIC))
predict(xgb_model, newdata)

cars_model <- lm(mpg~cyl+hp, data = mtcars)
# Save model ----
saveRDS(cars_model, here::here("R", "model-api", "cars-model.rds"))
