shinyServer(function(input, output) {
  
  #Taking in which question was selected.
  selected.question.number = reactive({
    filter(survey.questions, Item_text == input$question)$Item_num
  })
  
  #Generating a regex to find the vector's names corresponding to the selected question.
  question.regex = reactive({
    paste0('S',as.character(selected.question.number()), '.')
  })
  
  #Getting the indices which match the regex
  question.indices = reactive({
    grep(question.regex(), banking.questions.percentages.df$answers)
  })
  
  #Storing the data pertaining to the chosen question.
  question.data.percentage = reactive({
    #banking.questions.percentages[names(banking.questions.percentages)[question.indices()]]
    banking.questions.percentages.df[question.indices(),]
  })
  
  output$plot = renderPlot({plotData(question.data.percentage())})
  
  plotData = function(df) {
    ggplot(df, 
           aes(x=answers, y = banking.questions.percentages)) +
      geom_bar(stat = 'identity', fill="white", colour="darkgreen") +
      theme_bw() + 
      ylab('Percentage') + 
      xlab('Answers') +
      ggtitle('Percentage of Choices of Each Question\'s Answer By Respondents') +
      geom_text(aes(label = round(banking.questions.percentages, 2), 
                    y = round(banking.questions.percentages)+ 2))
  }
  
  survey.responses = reactive({
    display.survey.responses[grep(question.regex(), display.survey.responses$banking.columns), ]
  })
  
  output$survey.responses = renderDataTable({survey.responses()},
                                            options = list(searching = FALSE, 
                                                           pageLength=10, 
                                                           lengthChange = FALSE, 
                                                           ordering = FALSE,
                                                           scrollY = "310px", 
                                                           scrollCollapse = TRUE, 
                                                           paging = FALSE, 
                                                           info = FALSE))
  
  #Testing
  output$test = renderText({paste('Question', selected.question.number(), 'Choices')})
  output$test = renderText({paste('Question', question.regex())})
  output$test = renderText({paste('Question', question.indices())})
  output$table = renderDataTable({question.data.percentage()})
  
  
})#end Shiny Server