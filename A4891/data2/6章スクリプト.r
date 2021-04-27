#6章分析スクリプト


#6.1節
#データの読み込み
data2<-read.csv("職場データ.csv",header=T)

#集団平均の計算
(work2.m<-ave(data2$work1,data2$company))

#集団平均中心化
(work1.cwc<-data2$work1-work2.m)

#全平均による中心化
(work1.cgm<-data2$work1-mean(data2$work1))


#6.2節
#幸福度の集団平均の計算
hap2.m<-ave(data2$hap1, data2$company)

#幸福度の集団平均と就業時間の集団平均中心化後の値との相関
cor(hap2.m, work1.cwc)

#就業時間の集団平均と就業時間の集団平均中心化後の値との相関
cor(work2.m, work1.cwc)

#企業サイズと就業時間の集団平均中心化後の値との相関
cor(data2$size2, work1.cwc)


#6.3節
#幸福度の集団平均と就業時間の全体平均中心化後の値との相関
cor(hap2.m, work1.cgm)

#就業時間の集団平均と就業時間の全体平均中心化後の値との相関
cor(work2.m, work1.cgm)

#企業サイズと就業時間の全体平均中心化後の値との相関
cor(data2$size2, work1.cgm)


#6.5節
#レベル2の説明変数の全体平均中心化
size2.cgm<-data2$size2-mean(data2$size2)

#ランダム切片+企業サイズ・傾きモデル
#使用するパッケージの読み込み
library(lmerTest)

#CWC
RIS_cwc1 <- lmer(hap1 ~ work1.cwc + size2.cgm + (1 + work1.cwc | company),data=data2, REML=FALSE)
summary(RIS_cwc1)

#CGM
RIS_cgm1 <- lmer(hap1 ~ work1.cgm + size2.cgm + (1 + work1.cgm | company),data=data2, REML=FALSE)
summary(RIS_cgm1)

#RAW
RIS_raw1 <- lmer(hap1 ~ work1 + size2.cgm + (1 + work1 | company),data=data2, REML=FALSE)
summary(RIS_raw1)


#レベル2の説明変数の中心化
work2.cgm<-work2.m-mean(work2.m)

#ランダム切片+集団平均・傾きモデル                      

#CWC
RIS_cwc2 <- lmer(hap1 ~ work1.cwc + work2.cgm + (1 + work1 | company),data=data2, REML=FALSE)
summary(RIS_cwc2)

#CGM
RIS_cgm2 <- lmer(hap1 ~ work1.cgm + work2.cgm + (1 + work1.cgm | company),data=data2, REML=FALSE)
summary(RIS_cgm2)

#RAW
RIS_raw2 <- lmer(hap1 ~ work1 + work2.cgm + (1 + work1 | company),data=data2, REML=FALSE)
summary(RIS_raw2)


#6.8節
#ランダム切片・傾きモデル                      
RIS_raw <- 
lmer(hap1 ~ work1 + (1 + work1 | company), data=data2, REML=FALSE)
summary(RIS_raw)

#ランダム切片・傾きモデル                      
RIS_cgm <- 
lmer(hap1 ~ work1.cgm + (1 + work1.cgm | company), data=data2, REML=FALSE)
summary(RIS_cgm)


#ランダム切片+集団平均・傾きモデル                      
RIS_raw <- lmer(hap1 ~ work1 + work2.cgm + (1 + work1 | company), data=data2, REML=FALSE)
summary(RIS_raw)

#ランダム切片+集団平均・傾きモデル                      
RIS_cgm <- lmer(hap1 ~ work1.cgm + work2.cgm + (1 + work1.cgm | company), data=data2, REML=FALSE)
summary(RIS_cgm)

#ランダム切片+集団平均・傾きモデル                      
RIS_cwc <- lmer(hap1 ~ work1.cwc + work2.cgm + (1 + work1.cwc | company), data=data2, REML=FALSE)
summary(RIS_cwc)
