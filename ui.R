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
        menuItem("予備選_匿名化", tabName = "round1_anon", icon = icon("th")),
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
                  h2("Information")
                )
        ),
        tabItem(tabName = "round1_anon",
                fluidRow(
                  title = "DataTable",
                  width = 12
                )
        ),
        tabItem(tabName = "round1_reid",
                fluidRow(
                  title = "予備選再識別結果",
                  width = 12
                )
        ),
        tabItem(tabName = "round1_retrace",
                "10月末に公開予定"
        )
      )
    )
  )
)