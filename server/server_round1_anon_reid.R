##################################
## ID再識別対応匿名加工後データ　評価タブ

SLEEP_TIME = 2

output$table_round1_anon_reid = renderDataTable({
  
  withProgress(message = '処理中...', value = 0, {
    
    ## ファイル読み込み
    Sys.sleep(SLEEP_TIME)
    incProgress(1/4, detail = "ファイル読み込み中...")
    
    file_round1_anon_reid = input$file_round1_anon_reid
    if(is.null(file_round1_anon_reid)){
      return(NULL)
    }
    
    ## データ読み込み
    table_round1_anon_reid = readr::read_csv(file = file_round1_anon_reid$datapath)
    
    if(is.null(table_round1_anon_reid)){
      return(NULL)
    }
    
    ## formatのチェック処理
    Sys.sleep(SLEEP_TIME)
    incProgress(2/4, detail = "フォーマットチェック中...")
    
    output$format_round1_anon_reid = renderText({
      result = anon_formatcheck(table_round1_anon_reid)
      result %>% return
    })
    
    ## utility check
    Sys.sleep(SLEEP_TIME)
    incProgress(3/4, detail = "有用性計算中...")
    
    output$utility_round1_anon_reid = renderText({
      
      utility_score = utility(rawdata = table_round1_anon_reid, anondata = table_round1_anon_reid)
      
      ## TODO :: ファイル名と有用性評価値と投稿日時をアップロードする仕組みを作る
      
      return(utility_score)
      
    })
    
    ## 投稿済みデータの表示
    
    Sys.sleep(SLEEP_TIME)
    incProgress(4/4, detail = "データ表示中...")
    table_round1_anon_reid %>% return
    
  })
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
    rlist::list.stack()
  
  table_round1_anon_reid %>% return
}, options = list(pageLength = 10))