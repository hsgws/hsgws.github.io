#第4章ランダム切片モデルスクリプト

#分析データとパッケージの読み込み
###########################################################################
library(lmerTest)
library(arm)
data1 <- read.csv("学校データ.csv")
###########################################################################

#ANOVAモデル
#############################################################################
#モデルの実行
anovamodel <- lmer(post1 ~(1|schoolID),data=data1,REML=FALSE)
#分析結果の表示
summary(anovamodel)
#ランダムパラメータの詳細表示
VarCorr(anovamodel)
#固定効果の詳細表示
fixef(anovamodel)
#固定効果の標準誤差
se.fixef(anovamodel)
#信頼区間の算出
confint(anovamodel,level=.95)
#############################################################################

#RANCOVAモデル
#############################################################################
#モデルの実行
rancovamodel <- lmer(post1~pre1.cgm + (1|schoolID),data=data1,REML=FALSE)
#分析結果の表示
summary(rancovamodel)
#ランダムパラメータの詳細表示
VarCorr(rancovamodel)
#固定効果の詳細表示
fixef(rancovamodel)
#固定効果の標準誤差
se.fixef(rancovamodel) 
#信頼区間の算出
confint(rancovamodel)

#モデルの実行
rancovamodel2 <- lmer(post1~pre1.cwc + (1|schoolID),data=data1,REML=FALSE)
#分析結果の表示
summary(rancovamodel2)
#ランダムパラメータの詳細表示
VarCorr(rancovamodel2)
#固定効果の詳細表示
fixef(rancovamodel2)
#固定効果の標準誤差
se.fixef(rancovamodel2)
#信頼区間の算出
confint(rancovamodel2)

#############################################################################

#平均に関する回帰モデル
#############################################################################
#説明変数の定義
pre2.mdev <- data1$pre2.m-mean(data1$pre2.m)
#モデルの実行
maomodel <- lmer(post1~pre2.mdev + (1|schoolID),data=data1,REML=FALSE)
#分析結果の表示
summary(maomodel)
#ランダムパラメータの詳細表示
VarCorr(maomodel)
#固定効果の詳細表示
fixef(maomodel)
#固定効果の標準誤差
se.fixef(maomodel)
#信頼区間の算出
set.seed(321)#シードの設定
confint(maomodel,method="boot",level=.95)  
#############################################################################

#集団・個人レベル効果の推定
#############################################################################
#モデルの実行
bweffectmodel <- lmer(post1 ~ pre1.cwc + pre2.mdev + (1|schoolID),data=data1,REML=FALSE)
#分析結果の表示
summary(bweffectmodel)
#ランダムパラメータの詳細表示
VarCorr(bweffectmodel)
#固定効果の詳細表示
fixef(bweffectmodel)
#固定効果の標準誤差
se.fixef(bweffectmodel)
#信頼区間の算出
confint(bweffectmodel)
#############################################################################
