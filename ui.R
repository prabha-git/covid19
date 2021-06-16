library(shiny)
library(tidyverse)
library(bigrquery)
library(shinycssloaders)

ui <- fluidPage(
  # App title
  titlePanel("Covid19 Active Cases Trend in India"),
  
  div(style = "display:inline-block;vertical-align:top;float:right;",
      fluidRow(column(
        12,
        dateRangeInput("daterange", "Date range:",
                       start  = "2021-05-17",
                       end   = "2021-12-31"),
      ))),
  
  plotOutput(outputId = "covidTrend") %>% withSpinner(color = "#0dc5c1")
  
  
)
