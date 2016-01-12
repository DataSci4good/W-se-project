shinyServer(function(input, output) {
  
  #Displaying question.
  output$value = renderPrint({as.character(filter(survey.questions2, Item_num == as.numeric(input$questions))$Item_text )})
  
  #Taking in which question was selected.
  selected.question.number = reactive({
    filter(survey.questions2, Item_num == input$questions)$Item_num
  })
  
  #Generating a regex to find the vector's names corresponding to the selected question.
  question.regex = reactive({
    paste0('S',as.character(selected.question.number()), '\\','.')
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
  
  #Respondents by survey answer
  output$plot = renderPlot({plotData(question.data.percentage())})
  
  plotData = function(df) {
    ggplot(df, 
           aes(x=answers, y = banking.questions.percentages)) +
      geom_bar(stat = 'identity', fill="white", colour="darkgreen") +
      theme_bw() + 
      ylab('Frequency') + 
      xlab('Response') +
      ggtitle('Numbers of Respondents By Survey Question Response') +
      geom_text(aes(label = round(banking.questions.percentages, 2), 
                    y = round(banking.questions.percentages) + 1500))
  }
  
  #Student mean performance per survey response
  
  #Getting the indices which match the regex
  question.indices2 = reactive({
    grep(question.regex(), score.by.survey.answer.df$answers)
  })
  
  #Storing the data pertaining to the chosen question.
  question.data.scores = reactive({
    #banking.questions.percentages[names(banking.questions.percentages)[question.indices()]]
    score.by.survey.answer.df[question.indices2(),]
  })
  
  output$plot2 = renderPlot({plotData2(question.data.scores())})
  
  plotData2 = function(df) {
    ggplot(df, 
           aes(x=answers, y =  score.by.survey.answer)) +
      geom_bar(stat = 'identity', fill="white", colour="darkgreen") +
      theme_bw() + 
      ylab('Percentage') + 
      xlab('Response') +
      ggtitle('Mean Test Score By Survey Question Response') +
      geom_text(aes(label = round(score.by.survey.answer, 2), 
                    y = round(score.by.survey.answer) + 4))
  }
  
  survey.responses = reactive({
    display.survey.responses[grep(question.regex(), display.survey.responses$Code), ]
  })
  
  output$survey.responses = renderDataTable({survey.responses()},
                                            options = list(searching = FALSE, 
                                                           pageLength = 14, 
                                                           lengthChange = FALSE, 
                                                           ordering = FALSE,
                                                           paging = FALSE, 
                                                           info = FALSE, 
                                                           columnDefs = list(name = c('1','2'), targets = c(1, 2))
                                                           ))
  
  
  #Code for second tab
  
  output$behavior = renderText(behavior.list[as.integer(input$behaviors)])
  
  output$key = renderText({paste('No/No: Did not do before or after course.',
                                 'Yes/Yes: Did before and after course.',
                                 'No/Yes: Did not do before course but does now.',
                                 'Yes/No: Did before course but does not do now.',
                                 'NA: Did not respond to one or both questions',
                                 sep = '\n')})
  
  behavior.grouped = reactive({
    select_(behavior.full,'StudentID','Pct_Correct',B = paste('B',input$behaviors,sep = '')) %>%
    group_by(B)
  })
  
  behavior.summary = reactive({
    summarise(behavior.grouped(),summ = n())
  })
  
  plotData3 = function(df) {
    ggplot(df, 
           aes(x=B, y = summ)) +
      geom_bar(stat = 'identity', fill="white", colour="darkgreen") +
      theme_bw() + 
      ylab('Frequency') + 
      xlab('Response') +
      ggtitle('Numbers of Respondents By Survey Question Response') +
      geom_text(aes(label = round(summ, 2), 
                    y = round(summ) + 1500))
  }
  
  output$plot3 = renderPlot({plotData3(behavior.summary())})
  
  behavior.summary.score = reactive({
    summarise(behavior.grouped(),summ = mean(Pct_Correct,na.rm = TRUE))
  })
  
  plotData4 = function(df) {
    ggplot(df, 
           aes(x=B, y =  summ)) +
      geom_bar(stat = 'identity', fill="white", colour="darkgreen") +
      theme_bw() + 
      ylab('Percentage') + 
      xlab('Response') +
      ggtitle('Mean Test Score By Survey Question Response') +
      geom_text(aes(label = round(summ, 2), 
                    y = round(summ) + 4))
  } 
  
  output$plot4 = renderPlot({plotData4(behavior.summary.score())})
  
  #Testing
  output$test = renderText({paste('Question', selected.question.number(), 'Choices')})
  output$test = renderText({paste('Question', question.regex())})
  output$test = renderText({paste('Question', question.indices())})
  output$table = renderDataTable({question.data.percentage()})
  
  
})#end Shiny Server