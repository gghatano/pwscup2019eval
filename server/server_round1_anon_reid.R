output$table_round1_anon_reid = renderDataTable({
  ## ファイル読み込み
  file_round1_anon_reid = input$file_round1_anon_reid
  if(is.null(file_round1_anon_reid)){
    return(NULL)
  }
  
  
  ## データ読み込み
  table_round1_anon_reid = read_csv(file = file_round1_anon_reid$datapath)
  if(is.null(table_round1_anon_reid)){
    return(NULL)
  }
  
  
  ## format check
  output$format_round1_anon_reid = renderText({
    ## formatのチェック
    result = anon_formatcheck(table_round1_anon_reid)
    result %>% return
  })
  
  ## utility check
  output$utility_round1_anon_reid = renderText({
    ## TODO :: utility check 用の処理
    
    0.005 %>% return
    
    ## TODO :: ファイル名と有用性評価値と投稿日時をアップロードする仕組みを作る
  })
  
  table_round1_anon_reid %>% return
}, options = list(pageLength = 10))

output$format_round1_anon_reid = renderText({
  "匿名加工後データをアップロードしてください" %>% return
})

output$utility_round1_anon_reid = renderText({
  "匿名加工後データをアップロードしてください" %>% return
})

### result table
output$board_round1_anon_reid = renderDataTable({
  ## get data from google spread sheet api
  api_round1_anon_reid = GET(url = "https://sheet.best/api/sheet/f79948e0-fbb8-42a9-997e-4962a0767e45", 
                             use_proxy("http://proxy.ns-sol.co.jp", 8000), verbose())
  table_round1_anon_reid = api_round1_anon_reid %>% 
    content %>% 
    list.stack
  
  table_round1_anon_reid %>% return
}, options = list(pageLength = 10))