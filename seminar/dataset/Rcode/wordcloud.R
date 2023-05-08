####### ワードクラウド


# RMecabで形態素解析
# 1)　https://taku910.github.io/mecab/  <-ここでMecabの最新バージョンをダウンロード
# 2)  install.packages("RMeCab", repos = "http://rmecab.jp/R", type = "source")1

library(RMeCab)
library(ggplot2)
library(dplyr)

#①保存されたデータの読み込み
cleaned_texts <- read.csv('cleaned_text.csv',fileEncoding = 'shift-jis',row.names = 1)
cleaned_texts %>% head()

# サンプル
RMeCabC(cleaned_texts[1])

#②頻度集計
Freqs = RMeCabDF( data.frame(paste(cleaned_texts,collapse = " ")) )[[1]]

#③名詞、形容詞に絞って分析
Freqs = c(Freqs[names(Freqs) == "名詞"],Freqs[names(Freqs) == "形容詞"]) 

Ordered_Freq <- table(Freqs)[order(table(Freqs), decreasing=T ) ]

#④頻度情報を用いてワードクラウドを作成

#require(devtools)
#install_github("lchiffon/wordcloud2")
library(wordcloud2)
df <- data.frame(Ordered_Freq)
df$Freqs <- as.character(df$Freqs)

#　ワードクラウド　（時間がかかる）
wordcloud2(df[1:100,],  size=2, color = "random-dark")


#⑤共起ネットワークを構築
ngram <- NgramDF('tmp.txt',type =1, N=2)

#　上位の共起単語
ngram %>% 
  arrange(desc(Freq)) %>% 
  head(10)

#install.packages('igraph')
library(igraph)

# igraphで共起ネットワークを構築

par(mar=c(0.1,0.1,0.1,0.1))

ngram %>%
  filter(ngram$Freq>=10) %>% #10回以上出現する共起語
  graph.data.frame(directed = F) %>% 
  plot(vertex.size=3, 
       vertex.label=V(.)$name,
       vertex.label.font=1,
       vertex.label.cex=1,
       vertex.frame.color="red",
       family="HiraKakuPro-W3",
       vertex.label.dist=0)#ノードとラベルとの距離


