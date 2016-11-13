library(plotly)
library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Weather Across The World"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Indicator","Select Weather Indicator:",choices = c("MeanTempC","MeanHumidity","MeanPressurehPa","MeanWindSpeedKmh"),selected = "MeanTempC"),
      selectInput("City","Select City:",choices = sort(c("Warsaw","Berlin","London","Paris","Rome","Madrit","HongKong","Ottawa","Sydney","RioDeJaneiro","Oslo")),selected = "Warsaw"),
      selectInput("PM","Prediction Model:",choices = c("Auto Arima","Holt Winters"),selected = "Holt Winters"),
      #checkboxInput("title","Title",TRUE),
      #textInput("DCity","Optional - City to Download:","Dublin"),
      #actionButton("DButton","Download"),
      sliderInput("long","Periods to predict:",min=1,max=24,value=6,step=1),
      p(strong(helpText("Please, Click The Submit Button."))),
      p(strong(submitButton("Submit"))),
      p(strong(em("Documentation:",a("Weather Across World - last 20 years",href="README.html")))),
      p(strong(em("Github repository:",a("DevelopingDataProducts - Peer Assignment Project",href="http:"))))
    ),

    mainPanel(
      tabsetPanel(
      
      tabPanel('Prediction',
               h3(textOutput("Name")),
               plotlyOutput("plotPrediction")),
      tabPanel('Avg Indicator During the Year',h3(textOutput("Name2")),
               plotlyOutput("plot1")),
      tabPanel(p(icon("table"), "Sample of Data"),
               
               dataTableOutput(outputId="table"),
               
               downloadButton('downloadData', 'Download')
               
      )
  ))
)
))