#負の二項回帰で用いるパッケージ「MASS」を読み込む.
library(MASS)
#ポアソン回帰モデル（オフセット変数無）のコマンド．教科書ではRコマンダー実施している．
#Model1 <- glm(y ~ x1 + x2 + x3 + x4 + x5 + x6, family=poisson(log),data=Dataset)
#summary(Model1)
#ポアソン回帰モデル（オフセット変数有）のコマンド．教科書ではRコマンダー実施している．
#Model2 <- glm(y ~ x1 + x2 + x3 + x4 + x5 + x6 + offset(log(k)),family=poisson(log), data=Dataset)
#summary(Model2)
#負の二項回帰モデル（オフセット変数無）のコマンド．
Model3 <- glm.nb(y ~ x1 + x2 + x3 + x4 + x5 + x6, link=log,data=Dataset)
summary(Model3)
#負の二項回帰モデル（オフセット変数有）のコマンド．
Model4 <- glm.nb(y ~ x1 + x2 + x3 + x4 + x5 + x6 + offset(log(k)), link=log,data=Dataset)
summary(Model4)
