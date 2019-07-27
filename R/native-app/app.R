# Native app -----------------------------------------------------------------

# Shiny App for providing data input to cars plumber API
library(shiny)
library(httr)
library(xgboost)

# Load model

cars_model <- readr::read_rds("cars-model.rds")
xgb_model <- xgb.load("xgboost.model")

ui <- fluidPage(
  
  # Application title
  titlePanel("SME Cover Predictor"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("ANZSIC",
                  "ANZSIC"),
      fluidRow(
        actionButton("predict",
                     "Predict")
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("data"),
      wellPanel(
        textOutput("raw_results")
      )
    )
  )
)

server <- function(input, output) {
  # Create reactive_values
  reactive_values <- reactiveValues(data = data.frame(),
                                    predicted_values = NULL)
  
  observeEvent(input$predict, {
    # Use R model to predict new values
    reactive_values$predicted_values <- predict(xgb_model, 
                                                xgb.DMatrix(matrix(as.numeric(input$ANZSIC))))
    

  })
  
  output$data <- renderTable(reactive_values$data)
  output$raw_results <- renderText({
    if (is.null(reactive_values$predicted_values)) {
      "No predictions"
    } else {
      print(reactive_values$predicted_values)
    }
  })
}

shinyApp(ui = ui, server = server)
