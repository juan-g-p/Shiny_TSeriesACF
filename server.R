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
        y = 2*input$slope*x + sc + w,
        y_lag = lag(y, as.integer(input$lag_n)),
        y_mean = mean(y)
      ),
      index = date)
  })
  
  # TODO: edit the tibble so that it takes as input the lag number
  # that needs to be highlighted.
  data2 <- reactive({
    t <- data() %>% select(y) %>% ACF(lag_max = 99) %>% pull(acf) %>% .[[as.integer(input$lag_n)]]
    tibble(
      x = c(as.double(input$lag_n), as.double(input$lag_n)),
      y = c(0,
            t)
    )
  })
  
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. It outputs a plot
  output$timePlot <- renderPlot({
    # print(data()$x)
    # print(data()$y)
    # print(data()$sc)
    p <- data() %>% autoplot(y) 
    
    # Add additional lags layer if user input matches    
    if (input$print_lag) {
      p <- p +
           geom_line(aes(x = date, y = y_lag), 
                  color = "red",
                  linetype = "dashed")
    }
    
    # Print graph    
    p
  })
  
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. It outputs a plot
  output$ACF <- renderPlot({
    
    p <- data() %>%
      ACF(y, lag_max = 99) %>%
      autoplot()
    
    # Add additional lags layer if user input matches
    if (input$print_lag) {
    p <- p + 
          geom_line(
            data = data2(),
            aes(x = x, y = y),
            color = "red"
          ) +
          geom_point(data = data2(),
                     aes(x=x[[1]],y=y[[2]]),colour="red")
    }
    
    # Print graph
    p
  })
  
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. It outputs a plot
  output$lagPlot <- renderPlot({
    
    p <- data() %>%
         gg_lag(y, lags = as.integer(input$lag_n), geom = "point") +
         geom_vline(xintercept = data()$y_mean[[1]], 
                    linetype = "dashed", color = "red")
    # Add additional lags layer if user input matches
    if (input$print_lag == FALSE) {
    p <- ggplot() + geom_blank()
    }
    
    # Print graph
    p
  })
  
}