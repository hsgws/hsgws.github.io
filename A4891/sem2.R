library(semPLS)

data("mobi")
model <- "
  image =~ IMAG1 + IMAG2 + IMAG3 + IMAG4 + IMAG5
  expectaion =~ CUEX1 + CUEX2 + CUEX3
  quality =~ PERQ1 + PERQ2 + PERQ3 + PERQ4 + PERQ5 + PERQ6
  value =~ PERV1 + PERV2
  satisfaction =~ CUSA1 + CUSA2 + CUSA3
  complaints =~ CUSCO
  loyalty =~ CUSL1 + CUSL2 + CUSL3
  
  expectaion ~ image
  quality ~ expectaion
  value ~ expectaion + quality
  satisfaction ~ image + expectaion + quality + value
  complaints ~ satisfaction
  loyalty ~ image + satisfaction + complaints
"

library(lavaan)
fit <- sem(model, data = mobi)
summary(fit, fit.measures = TRUE, standardized = TRUE)
