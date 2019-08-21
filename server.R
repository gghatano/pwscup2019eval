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
    source("./server/server_round1_anon_reid.R", local = TRUE)
    source("./server/server_round1_anon_retrace.R", local = TRUE)
  }
)