library(KFAS)
library(xts)
library(ggplot2)
library(ggfortify)
library(gridExtra)

file_data <- read.csv("book-tsa-ssm-foundation-master/book-data/5-11-sales_data.csv")
sales <- as.xts(read.zoo(file_data))

head(file_data)
head(sales)

# 祝日判定
source("https://raw.githubusercontent.com/logics-of-blue/website/master/010_forecast/20190714_R%E8%A8%80%E8%AA%9E%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E6%97%A5%E6%9C%AC%E3%81%AE%E7%A5%9D%E6%97%A5%E5%88%A4%E5%AE%9A/jholiday.R", encoding="utf-8")

dates <- index(sales)
holiday_date <- dates[is.jholiday(dates) & (weekdays(dates, abbreviate = TRUE) != "日")]
holiday_date

holiday_flg <- as.numeric(dates %in% holiday_date)
holiday_flg


# 状態空間モデル
build_cycle <- SSModel(
  H = NA,
  as.numeric(sales) ~
    SSMtrend(degree = 2, c(list(NA), list(NA))) +
    SSMseasonal(period = 7, sea.type = "dummy", Q = NA) + 
    holiday_flg
)

fit_cycle <- fitSSM(build_cycle, inits = c(1, 1, 1, 1))

result_cycle <- KFS(
  fit_cycle$model,
  filtering = c("state", "mean"),
  smoothing = c("state", "mean")
)

# 図示
p_data <- autoplot(sales, main = "元データ")
p_trend <- autoplot(result_cycle$alphahat[, "level"], main = "トレンド＋水準")
p_cycle <- autoplot(result_cycle$alphahat[, "sea_dummy1"], main = "周期成分")
grid.arrange(p_data, p_trend, p_cycle)


# 当てはめ
interval_cycle <- predict(fit_cycle$model, interval = "prediction", level = 0.95)

df <- cbind(
  data.frame(sales = as.numeric(sales),
             time = as.POSIXct(index(sales))),
  data.frame(interval_cycle)
)

ggplot(data = df, aes(x = time, y = sales)) +
  labs(title = "周期成分のある状態空間モデル") +
  geom_point(alpha = 0.5) +
  geom_line(aes(y = fit), size = 1.2) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.3) +
  scale_x_datetime(date_labels = "%y 年 %m 月")


interval_cycle <- predict(fit_cycle$model, interval = "confidence", level = 0.95, states = "level")

df <- cbind(
  data.frame(sales = as.numeric(sales),
             time = as.POSIXct(index(sales))),
  data.frame(interval_cycle)
)

ggplot(data = df, aes(x = time, y = sales)) +
  labs(title = "周期成分を取り除いた水準値のグラフ") +
  geom_point(alpha = 0.5) +
  geom_line(aes(y = fit), size = 1.2) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.3) +
  scale_x_datetime(date_labels = "%y 年 %m 月")

