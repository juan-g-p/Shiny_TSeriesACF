# Define UI for application that draws the plots
ui <- fluidPage(theme = shinytheme("superhero"),
                
                # Application title
                titlePanel("Time Series Components - Effect on correlogram"),
                # header2("Author: Juan Garbayo")
                
                helpText(h4("Juan Garbayo - Time Series Analysis classes")),
                
                # Sidebar with a slider input for number of bins 
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("slope",
                                "Trend Slope:",
                                min = -2,
                                max = +2,
                                value = 1,
                                step = 0.01),
                    sliderInput("amplitude",
                                "Seasonal amplitude:",
                                min = 0,
                                max = 50,
                                value = 5),
                    sliderInput("amplitude_i",
                                "Irregular amplitude:",
                                min = 0,
                                max = 5,
                                value = 1)
                  ),
                  
                  # Show a plot of the generated distribution
                  mainPanel(
                    plotOutput("timePlot"),
                    plotOutput("ACF")
                  )
                )
)