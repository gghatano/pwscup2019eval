library(dplyr)

####################################################
## グローバル変数
PRIVATE_USER_ID_LIST = 1:2000 %>% as.character
PUBLIC_USER_ID_LIST = 2001:4000 %>% as.character
REG_ID_LIST = 1:1024 %>% as.character
TIME_ID_LIST = 1:1024 %>% as.character

DELETE_FLG = "*"
SEPARATION_CHAR = " "


####################################################
## 試験用データ
set.seed(71)
TEST_SIZE = 100
user_id = sample(x = 1:3010, size = TEST_SIZE, replace = TRUE) %>% as.character
time_id = sample(x = 1:3010, size = TEST_SIZE, replace = TRUE) %>% as.character
reg_id = sample(x = c(1:10, "10 10", "20 29", "10,20"), size = TEST_SIZE, replace = TRUE) %>% as.character

dat_test = data.frame(user_id = user_id, time_id = time_id, reg_id = reg_id)

####################################################
## フォーマットチェック用関数

anon_formatcheck = function(anondata){
  
  error_message = c("")
  ## データ形式エラー
  ## 行数・列数エラー 
  ### 列数
  column_num_result = anondata %>% colnames %>% length 
  
  column_num_error_message = ""
  if(column_num_result != 3){
    return("列数エラーです")
  }
  
  ## 列名・列順エラー
  column_name_result = anondata %>% colnames 
  column_name_result = all(column_name_result == c("user_id", "time_id", "reg_id"))
  
  column_name_error_message = ""
  if(!column_name_result){
    return("列名エラーか列順エラーです")
  }
  
  ## user_id エラー
  user_id_result = anondata$user_id %in% PRIVATE_USER_ID_LIST
  user_id_result = which(!user_id_result)
  user_id_error_message = ""
  if(length(user_id_result) > 0){
    user_id_error_message = user_id_result %>% paste("行目のuser_idがエラーです") 
  }
  
  
  ## time_idエラー
  time_id_result = anondata$time_id %in% TIME_ID_LIST
  time_id_result = which(!time_id_result)
  time_id_error_message = ""
  if(length(time_id_result) > 0){
    time_id_error_message = time_id_result %>% paste("行目のtime_idがエラーです") 
  }
  
  ## reg_idエラー
  reg_id_result = 
    anondata$reg_id %>% 
    as.character %>% 
    lapply(function(x){
      x %>% strsplit(" ") %>% unlist %in% REG_ID_LIST %>% prod
      }) %>% unlist %>% as.logical
  reg_id_result = which(!reg_id_result)
  reg_id_error_message = ""
  if(length(reg_id_result) > 0){
    reg_id_error_message = reg_id_result %>% paste("行目のreg_idがエラーです") 
  }
  
  
  ## メッセージ組み立て
  error_message = c(column_num_error_message,
    column_name_error_message,
    user_id_error_message,
    time_id_error_message,
    reg_id_error_message) 
  
  ###  空文字の除外
  error_message = error_message[error_message > 0]
  
  if(length(error_message) == 0){
    return("OK")
  }
  
  ###  長すぎても困るので、先頭100行だけ
  error_message %>% 
    head(100) %>% 
    paste(collapse = "\n") %>% 
    return
}

# ####################################################
# ## 正常系
# set.seed(71)
# TEST_SIZE = 100
# user_id = sample(x = 1:2000, size = TEST_SIZE, replace = TRUE) %>% as.character
# time_id = sample(x = 1:1024, size = TEST_SIZE, replace = TRUE) %>% as.character
# reg_id = sample(x = c(1:10, "10 10", "20 29", "10 20"), size = TEST_SIZE, replace = TRUE) %>% as.character
# 
# dat_test = data.frame(user_id = user_id, time_id = time_id, reg_id = reg_id)
# print("OK!")
# dat_test %>% anon_formatcheck
# 
# ####################################################
# ## 行フォーマットエラー
# set.seed(71)
# TEST_SIZE = 100
# user_id = sample(x = 1:3010, size = TEST_SIZE, replace = TRUE) %>% as.character
# time_id = sample(x = 1:3010, size = TEST_SIZE, replace = TRUE) %>% as.character
# reg_id = sample(x = c(1:10, "10 10", "20 29", "10,20"), size = TEST_SIZE, replace = TRUE) %>% as.character
# 
# dat_test = data.frame(user_id = user_id, time_id = time_id, reg_id = reg_id)
# 
# print("NG!")
# dat_test %>% anon_formatcheck
# 
# ####################################################
# ## 列名エラー
# colnames(dat_test) = c("hoge", "huge", "hage")
# print("列名")
# dat_test %>% anon_formatcheck
# 
# ####################################################
# ## 列数エラー
# dat_test = data.frame(user_id = user_id, time_id = time_id)
# print("列数")
# dat_test %>% anon_formatcheck
#   