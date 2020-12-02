library(bayesm)

sec8_data1 <- read.csv("data/sec8_data1.csv")
sec8_data2 <- read.csv("data/sec8_data2.csv")

id <- sec8_data2$PNL  # 消費者パネルIDの抽出
n <- length(id)       # 消費者パネル数
j <- 3    # 商品の個数
k <- 3    # マーケティング変数の個数 (Price, Disp, Ad)

# sec8_data1[,7:9] <- log(sec8_data1[,7:9])
yxdata <- list() 
for (i in 1:n) {
  data_i <- subset(sec8_data1, PNL == id[i])
  ydata_i <- data_i$Choice
  xdata_i <- createX(p = j, na = k, nd = NULL, Xa = data_i[,7:15], Xd = NULL, base = 3)
  yxdata[[i]] <- list(id = id[i], y = ydata_i, X = xdata_i)
}

# zdata <- cbind(intercept = rep(1,n),
#                scale(sec8_data2[,c("age", "family")], scale = FALSE))
zdata <- scale(sec8_data2[,c("age", "family")], scale = FALSE)

dataset <- list(p = 3, lgtdata = yxdata, Z = zdata)

set.seed(1)  # 乱数の初期値
mcmc <- list(R = 3000) # MCMCのサンプル数
prior <- list(ncomp = 1)  # 事前分布の設定 ⇒ 初期設定の散漫な事前分布

# MCMCサンプリング
out <- rhierMnlRwMixture(Data = dataset, Prior = prior, Mcmc = mcmc)    # MCMCの実行
plot(out$betadraw)

# 係数 Delta の推定値と出力整形
summary_Delta <- summary(out$Deltadraw, QUANTILES = FALSE)
Delta_mean <- matrix(summary_Delta[,1], nrow =5, byrow = TRUE)
Delta_sd <- matrix(summary_Delta[,2], nrow =5, byrow = TRUE)

rownames(Delta_mean) <- c("Brand.1", "Brand.2", "Price", "Disp", "Ad")
colnames(Delta_mean) <- c("age", "family")
rownames(Delta_sd) <- c("Brand.1", "Brand.2", "Price", "Disp", "Ad")
colnames(Delta_sd) <- c("age", "family")

Delta_mean
Delta_sd

Delta_mean / Delta_sd

# data_hblogit <- dataset
# save(data_hblogit, file = "data_hblogit.RData")
# load()


save(yxdata, file = "yxdata.RData")


# beta <- out$betadraw
# apply(out$betadraw, 2, mean)
# 
# tapply(out$betadraw, 2, mean)
# apply(beta, 1, rowMeans)

apply(out$betadraw[,,(0.1*3000):3000], 1, rowMeans)
