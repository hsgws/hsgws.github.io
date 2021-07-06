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
model.sem <- specifyEquations(covs = )