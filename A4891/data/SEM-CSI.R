library(sem) #CuÌÇÝÝ

#f[^ÌÇÝÝ#
data <- read.table("CSIdata.txt", sep = ';', header = T)
co<- cor(data[,1:10])
co[upper.tri(co)] <- 0

#fÌì¬#

#ªèûö®
@@#x
model <- specifyModel()
  moi¿ -> y1, NA,  1@      #ªèûö®, ¯Ê«§ñÌ½ßWðPÉÅè
  moi¿ -> y2, b12, NA
  moi¿ -> y3, b13, NA
  moi¿ -> y4, b14, NA
  ÚqúÒ -> y5, NA,  1
  ÚqúÒ -> y6, b22, NA
  ÚqúÒ -> y7, b23, NA
  Úq« -> y8, NA, 1
  Úq« -> y9, b32, NA
  Úq« -> y10, b33, NA
  y1 <-> y1, e01, NA@@@      #ªèûö®ÌªUÝè
  y2 <-> y2, e02, NA
  y3 <-> y3, e03, NA
  y4 <-> y4, e04, NA
  y5 <-> y5, e05, NA
  y6 <-> y6, e06, NA
  y7 <-> y7, e07, NA
  y8 <-> y8, e08, NA
  y9 <-> y9, e09, NA
  y10 <-> y10, e10, NA
  moi¿     -> Úq«,  b1,NA    @@@#\¢ûö®
  ÚqúÒ     -> Úq«,  b2,NA
  ÚqúÒ     -> moi¿,  b4,NA
  moi¿    <-> moi¿ , NA, 1            #\¢ûö®ÌªUÝè
  ÚqúÒ    <-> ÚqúÒ , NA, 1
  Úq«    <-> Úq« , NA, 1

#ªÍÆoÍ#
result <- sem(model,co,N=100) #f,ÖW or ¤ªUsñ,TvÌÀÑ
summary(result,
        fit.indices = c("GFI", "AGFI", "RMSEA","NFI", "NNFI",
                        "CFI", "RNI", "IFI", "SRMR", "AIC",
                        "AICc", "BIC", "CAIC"))
stdCoef(result)@@ #WðÌ\¦

#öqXRAÌvZ#
fs2<-fscores(result,data)

#pX}Ìì¬#
pathDiagram(result, out.file="csi.txt", ignore.double=FALSE, 
edge.labels="values", digits=3,
node.font=c("C:/WINDOWS/Fonts/msgothic.ttc",10)) 

#«x¾_ÌvZÆ\¦#
cscore<- (fs2[,1]-min(fs2[,1]))/(max(fs2[,1])-min(fs2[,1]))*100
hist(cscore)
mscore<- mean(cscore)
mscore
