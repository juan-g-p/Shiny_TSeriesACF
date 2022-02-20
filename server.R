server <- function(input, output) {
  
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Updates the data structrue to generate the plot
  data <- reactive({
    set.seed(10)
    as_tsibble(
      tibble(
        x = seq(0, 100, 1),
        date = yearmonth("2000 Jan") + x,
        sc = input$amplitude*sin(2*pi*x/12),
        w = input$amplitude_i*rnorm(101, 0, 1),
        y = 2*input$slope*x + sc + w
      ),
      index = date)
  }) 
  
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. It outputs a plot
  output$timePlot <- renderPlot({
    print(data()$x)
    print(data()$y)
    print(data()$sc)
    autoplot(data(), y)
    
  })
  
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. It outputs a plot
  output$ACF <- renderPlot({
    
    data() %>%
      ACF(y, lag_max = 99) %>%
      autoplot() + labs(title="test")
    
  })
  
}