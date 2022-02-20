# Load the necessary libraries
library(shiny)
library(fpp3)
library(shinythemes)

port <- Sys.getenv('PORT')

shiny::runApp(
  appDir = getwd(),
  host = '0.0.0.0',
  port = as.numeric(port)
)