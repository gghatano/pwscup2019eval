library(shiny)
library(shinythemes)
library(shinydashboard)
library(markdown)
library(DT)

# ui----
shinyUI(
  dashboardPage(skin = "yellow", 
    dashboardHeader(title = "PWSCUP2019 予備選"),
    ## Sidebar content
    dashboardSidebar(
      sidebarMenu(
        menuItem("Information", tabName = "information", icon = icon("dashboard")),
        menuItem("予備選_匿名化(ID推定対応)", tabName = "round1_anon_reid", icon = icon("th")),
        menuItem("[未実装] 予備選_匿名化(トレース推定対応)", tabName = "round1_anon_retrace", icon = icon("th")),
        menuItem("[未実装] 予備選_ID推定", tabName = "round1_reid", icon = icon("th")),
        menuItem("[未実装] 予備選_トレース推定", tabName = "round1_retrace", icon = icon("th"))
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
                    fileInput("file_round1_anon_reid", label = NULL, buttonLabel = "Select File"),
                    h4("orgtraces_team001_data01_IDP.csvを加工したデータを投稿して下さい")
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
                    title = "投稿されたデータ", 
                    width = 6, 
                    DT::dataTableOutput("table_round1_anon_reid")
                  ),
                  box(
                    title = "リーダーボード(9月中に実装予定)",
                    width = 6, 
                    DT::dataTableOutput("board_round1_anon_reid")
                  )
                )
        ),
        tabItem(tabName = "round1_anon_retrace"
        ),
        tabItem(tabName = "round1_reid"
        ),
        tabItem(tabName = "round1_retrace"
        )
      )
    )
  )
)