bass_nls <- function(n) {
  # 推定
  Nt <- c(0, cumsum(n[1:(length(n)-1)]))
  out <- nls(n ~ p*(m - Nt) + q*Nt/m*(m - Nt),
             start = list(p = 0.1, q = 0.1, m = 5000))
  # 結果出力
  print(summary(out))
  
  # 実績値と予測値の比較
  plot.ts(cbind(n, fitted(out)), plot.type = "single", 
          lty = c("solid", "dashed"), col = c("black", "red"))
}

library(tidyverse)
library(lubridate)
tokyo_covid19 <- read_csv("data1/tokyo_covid19.csv",
                          col_types = list(col_double(), 
                                           col_date(format = "%Y/%m/%d"),
                                           col_double())
                          ) %>% 
  na.omit() %>%   # NAを含む行を削除
  mutate(week = isoweek(date)) # 週番号の追加

tokyo_covid19$week <- tokyo_covid19$week + c(rep(0,357), rep(53, 412-357))

# 1.日次データ
## 第一波
bass_nls(tokyo_covid19$positive_cases[1:119])

## 第二波
bass_nls(tokyo_covid19$positive_cases[120:250])

## 第三波
bass_nls(tokyo_covid19$positive_cases[251:412])

# 2.週次データ
weekly_data <- function(data) {
  data %>% 
    group_by(week) %>% 
    summarise(n_week = sum(positive_cases))
}

weekly_data <- tokyo_covid19 %>% 
  group_by(week) %>% 
  summarise(n_week = sum(positive_cases))

## 第一波
nw1 <- weekly_data(tokyo_covid19[1:118,])
bass_nls(nw1$n_week)

## 第二波
nw2 <- weekly_data(tokyo_covid19[119:251,])
bass_nls(nw2$n_week)

## 第三波
nw3 <- weekly_data(tokyo_covid19[252:412,])
bass_nls(nw3$n_week)
