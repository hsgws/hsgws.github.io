library(arules)
class(y)
y.tran<-as(as.matrix(y),"transactions")
rules <- apriori(y.tran, parameter= list(supp=0.4, conf=0.5))
print(rules)
inspect(head(SORT(rules, by = "lift"),n=20))

