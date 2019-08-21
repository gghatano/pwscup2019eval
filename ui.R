library(shiny)
library(shinythemes)
library(shinydashboard)
library(markdown)
library(DT)

# ui----
shinyUI(
  dashboardPage(skin = "yellow", 
    dashboardHeader(title = "PWS Cup 2019"),
    ## Sidebar content
    dashboardSidebar(
      sidebarMenu(
        menuItem("Information", tabName = "information", icon = icon("dashboard")),
        menuItem("予備選_匿名化(ID推定対応)", tabName = "round1_anon_reid", icon = icon("th")),
        menuItem("予備選_匿名化(トレース推定対応)", tabName = "round1_anon_retrace", icon = icon("th")),
        menuItem("予備選_ID推定", tabName = "round1_reid", icon = icon("th")),
        menuItem("予備選_トレース推定", tabName = "round1_retrace", icon = icon("th"))
      )
    ),
    dashboardBody(
      tabItems(
        # First tab content
        tabItem(tabName = "information",
                fluidRow(
                  width = 12, 
                  includeMarkdown("information.md")
                )
        ),
        tabItem(tabName = "round1_anon_reid",
                fluidRow(
                  box(
                    title = "ID再識別対応匿名化後データ",
                    width = 4,
                    fileInput("file_round1_anon_reid", label = NULL, buttonLabel = "Select File")
                    h4("注意: ファイル名・有用性スコアは、他の参加者が見る↓のリーダボードにも表示されます")
                    h4("注意: ファイル名・有用性スコアを秘匿したい場合は、ローカル版Appを利用してください")
                  ),
                  box(
                    title = "フォーマットチェック", 
                    width = 4, 
                    verbatimTextOutput("format_round1_anon_reid")
                  ), 
                  box(
                    title = "有用性評価結果",
                    width = 4, 
                    verbatimTextOutput("utility_round1_anon_reid")
                  )
                ),
                fluidRow(
                  box(
                    title = "リーダーボード",
                    width = 12, 
                    DT::dataTableOutput("table_round1_anon_reid")
                  )
                )
        ),
        tabItem(tabName = "round1_anon_retrace"
        ),
        tabItem(tabName = "round1_reid"
        ),
        tabItem(tabName = "round1_retrace",
                "10月末に公開予定"
        )
      )
    )
  )
)