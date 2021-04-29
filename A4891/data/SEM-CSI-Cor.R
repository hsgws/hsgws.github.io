library(sem) #ライブラリの読み込み

#データの読み込み#
co <- readMoments(
  diag=TRUE, 
  names=c(
    "y01", "y02", "y03", "y04", "y05", "y06", 
    "y07", "y08", "y09", "y10"
  )
)
1
0.836 1
0.788 0.841 1
0.532 0.569 0.646 1
0.459 0.420 0.378 0.318 1
0.597 0.625 0.714 0.597 0.482 1
0.608 0.639 0.681 0.604 0.454 0.708 1
0.762 0.790 0.821 0.645 0.343 0.662 0.647 1
0.629 0.597 0.666 0.570 0.271 0.563 0.588 0.741 1
0.660 0.581 0.663 0.472 0.436 0.626 0.612 0.694 0.736 1




#モデルの作成#

#測定方程式
model <- specifyModel()
  知覚品質 -> y01, NA,  1　      #測定方程式, 識別性制約のため係数を１に固定
  知覚品質 -> y02, b12, NA
  知覚品質 -> y03, b13, NA
  知覚品質 -> y04, b14, NA
  顧客期待 -> y05, NA,  1
  顧客期待 -> y06, b22, NA
  顧客期待 -> y07, b23, NA
  顧客満足 -> y08, NA, 1
  顧客満足 -> y09, b32, NA
  顧客満足 -> y10, b33, NA
  y01 <-> y01, e01, NA　　　      #測定方程式の分散設定
  y02 <-> y02, e02, NA
  y03 <-> y03, e03, NA
  y04 <-> y04, e04, NA
  y05 <-> y05, e05, NA
  y06 <-> y06, e06, NA
  y07 <-> y07, e07, NA
  y08 <-> y08, e08, NA
  y09 <-> y09, e09, NA
  y10 <-> y10, e10, NA
  知覚品質     -> 顧客満足,  b1,NA    　　　#構造方程式
  顧客期待     -> 顧客満足,  b2,NA
  顧客期待     -> 知覚品質,  b4,NA
  知覚品質    <-> 知覚品質 , NA, 1            #構造方程式の分散設定
  顧客期待    <-> 顧客期待 , NA, 1
  顧客満足    <-> 顧客満足 , NA, 1

#分析と出力#
result <- sem(model,co,N=100) #モデル,相関係数, サンプル数の並び
summary(result,
        fit.indices = c("GFI", "AGFI", "RMSEA","NFI", "NNFI",
                        "CFI", "RNI", "IFI", "SRMR", "AIC",
                        "AICc", "BIC", "CAIC"))
stdCoef(result)　　 #標準解の表示

#パス図の作成#
pathDiagram(result, out.file="csi100-10.txt", ignore.double=FALSE, 
edge.labels="values", digits=3,
node.font=c("C:/WINDOWS/Fonts/msgothic.ttc",10)) 
