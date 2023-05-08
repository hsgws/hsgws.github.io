### LDA(トピックモデル)
#①パッケージ"lda"のインストール
# install.packages("lda")
library(lda)
# Windows版R-4.2.0から，デフォルトの文字コードがUTF-8となりました。
# 一方で，MeCabの公式Windowsバイナリはデフォルトの文字コードはShift-Jisです。
# そのためWindows版R-4.2.0に対応したRMeCabを使用するためには，
# https://github.com/ikegami-yukino/mecab/releases/tag/v0.996にあるバイナリを利用する必要があります。
# 詳しくは以下のページでご確認ください。https://github.com/IshidaMotohiro/RMeCab/issues/20
library(RMeCab)
library(dplyr) 
library(tidyverse)
##
## 文章の処理

#②レビューデータの読み込み
reviews <- read_csv('tablet3.csv', col_names =F ) #<-違うレビューに変更可能

#Col1. No. Col2.Text Col3.Rating
colnames(reviews) <- c("No.","コメント","評価")

reviews %>% head(10)

rate <- reviews$評価

# 前処理
cleansing_text <- function(text){ 
  #正規表現を使ったテキストデータの前処理
  cleaned_text <- text %>% 
    str_to_lower() %>% 
    str_remove_all("https?://.*[a-zA-Z0-9#]") %>%
    str_replace_all("[\\-,.!?_…・×、。「」\\(\\)\\【\\】＃＠@]", "") %>%      #③不要な記号類の除去
    str_squish() %>% #スペースを統合
    #iconv(from="UTF-8",to="CP932") # Encodingの変換（Mecabで処理するため）
  
  return(cleaned_text)        
}

cleaned_texts <- unlist( lapply(reviews$コメント, cleansing_text) )
rate <- rate[!is.na(cleaned_texts)] #<- 評価の行を揃える
cleaned_texts <- cleaned_texts[!is.na(cleaned_texts)]


cleaned_texts %>% head()

#④MeCabによる形態素解析実行による名詞および形容詞のみの抽出
lda.doc <-  lapply(cleaned_texts, RMeCabC)

only_norm_adj <- function(text){
  text <- unlist(text)
  text <- c( text[names(text)=="名詞"], text[names(text)=="形容詞"])
  new <- text %>% unlist %>% unname 
  return(new)
}
unlist(lda.doc[[1]]) #%>%  iconv(from="CP932",to="UTF-8")
lda.doc <- lapply(lda.doc, only_norm_adj)


#lapply <- str_remove_all(lda.doc[[3]], "」")

#⑤意味のない単語の除外
Remove_list = c("なら","から", "に","れ","し","よ", "いる","い","て",
                "た","てる","ん","ず","でき","と","か","あり","ある","が",
                "で","は","の","／","き","まで", "！", "/", "よう", "ので",
                "｣", ":","）","（","を", "なる","な","や","的","#","|","､","%")

rm_word <- function(text, rm_list){ 
  for(word in rm_list){
    text = text[text!=word]
  }
  
  return(text)        
}
lda.doc2 <- lapply(lda.doc, rm_word, Remove_list)　#不要単語の削除

lda.doc2 %>% head(50)

l.comment <- lexicalize(lda.doc2) #辞書化


#⑥LDAの実行
k = 5 #トピックの数

set.seed(0)

lda.result <- lda.collapsed.gibbs.sampler(l.comment$documents,
                                          k,
                                          l.comment$vocab,
                                          500,
                                          0.1, #alpha
                                          1/k, #beta
                                          compute.log.likelihood = TRUE)


#Top 単語
(top.words = top.topic.words(lda.result$topics,10,by.score = TRUE)) 

#トピック分布
N <- 1:10
topic.proportions <- t(lda.result$document_sums) / colSums(lda.result$document_sums)
topic.proportions <- topic.proportions[N, ]
topic.proportions[is.na(topic.proportions)] <-  1 / k

#⑦上位トップワードを用いて列名をつけて意味付けを行う。
colnames(topic.proportions) <- apply(top.words, 2, paste, collapse=" ")
par(mfrow=c(1,1))
par(mar=c(5, 16, 2, 2))

#⑦10の文書におけるトピック割合を表示
#for(i in 1:k) colnames(topic.proportions)[i] <- paste('Topic', i)
#par(mfrow=c(1,1))
#par(mar=c(5, 5, 2, 2))

barplot(topic.proportions, beside=TRUE, horiz=TRUE, las=1, xlab="proportion")

par(mar=c(5, 10, 5, 5))
barplot(rowSums(lda.result$document_sums/sum(lda.result$document_sums)),xlab="Topic",ylab="Prop",ylim=c(0,0.4),main="Topic Distribution")

#列名作り
coln <- c()
for(i in 1:k) coln[i]=paste("Topic", i)

axis(1,at=1:k,labels=coln)




############ 応用　トピック分布と評価の回帰分析
#⑧トピックを説明変数とするトピック回帰モデルの推定
# Rating分布を確認
barplot(table(rate), main='Rating')

#文章毎のトピック分布
topic.proportions <- t(lda.result$document_sums) / colSums(lda.result$document_sums)



colnames(topic.proportions) = coln

# y ~ x (ratingとトピック分布を結合）
df <- data.frame(cbind(rate, topic.proportions[,1:(k-1)])) #<- 多重共線性の問題を避けるため、最後のトピックを抜く
#colnames(df)[2] = 'Intercept' # Intercept
df %>% head()


res <- lm(rate ~.,data=df)
summary(res)

#解釈：Topic2（容量、画質）に満足、Topic３(バッテリー、充電問題）に不満？

(top.words = top.topic.words(lda.result$topics,10,by.score = TRUE)) 
