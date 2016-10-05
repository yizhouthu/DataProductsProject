#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Computing Without A Calculator"),
    sidebarPanel(
        radioButtons(
            "problemNum", "Problem Number:",
            c("1" = "1", "2" = "2", "3" = "3")
        ),
        uiOutput("problemContent"),
        numericInput("guess", "Your guess:", value = 5, min = 0, max = 10,
                     step = 0.01),
        actionButton("Submit", "Submit")
    ),
    mainPanel(
        h2("Guess the value of x"),
        p("The object of this game is to guess the unknown x without a calculator.
          The result should be rounded to 2 decimal places, so your guess should
          also be a number with 2 decimal places. After each wrong guess, the
          fitted value of your guess will be shown."),
        h2("Result of your guess"),
        h4("You entered"),
        textOutput("inputValue"),
        uiOutput("fittedValueOrSuccess")
    )
))
