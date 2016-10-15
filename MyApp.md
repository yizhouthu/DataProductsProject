My Application - Computing Without A Calculator
========================================================
author: Yi Zhou
date: Oct 4, 2016
autosize: true

Inspiration
========================================================
<font size="6">
When I was studying in high school, my mathematics teacher often organized a game for us. The game is about estimating the solution of a given equation. These equations could be hardly solved without using a computer or calculator. She said it was good for our mathematical sensation. Usually, the game contained 3 stages:

- Stage 1: A problem is published
- Stage 2: A student make his/her guess
- Stage 3a: If his/her guess is accurate enough, the game ends, and his/her performance is measured by the guess time
- Stage 3b: If not, the teacher shows the fitted value of his/her guess, then go back to Stage 2

It came to me that I could write an application to replicate this game to accomplish this project.
</font>

Introduction to My Application
========================================================

The target of this application is to let people guess the unknown in three equations without using their calculators. The application provides a radiobutton for users to change the problem. I use the function *withMathJax* to insert mathematical formulas. The code is as below:


```r
output$problemContent <- renderUI({
    switch(input$problemNum,
        '1' = withMathJax('Find the x in $$x^2=71$$'),
        '2' = withMathJax('Find the x in $$x^2+2^x=10$$'),
        '3' = withMathJax('Find the x in $$log_2(x)=\\pi$$')
    )
})
```

There is also a response area to show the fitted value (the value when substituting x with the input value), or a message showing the guess is correct.


The Problems
========================================================
<font size="5">
The three problems are:

- $x^{2} = 71$
- $x^{2} + 2^{x} = 10$
- $log_2(x) = \pi$

For example, we can get the x from the first equation by following those steps:

1. Since 8^2 = 64 and 9^2 = 81, the x should be between 8 and 9, from the convexity of the function x^2, we can estimate 8.5^2 is slightly below 72.5. So our first guess can be 8.4 or 8.5.

2. Then we input 8.4 and it shows that 8.4^2 = 70.56, which is very close to 71, so the second guess can be 8.45.

3. It shows 8.45^2 = 71.4025, so the answer should be 8.43, because the average of 70.56 and 71.4025 is less than, but almost 71. We input 8.43 and it shows the guess is correct.

</font>

Exception Handling
========================================================
<font size="5">
I indentify some of exceptions and handle them by printing different messages in the response area.

- The user has not submitted the first guess, the response area shows *"You have not gussed yet."* 
- The input is not a number, the response area shows *"Invalid guess."*
- The input is less than 0 or more than 10, the response area shows *"The guess should be between 0 and 10."*
- The number of decimal places of the input is more than 2, the response area shows *"The guess should be a number with no more than 2 decimal places."*, where the function decimals calculates the number of decimal places:


```r
decimals <- function(x) {
    str <- as.character(x)
    if(grepl(".", str, fixed = TRUE))
        nchar(strsplit(str, ".", fixed = TRUE)[[1]][2])
    else 0
}
decimals("2.45648")
```

```
[1] 5
```

</font>
