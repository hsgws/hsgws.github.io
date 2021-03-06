#3章分析スクリプト


#3.1節
#学校データの読み込み
data1<-read.csv("学校データ.csv",header=T)

#級内相関係数の求め方

library(ICC)

ICCest(as.factor(schoolID), post1, data=data1, alpha=0.05, CI.type=("Smith"))


#3.3節
#集団平均の計算
(data1$pre2.m<-ave(data1$pre1,data1$schoolID))

#集団平均中心化
(data1$pre1.cwc<-data1$pre1-data1$pre2.m)

#全体平均による中心化
(pre1.cgm<-data1$pre1-mean(data1$pre1))


#3.6節
#データ内に3つの集団がある場合を想定
set.seed(10)

#集団jのβ0j
beta1<-1
beta2<-2
beta3<-3

#各集団のデータ。rijの分散は1
group1<-beta1+rnorm(20,0,1)
group2<-beta2+rnorm(20,0,1)
group3<-beta3+rnorm(20,0,1)

data<-c(group1,group2,group3)

par(mfrow=c(1,2))
#acfは自己相関関数を表示するための関数
acf(data,lag.max=25)
acf(group1,lag.max=20)


#3.7節
#級内相関係数の信頼区間の求め方（THD）
ICCest(as.factor(schoolID), post1, data=data1, alpha=0.05, CI.type=("THD"))


#3.8節
#n=10，ICC≒0.05の場合のスクリプトです。
#以下のオブジェクトnとbbx0jsdに代入する値を変えれば
#他のケースについてもシミュレーションを行うことができます。

library(lmerTest)
set.seed(1000)

N<-50
n<-10 #n=100のときはn<-100とする

#yのICCが0.05の場合
bbx0jsd<-1.2
#yのICC=0.05の場合，bbx0jsd<-1.2とする
#yのICC=0.1の場合，bbx0jsd<-1.7とする
#yのICCが0.15の場合，bbx0jsd<-2.2とする

nrep<-1000
res<-matrix(0, nrow<-nrep, ncol<-16)

for(i in 1:nrep)
{
r<-rnorm(n*N,0,10) #レベル1の方程式の誤差
uu0<-rnorm(N,0,2) #レベル2の切片の方程式の誤差
u0<-rep(uu0, each=n)
uu1<-rnorm(N,0,2) #レベル2の傾きの方程式の誤差
u1<-rep(uu1, each=n)
xx<-rep(1:N, each=n) #集団ID
g00<-10 #レベル2の切片の方程式の切片（固定母数）
g01<--10 #レベル2の切片の方程式の傾き（固定母数）
g10<-10 #レベル2の傾きの方程式の切片（固定母数）
bbx0j<-rnorm(N,0,bbx0jsd) #説明変数の方程式のランダム切片。この分散を上記で変更する。
bx0j<-rep(bbx0j, each=n)
rxij<-rnorm(n*N,0,5) #説明変数の方程式の誤差
x<-bx0j+rxij #説明変数の作成
x.cwc<-x-ave(x,xx) #説明変数の集団平均中心化
y<-(g00+g01*ave(x,xx)+u0)+(g10+u1)*x.cwc+r #目的変数の作成

RIy <- lmer(y ~ (1 | xx), REML=FALSE)
summary(RIy)

by<-summary(RIy)$varcor$xx[1]
wy<-summary(RIy)$sigma^2
res[i,1]<-by/(by+wy) #目的変数の級内相関係数
res[i,2]<-by/(by+wy/n) #目的変数の集団平均の信頼性

RIx <- lmer(x ~ (1 | xx), REML=FALSE)
bx<-summary(RIx)$varcor$xx[1]
wx<-summary(RIx)$sigma^2
res[i,3]<-bx/(bx+wx) #説明変数の級内相関係数
res[i,4]<-bx/(bx+wx/n) #説明変数の集団平均の信頼性
res[i,5]<-(bx/(bx+wx))/(bx/(bx+wx/n))

RIS <- lmer(y ~ x.cwc + ave(x,xx) + (1 + x.cwc | xx), REML=FALSE)
#summary(RIS)

res[i,6]<-summary(RIS)$coef[2]
res[i,7]<-summary(RIS)$coef[3]
#summary(RIS)$conv

res[i,8]<-lm(y ~ x)$coef[2]
res[i,9]<-lm(ave(y,xx) ~ ave(x,xx))$coef[2]
res[i,16]<-summary(lm(ave(y,xx) ~ ave(x,xx)))$coef[4]
#plot(x,y)
res[i,10]<-res[i,6]-g10
res[i,11]<-res[i,7]-g01
res[i,12]<-res[i,8]-g10
res[i,13]<-res[i,9]-g01
res[i,14]<-summary(lm(ave(y,xx) ~ ave(x,xx)))$coef[4]

res[i,15]<-0
if(sum(c(as.numeric(RIS@optinfo$conv$lme4$code),1))-1==0)
{
res[i,15]<-1
}

if(by*wy*bx*wx==0)
{
res[i,15]<-0
}


}
#結果
round(c(apply(subset(res, res[,15]==1),2,mean),nrow(subset(res, res[,15]==1))),2)

