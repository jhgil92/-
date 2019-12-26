# 네이버 테마주/그룹사 리스트 수집

library(rvest)
library(dplyr)
library(httr)
library(readr)
library(stringr)
library()

#### 테마주 ####
url_base = "https://finance.naver.com/sise/theme.nhn?&page="
theme_link <- character()
theme_nm <- character()

for(i in 1:6){
  url <- paste0(url_base, i)
  url %>% 
    read_html(encoding = "EUC-KR") %>% 
    html_nodes("td.col_type1 a") -> tmp
  tmp %>% html_attr("href") %>% c(., theme_link) -> theme_link
  tmp %>% html_text() %>% c(., theme_nm) -> theme_nm
}

url_base = "https://finance.naver.com"

ITEM_NM = character()
ITEM_CD = character()
THEME_NM = character()

for(i in 1:length(theme_link)){
  url <- paste0(url_base, theme_link[i])
  url %>% 
    read_html(encoding = "EUC-KR") %>% 
    html_nodes(".name_area a") -> tmp
  tmp %>% html_text %>% c(., ITEM_NM) -> ITEM_NM
  tmp %>% html_attr("href") %>% str_sub(-6) %>% c(., ITEM_CD) -> ITEM_CD
  rep(theme_theme[i], length(tmp %>% html_text)) %>% c(., THEME_NM) -> THEME_NM
  cat(i, "\n")
  Sys.sleep(3)
}

THEME_LIST <- data.frame(THEME_NM, ITEM_NM, ITEM_CD)
rm(tmp, i, url, url_base, url_group)


#### 그룹사 ####
url_base = "https://finance.naver.com/sise/sise_group.nhn?type=group"
group_link <- character()
group_nm <- character()

url_base %>% 
  read_html(encoding = "EUC-KR") %>% 
  html_nodes(".type_1 a") -> tmp
tmp %>% html_attr("href") %>% c(., group_link) -> group_link
tmp %>% html_text() %>% c(., group_nm) -> group_nm

url_base = "https://finance.naver.com"

ITEM_NM = character()
ITEM_CD = character()
GROUP_NM = character()

for(i in 1:length(group_link)){
  url <- paste0(url_base, group_link[i])
  url %>% 
    read_html(encoding = "EUC-KR") %>% 
    html_nodes(".name_area a") -> tmp
  tmp %>% html_text %>% c(., ITEM_NM) -> ITEM_NM
  tmp %>% html_attr("href") %>% str_sub(-6) %>% c(., ITEM_CD) -> ITEM_CD
  rep(group_nm[i], length(tmp %>% html_text)) %>% c(., GROUP_NM) -> GROUP_NM
  cat(i, "\n")
  Sys.sleep(3)
}

GROUP_LIST <- data.frame(GROUP_NM, ITEM_NM, ITEM_CD)
rm(tmp, i, url, url_base)




