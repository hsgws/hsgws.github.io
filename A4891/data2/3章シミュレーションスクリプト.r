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

