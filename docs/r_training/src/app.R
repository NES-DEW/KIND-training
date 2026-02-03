library(shiny)

ui <- fluidPage(
  radioButtons("my_input", "Which gear to show?", sort(unique(mtcars$gear))),
  tableOutput("my_table")
)

server <- function(input, output, session) {
  output$my_table <- renderTable(mtcars |>
                                   dplyr::filter(gear == input$my_input) |>
                                   dplyr::group_by(cyl) |>
                                   dplyr::summarise(mpg = round(mean(mpg), 2)))
}

shinyApp(ui, server)