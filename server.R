options(shiny.maxRequestSize = 1000*1024^2)
# library----
library(shiny)
library(shinythemes)
library(dplyr)
library(httr)
library(readr)
library(rlist)


shinyServer(
  function(input, output) {
    ## format check
    output$format_round1_anon_reid = renderText({
      file_round1_anon_reid = input$file_round1_anon_reid
      # file_round1_anon_reid = NULL

      if(is.null(file_round1_anon_reid)){
        NULL %>% return
      }

      "OK!" %>% return
    })

    ### utility
    output$utility_round1_anon_reid = renderText({
      file_round1_anon_reid = input$file_round1_anon_reid
      # file_round1_anon_reid = NULL
      if(is.null(file_round1_anon_reid)){
        NULL %>% return
      }
      0.005 %>% return

      ## ファイル名と有用性評価値と投稿日時をアップロードする仕組みを作る
    })
    
    
    ### result table
    output$table_round1_anon_reid = renderDataTable({
      ## get data from google spread sheet api
      api_round1_anon_reid = GET(url = "https://sheet.best/api/sheet/f79948e0-fbb8-42a9-997e-4962a0767e45", 
                                      use_proxy("http://proxy.ns-sol.co.jp", 8000), verbose())
      table_round1_anon_reid = api_round1_anon_reid %>% 
        content %>% 
        list.stack
      table_round1_anon_reid %>% head %>% print
      table_round1_anon_reid %>% return
    })
  }
)