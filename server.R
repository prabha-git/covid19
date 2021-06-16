library(ggplot2)
library(scales)


server <- function(input, output, session) {
  retrive_data <- function() {
    projectid = 'covid19-india-314022'
    datasetid <- 'covid19_india'
    
    bq_auth(path = "covid19-india-314022-7fe8b8ce467e.json")
    bq_conn <-  dbConnect(
      bigquery(),
      project = projectid,
      dataset = datasetid,
      use_legacy_sql = FALSE
    )
    
    data <- tbl(bq_conn, "daily_covid19_india") %>% as.data.frame
    print("Data Downloaded from Big Query")
    dbDisconnect(bq_conn)
    return(data)
  }
  
  
  data = retrive_data()
  
  output$covidTrend  <- renderPlot({
    data %>%
      filter(updated_date >= !!input$daterange[1] &
               updated_date <= !!input$daterange[2]) %>%
      ggplot(aes(x = updated_date, y = active_cases_total)) +
      geom_line(color = 'blue', size = 1) +
      facet_wrap( ~ state, strip.position = "bottom") +
      scale_y_continuous(labels = unit_format(unit = "k", scale = 1e-3)) +
      theme_bw() +
      theme (
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.spacing.y = unit(1, "lines")
      )
    
  }, width = "auto", height = 1000)
  
  
}