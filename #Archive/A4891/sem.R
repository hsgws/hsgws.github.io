library(lavaan)

model <- "
  hw =~ Portability + Liquid_crystal
  sp =~ Image + Functionality + Operability + Battery
  ds =~ Design + Hold_feeling
  Total ~ hw + sp + ds
"

fit <- sem(model, data = data_camera, orthogonal = TRUE)
fit <- sem(model, data = data_camera)

summary(fit, fit.measures = TRUE, standardized = TRUE)


library(sem)
#model.sem <- specifyEquations(covs = )

library(lavaan)

model <- "
  tech =~ After_Sales_Service + Technology + Space_comfort + Safety + Fuel_Type
  price =~ Price + Resale_Value + Fuel_Efficiency + Maintenance
  ride =~ Exterior_Looks + Test_drive + Product_reviews + Testimonials
  price ~ tech
  ride ~ tech + price
"

fit <- sem(model, data = data_car)
summary(fit, fit.measures = TRUE, standardized = TRUE)
