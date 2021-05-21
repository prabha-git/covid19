server <- function(input, output, session) {
  
  projectid = 'covid19-india-314022'
  datasetid<-'covid19_india'
  
  bq_auth(path = "covid19-india-314022-4b7fb74fdf79.json")
  
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