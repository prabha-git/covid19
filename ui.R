library(shiny)
library(tidyverse)
library(bigrquery)





ui <- fluidPage(
  # App title
  titlePanel("Covid19 Active Cases Trend in India"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("daterange", "Date range:",
                     start = "2021-05-17",
                     end   = "2021-05-31"),
    ),
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)