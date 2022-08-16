library(tidyverse)
library(lubridate)
tokyo_covid19 <- read_csv("data1/tokyo_covid19.csv",
                          col_types = list(col_double(), 
                                           col_date(format = "%Y/%m/%d"),
                                           col_double())
                          ) %>% 
  na.omit() %>%   # NAを含む行を削除
  mutate(week = isoweek(date) + c(rep(0,356), rep(53, 412-356))) # 週番号の追加

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

# 1.日次データ
## 第一波
bass_nls(tokyo_covid19$positive_cases[1:119])

## 第二波
bass_nls(tokyo_covid19$positive_cases[120:250])

## 第三波
bass_nls(tokyo_covid19$positive_cases[251:412])


# 2.週次データ
## 週次集計
weekly_data <- tokyo_covid19 %>% 
  group_by(week) %>% 
  summarise(n_week = sum(positive_cases), date = first(date))

## 第一波
bass_nls(weekly_data$n_week[1:17])

## 第二波
bass_nls(weekly_data$n_week[18:36])

## 第三波
bass_nls(weekly_data$n_week[37:59])
