library(tidyverse)
library(magrittr)
library(rvest)
library(xml2)


product <- "B096KGWZ78"
url <- paste0("https://www.amazon.co.jp/product-reviews/", product, "/?pageNumber=")

text <- NULL
for (i in 1:3) {
  urls <- paste0(url, i)
  html <- read_html(urls)
  
  text <- rbind(
    text,
    html_elements(html, 'div.review-data') %>% 
    html_text2() %>% 
    tibble() %>%
    set_colnames("review") %>% 
    filter(!str_detect(review, "Amazonで購入"),
           !str_detect(review, "パターン\\(種類\\):"),
           !review == "")
  )
  
  Sys.sleep(1)
}


name <- "GarminFA"
write_excel_csv(text, file = paste0("data/smart_watch/", name, ".csv"), col_names = FALSE)



# url <- "https://www.amazon.co.jp/product-reviews/B0BDJGFWP4/"
# res <- read_html(url)
# 
# tmp <- html_element(res,xpath = '//*[@id="a-page"]/div[3]/div/div[1]/div/div[1]/div[5]/div[3]')
# html_text2(tmp)
# 
# tmp <- html_element(res,xpath = '//*[@id="customer_review-R3A3BJYA2LNCDC"]/div[4]/span/span')
# html_text(tmp)
# 
# #customer_review-R38WFQE008V7VN > div.a-row.a-spacing-small.review-data > span
# #customer_review-R3A3BJYA2LNCDC > div.a-row.a-spacing-small.review-data > span
# #customer_review-R1XC1HG7E9IG83 > div.a-row.a-spacing-small.review-data > span
# 
# #customer_review-R38WFQE008V7VN > div.a-row.a-spacing-small.review-data > span
# //*[@id="customer_review-R38WFQE008V7VN"]/div[4]/span
# 
# 
# #a-page > div:nth-child(31) > div > div.a-fixed-right-grid.view-point > div > div.a-fixed-right-grid-col.a-col-left > div.a-section.a-spacing-none.reviews-content.a-size-base
# //*[@id="a-page"]/div[3]/div/div[1]/div/div[1]/div[5]
# 
# tmp <- html_element(res, css = '#cm_cr-review_list')
# html_text2(tmp)
# 
# 
# //*[@id="customer_review-R3A3BJYA2LNCDC"]/div[4]/span/span
# //*[@id="cm_cr-review_list"]
# 
# tmp <- html_nodes(res, 'div')
# 
# tmp <- html_elements(res, 'div.review-data')
# txt <- html_text(tmp) %>% 
#   tibble() %>%
#   set_colnames("review") %>% 
#   filter(!str_detect(review, "Amazonで購入"))
