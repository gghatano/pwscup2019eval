#### utility.R ####

####################################################
## グローバル変数
DISTANCE_THRESHOLD = 2

####################################################
## calc_reg_id_dist_table
### あらかじめ距離データフレームを作成しておく
### データが変わったときに1回だけ実行すればいい
calc_reg_id_dist_table = function(){
  regiondata = readr::read_csv("./data/info_region.csv")
  
  dat_regid1 = 
    regiondata %>% 
    select(reg_id1 = reg_id, y1 = `y(center)`, x1 = `x(center)`) 
  
  dat_regid2 = 
    dat_regid1 %>% 
    select(reg_id2 = reg_id1, y2 = y1, x2 = x1 )
    
  dat_distance = 
    merge(dat_regid1, dat_regid2, all = TRUE) %>% 
    as_tibble()
  
  regiondata = 
    regiondata %>% 
    select(reg_id1 = reg_id, reg_id1_is_hospital = hospital)
  
  dat_distance %>% 
    mutate(diff_y = abs(y1 - y2), 
           diff_x = abs(x1 - x2)) %>% 
    mutate(dist_y = diff_y * 111, 
           dist_x = diff_x * 91) %>% 
    mutate(dist = sqrt(dist_y ** 2 + dist_x **2)) %>% 
    select(reg_id1, reg_id2, dist) %>%
    inner_join(regiondata) %>% 
    write.csv("./data/regid_distance_osaka.csv", row.names = FALSE, quote=FALSE)
    
}

# calc_reg_id_dist_table()


utility = function(rawdata = NULL, anondata){
  
  ## データ読み込み
  ### 距離行列
  dat_distance = readr::read_csv("./data/regid_distance_osaka.csv", col_types = "ccdc")
  ### 元データ
  ### (_IDPと_TRPの切り替え機能を実装するかも)
  rawdata = readr::read_csv("./data/orgtraces_team001_data01_IDP.csv")
  
  ## test
  anondata = readr::read_csv("./data/test_anotraces_team001_data01_IDP.csv")
  
  dat_regid = 
    data.frame(RAW = rawdata$reg_id, ANON = anondata$reg_id, 
               TIME = rawdata$time_id, USER = rawdata$user_id)
  
  dat_regid_not_deleted2 = 
    dat_regid %>% 
    dplyr::filter(ANON != "*") %>% 
    tidyr::separate_rows(col = ANON, sep = " ")
  
  
  dat_regid_deleted_dist = 
    dat_regid %>% 
    dplyr::filter(ANON == "*") %>% 
    dplyr::mutate(dist = DISTANCE_THRESHOLD)
  
  dat_regid_dist = 
    dat_regid_not_deleted %>% 
    dplyr::inner_join(dat_distance, by = c("RAW" = "reg_id1", "ANON" = "reg_id2")) %>% 
    dplyr::select(-reg_id1_is_hospital) %>% 
    base::rbind(dat_regid_deleted_dist)
  
  utility_score = 
    dat_regid_dist %>% 
    group_by(USER, TIME) %>% 
    summarise(dist_mean = mean(dist)) %>% 
    mutate(UTILITY = if_else(dist_mean > DISTANCE_THRESHOLD, 0, 1 - dist_mean / DISTANCE_THRESHOLD)) %>% 
    pull(UTILITY) %>% 
    mean
  
  return(utility_score)
}


## test
anondata = readr::read_csv("./data/test_anotraces_team001_data01_IDP.csv")

utility(anondata = anondata)
