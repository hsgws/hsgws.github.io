library(bayesm)

sec8_data1 <- read.csv("data/sec8_data1.csv")
sec8_data2 <- read.csv("data/sec8_data2.csv")

id <- sec8_data2$PNL  # 消費者パネルIDの抽出
n <- length(id)       # 消費者パネル数
j <- 3    # 商品の個数
k <- 3    # マーケティング変数の個数 (Price, Disp, Ad)


yxdata <- list()  # 各消費者の購買データを list 形式に変換
for (i in 1:n) {
  data_i <- subset(sec8_data1, PNL == id[i])
  ydata_i <- data_i$Choice
  xdata_i <- createX(p = j, na = k, nd = NULL, Xa = data[,7:15], Xd = NULL, base = 3)
  yxdata[[i]] <- list(id = id[i], y = ydata, X = xdata)
}

# zdata <- cbind(intercept = rep(1,n),
#                scale(sec8_data2[,c("age", "family")], scale = FALSE))
zdata <- scale(sec8_data2[,c("age", "family")], scale = FALSE)

dataset <- list(p = j, lgtdata = yxdata, Z = zdata)

set.seed(1234)  # 乱数の初期値
mcmc <- list(R = 3000) # MCMCのサンプル数
prior <- list(ncomp = 1)  # 事前分布の設定 ⇒ 初期設定の散漫な事前分布

# MCMCサンプリング
out <- rhierMnlRwMixture(Data = dataset, Prior = prior, Mcmc = mcmc)    # MCMCの実行
                    