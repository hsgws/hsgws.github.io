##############
# テキストスクレイピングおよび前処理ーTwitterデータを例として

#①パッケージのインストール
#install.packages('rtweet', 'tidyverse')
#install.packages('tidyverse')
#install.packages('dplyr',dependencies = T)
library(rtweet) 　#<-ツイートアカウント必要
library(tidyverse)
library(dplyr)
#②ツイートをスクレイピング
# キーワードを決め、1000件のツイートを獲得
tweets <- search_tweets("経済", n = 1000)  #2022/01/13　実行

# データの確認
tweets %>% head()
tweets$text %>% head()

# 保存
write_as_csv(tweets, "tweets_sample2.csv",fileEncoding = "SHIFT-JIS")

# 読み込み
read_twitter_csv("tweets_sample.csv")


#③ テキスト以外の不要な記号などを削除（stringrを使った前処理）
library(stringr)

texts = tweets$text

cleansing_text <- function(text){ 
  #正規表現を使ったテキストデータの前処理
  cleaned_text <- text %>% 
                  str_to_lower() %>% 
                  str_remove_all("https?://.*[a-zA-Z0-9#]") %>%
                  str_replace_all("[\\-,.!?_…・×、。「」\\(\\)\\【\\】＃＠@]", "") %>%      #不要な記号類
                  str_squish() %>% #スペースを統合
                  iconv(from="UTF-8",to="CP932") # Encodingの変換（Mecabで処理するため）
                  
  return(cleaned_text)        
}

texts[1]
#処理後
cleansing_text(texts[1])


#全テキストに適応
cleaned_texts <- unlist(lapply(texts,cleansing_text)) 
cleaned_texts <- cleaned_texts[!is.na(cleaned_texts)]
cleaned_texts %>% head()

#④テキストデータをcvs形式での保存
write(paste(cleaned_texts,collapse = " "), 'tmp.txt')　#<-一文書にまとめたファイル（頻度計算用）
write.csv(cleaned_texts,"cleaned_text.csv") #<- 文章毎保存


