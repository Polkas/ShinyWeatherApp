
library(DT)
#library(markdown)
#library(lubridate)
library(ggplot2)
library(dplyr)
library(tidyr)
library(forecast)
library(plotly)
library(xts)
library(shiny)

temp_all = read.csv("WeatherDatasFinal.csv")
temp_all$GMT = as.Date(temp_all$GMT)

temps = temp_all %>% group_by(GMT,year,month,week) 

tempsg = temps %>% gather(key,value,-GMT,-year,-month,-week) 

datas_pred = temps %>% group_by(year,month)%>% select(-week) %>% summarise_all(funs(mean(.,na.rm=TRUE))) 

shinyServer(function(input, output, session) {
  
  
  output$Name <- renderText({
    paste(input$Indicator,input$City,sep=" ")
  })
  
  output$Name2 <- renderText({
    paste(input$Indicator,input$City,sep=" ")
  })
  
  data_temp <- reactive({
    data = tempsg %>% 
      as.data.frame() %>% 
      slice(grep(input$Indicator, tempsg$key)) %>%
      na.omit()
    data$key = gsub(paste0(input$Indicator,"_"),"", data$key)
    data
    })
  
  
  ggplot1 = reactive({
    data_temp = data_temp()
    data_ind_temporary = tempsg %>% as.data.frame() %>% slice(grep(paste(input$Indicator,input$City,sep="_"), tempsg$key)) %>% na.omit()
    data_ind_temporary$key = gsub(paste0(input$Indicator,"_"),"", data_ind_temporary$key)
    ggplot(data_temp,aes(x=week,y=value,color=key))+
      geom_smooth(size=1)+
      geom_smooth(data=data_ind_temporary,aes(x=week,y=value,color=key),size=4)+
      theme(legend.position="top")
  })
  
  
  output$plot1 <- renderPlotly({
    ggplotly(ggplot1())
  })
  
  Model <- reactive({
  if(input$PM=="Auto Arima"){
   AutoArima = auto.arima(ts(unlist(datas_pred[,paste(input$Indicator,input$City,sep="_")]),frequency = 12,start=c(1996,1),end=c(2016,11)))
   AutoArima
  } else {
    Holt = HoltWinters(na.approx(ts(unlist(datas_pred[,paste(input$Indicator,input$City,sep="_")]),frequency = 12,start=c(1996,1),end=c(2016,11))))
    Holt
}
   })

  output$plotPrediction = renderPlotly({
    ggplotly(autoplot(forecast(Model(),h=input$long)))
    })
  
  output$table <- renderDataTable({sample_n(as_data_frame(na.omit(temps)),5)}, options = list(bFilter = FALSE, iDisplayLength = 5))

  output$downloadData <- downloadHandler(
    filename = 'WeatherDatasFinal.csv',
    content = function(file) {
    write.csv(sample_n(as_data_frame(na.omit(temps)),5), file, row.names=FALSE)})
  
})
