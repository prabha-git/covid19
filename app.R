library(shiny)
library(tidyverse)
library(bigrquery)

projectid = 'covid19-india-314022'
datasetid<-'covid19_india'



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

server <- function(input, output, session) {
  
  bq_conn <-  dbConnect(bigquery(), 
                        project = projectid,
                        dataset = datasetid, 
                        use_legacy_sql = FALSE
  )
  
  data <- tbl(bq_conn, "daily_covid19_india")
  
  output$distPlot <- renderPlot({

    
      data %>% 
        filter(updated_date>=!!input$daterange[1] & updated_date <= !!input$daterange[2]) %>% 
        ggplot(aes(x=updated_date,y=active_cases_total))+
        geom_bar(stat='identity')+
        facet_wrap(~state)
    
  })
  dbDisconnect(bq_conn)
}

shinyApp(ui, server)