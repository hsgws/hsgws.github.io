#2章分析スクリプト


#2.5節
#学校ごとの単回帰分析
data1<-read.csv("学校データ.csv",header=T)

school1<-subset(data1, data1$schoolID==1)
school2<-subset(data1, data1$schoolID==2)
school3<-subset(data1, data1$schoolID==3)

summary(lm(post1~pre1, data=school1))$coef
summary(lm(post1~pre1, data=school2))$coef
summary(lm(post1~pre1, data=school3))$coef
