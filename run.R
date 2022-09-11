# Load the necessary libraries
library(shiny)
library(fpp3)
library(shinythemes)

port <- Sys.getenv('PORT')


# Ports to run the app on a server
shiny::runApp(
  appDir = getwd(),
  host = '0.0.0.0',
  port = as.numeric(port)
)

# Ports to run the app locally
# shiny::runApp(
#   appDir = getwd(),
#   host = '127.0.0.1',
#   port = as.numeric("3884")
# )