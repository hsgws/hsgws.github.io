#分析データとパッケージの読み込み
###########################################################################
library(lmerTest)
library(arm)
data1 <- read.csv("学校データ.csv")
###########################################################################


#ランダム切片・傾きモデル
#############################################################################
#モデルの実行
rismodel <- lmer(post1 ~ pre1.cwc +(1+pre1.cwc|schoolID),data=data1,REML=FALSE)
#分析結果の表示
summary(rismodel)
#ランダムパラメータの詳細表示
VarCorr(rismodel)
#固定効果の詳細表示
fixef(rismodel)
#固定効果の標準誤差
se.fixef(rismodel)
#信頼区間の算出
confint(rismodel,level=.95)
#############################################################################

#クロスレベル交互作用効果推定モデル1
#############################################################################
#説明変数の準備
pre2.mdev <- data1$pre2.m-mean(data1$pre2.m)
#モデルの実行
crosslevel<- lmer(post1 ~ pre1.cwc +　pre2.mdev +
pre1.cwc:pre2.mdev + (1 + pre1.cwc|schoolID),
data=data1,REML=FALSE)
#分析結果の表示
summary(crosslevel)
#ランダムパラメータの詳細表示
VarCorr(crosslevel)
#固定効果の詳細表示
fixef(crosslevel)
#固定効果の標準誤差
se.fixef(crosslevel)
#信頼区間の算出
confint(crosslevel,level=.95)
#############################################################################

#クロスレベル交互作用効果推定モデル2
#############################################################################
#説明変数の準備
pre2.mdev <- data1$pre2.m-mean(data1$pre2.m)
time2.dev <- data1$time2-mean(data1$time2) 
#モデルの実行
crosslevel2 <- lmer(post1 ~ pre1.cwc +　time2.dev + pre2.mdev + 
+ (pre1.cwc:time2.dev) +(pre1.cwc:pre2.mdev) +
+ (1 + pre1.cwc|schoolID),data=data1,REML=FALSE)
#分析結果の表示
summary(crosslevel2)
#ランダムパラメータの詳細表示
VarCorr(crosslevel2)
#固定効果の詳細表示
fixef(crosslevel2)
#固定効果の標準誤差
se.fixef(crosslevel2)
#信頼区間の算出
confint(crosslevel2,level=.95)
#############################################################################

#モデル比較
#############################################################################
#全モデルの適合度指標の算出
anova(anovamodel,rancovamodel,maomodel,bweffectmodel,rismodel,crosslevel)
#ネストモデルの尤度比検定
anova(anovamodel,maomodel,bweffectmodel,rismodel,crosslevel)
################################################################################