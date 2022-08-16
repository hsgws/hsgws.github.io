library(sem) #ライブラリの読み込み

#データの読み込み#
data <- read.table("CSIdata.txt", sep = ';', header = T)
co<- cor(data[,1:10])
co[upper.tri(co)] <- 0

#モデルの作成#

#測定方程式
　　#ラベル
model <- specifyModel()
  知覚品質 -> y1, NA,  1　      #測定方程式, 識別性制約のため係数を１に固定
  知覚品質 -> y2, b12, NA
  知覚品質 -> y3, b13, NA
  知覚品質 -> y4, b14, NA
  顧客期待 -> y5, NA,  1
  顧客期待 -> y6, b22, NA
  顧客期待 -> y7, b23, NA
  顧客満足 -> y8, NA, 1
  顧客満足 -> y9, b32, NA
  顧客満足 -> y10, b33, NA
  y1 <-> y1, e01, NA　　　      #測定方程式の分散設定
  y2 <-> y2, e02, NA
  y3 <-> y3, e03, NA
  y4 <-> y4, e04, NA
  y5 <-> y5, e05, NA
  y6 <-> y6, e06, NA
  y7 <-> y7, e07, NA
  y8 <-> y8, e08, NA
  y9 <-> y9, e09, NA
  y10 <-> y10, e10, NA
  知覚品質     -> 顧客満足,  b1,NA    　　　#構造方程式
  顧客期待     -> 顧客満足,  b2,NA
  顧客期待     -> 知覚品質,  b4,NA
  知覚品質    <-> 知覚品質 , NA, 1            #構造方程式の分散設定
  顧客期待    <-> 顧客期待 , NA, 1
  顧客満足    <-> 顧客満足 , NA, 1

#分析と出力#
result <- sem(model,co,N=100) #モデル,相関係数 or 共分散行列,サンプル数の並び
summary(result,
        fit.indices = c("GFI", "AGFI", "RMSEA","NFI", "NNFI",
                        "CFI", "RNI", "IFI", "SRMR", "AIC",
                        "AICc", "BIC", "CAIC"))
stdCoef(result)　　 #標準解の表示

#因子スコアの計算#
fs2<-fscores(result,data)

#パス図の作成#
pathDiagram(result, out.file="csi.txt", ignore.double=FALSE, 
edge.labels="values", digits=3,
node.font=c("C:/WINDOWS/Fonts/msgothic.ttc",10)) 

#満足度得点の計算と表示#
cscore<- (fs2[,1]-min(fs2[,1]))/(max(fs2[,1])-min(fs2[,1]))*100
hist(cscore)
mscore<- mean(cscore)
mscore
