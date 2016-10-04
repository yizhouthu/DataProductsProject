#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

ans <- c(8.43, 2.27, 8.82) # Save the answer of each problem

# This function is to calculate the number of decimal digits
decimals <- function(x) {
    str <- as.character(x)
    if(grepl(".", str, fixed = TRUE)) {
        frac <- strsplit(str, ".", fixed = TRUE)[[1]][2]
        nchar(frac)
    }
    else 0
}

shinyServer(function(input, output) {
    # The contents of each problem
    output$problemContent <- renderUI({
        switch(input$problemNum,
               '1' = withMathJax('Find the x in $$x^2=71$$'),
               '2' = withMathJax('Find the x in $$x^2+2^x=10$$'),
               '3' = withMathJax('Find the x in $$log_2(x)=\\pi$$')
        )
    })
    
    # Print the guess
    output$inputValue <- renderPrint({
        isolate(input$guess)
    })
    
    # If success, then print "correct", while not, print the fitted value
    output$fittedValueOrSuccess <- renderUI({
        # First deal with some extreme cases
        if(input$Submit == 0)
            "You have not guessed yet."
        else if(is.na(as.numeric(isolate(input$guess))))
            "Invalid guess"
        else if(isolate(input$guess) < 0 || isolate(input$guess > 10))
            "The guess should be between 0 and 10."
        else if(decimals(isolate(input$guess)) > 2)
            "The guess should be a number with no more than 2 decimal places."

        # Correct
        else if(ans[as.integer(input$problemNum)] == isolate(input$guess)) 
            "Correct"
        
        # Incorrect
        else{
            isolate(switch(
              input$problemNum,
              '1' = withMathJax(helpText('The fitted value: \\(x^2=\\)',
                                         isolate(input$guess)^2)),
              '2' = withMathJax(helpText('The fitted value: \\(x^2+2^x=\\)',
                                         isolate(input$guess)^2 + 2^input$guess)),
              '3' = withMathJax(helpText('The fitted value: \\(log_2(x)=\\)',
                                         log2(isolate(input$guess))))
            ))
        }
    })
})
