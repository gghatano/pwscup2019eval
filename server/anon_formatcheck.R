library(dplyr)

####################################################
## フォーマットのエラーを指摘する


####################################################
## グローバル変数

### 一般化と削除の表記
DELETE_FLG = "*"
SEPARATION_CHAR = " "

### チーム別のユーザID
PRIVATE_USER_ID_LIST = 1:2000 %>% as.character
PUBLIC_USER_ID_LIST = 2001:4000 %>% as.character

### 領域ID
REG_ID_LIST = 1:1024 %>% as.character
REG_ID_LIST = c(REG_ID_LIST, DELETE_FLG)

### 元トレースの時刻ID
TIME_ID_LIST = 1:40 %>% as.character


### テーブルの形 
ANONDATA_COLUMN_NUM = 1
ANONDATA_ROW_NUM = 80000


####################################################
## フォーマットチェック用関数

anon_formatcheck = function(anondata){
  
  error_message = c("")
  
  ## 行数・列数エラー 
  ### 列数エラー
  column_num_result = anondata %>% colnames %>% length 
  
  column_num_error_message = ""
  if(column_num_result != ANONDATA_COLUMN_NUM){
    return("列数エラーです")
  }
  
  ### 行数エラー
  row_num_result = anondata %>% nrow
  if(row_num_result != ANONDATA_ROW_NUM){
    return("行数エラーです")
  }
  
  ## 列名・列順エラー
  column_name_result = anondata %>% colnames 
  column_name_result = all(column_name_result == c("reg_id"))
  
  column_name_error_message = ""
  if(!column_name_result){
    return("列名エラーです")
  }
  
  ## reg_id エラー
  ### 全ての要素が正しくREG_ID_LISTに入っているかどうか確認する
  reg_id_result = 
    anondata %>% 
    dplyr::mutate(ROW_NUM = 1:nrow(.)) %>% 
    tidyr::separate_rows(col = reg_id, sep = " ") %>% 
    dplyr::mutate(FLG = (reg_id %in% REG_ID_LIST)) %>% 
    dplyr::group_by(ROW_NUM) %>% 
    dplyr::summarise(FLG_ALL = all(FLG)) %>% 
    dplyr::ungroup() %>%
    dplyr::pull(FLG_ALL)
    
  ### エラー行の番号を探す
  reg_id_result = which(!reg_id_result)
  
  reg_id_error_message = ""
  if(length(reg_id_result) > 0){
    reg_id_error_message = reg_id_result %>% paste("行目のreg_idがエラーです") 
  }
  
  ## メッセージ組み立て
  error_message = 
    c(column_num_error_message,
    column_name_error_message,
    reg_id_error_message) 
  
  ### 空文字の除外
  error_message = error_message[error_message > 0]
  
  if(length(error_message) == 0){
    return("OK")
  }
  
  ### 長すぎても困るので、先頭10行だけ
  error_message %>% 
    head(10) %>% 
    paste(collapse = "\n") %>% 
    return
}

## テスト用
# ####################################################
# ## 正常系
# set.seed(71)
# TEST_SIZE = 80000
# reg_id = sample(x = c(1:1024, "10 10", "20 29", "10 20"), size = TEST_SIZE, replace = TRUE) %>% as.character
# 
# dat_test = data.frame(reg_id = reg_id)
# print("OK!")
# dat_test %>% anon_formatcheck
# # 
# # ####################################################
# ## 行フォーマットエラー
# set.seed(71)
# TEST_SIZE = 80000
# reg_id = sample(x = c(1:1024, "10 10", "20 29", "10,20"), size = TEST_SIZE, replace = TRUE) %>% as.character
# 
# dat_test = data.frame(reg_id = reg_id)
# 
# print("NG!")
# dat_test %>% anon_formatcheck
# 
# ####################################################
# ## 列名エラー
# colnames(dat_test) = c("hage")
# print("列名")
# dat_test %>% anon_formatcheck
# 
# ####################################################
# ## 列数エラー
# dat_test = data.frame(reg_id = reg_id, reg_id2 = reg_id)
# print("列数")
# dat_test %>% anon_formatcheck
# 
# 
# ####################################################
# ## 行数エラー
# TEST_SIZE = 10
# reg_id = sample(x = c(1:10, "10 10", "20 29", "10,20"), size = TEST_SIZE, replace = TRUE) %>% as.character
# 
# dat_test = data.frame(reg_id = reg_id)
# 
# print("NG!")
# dat_test %>% anon_formatcheck
