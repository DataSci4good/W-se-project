shinyUI(navbarPage('Wise Project', id='nav',
                   
                   tabPanel('Banking/Employment or Course Education',
                            fluidPage(
                              
                              sidebarPanel(
                                radioButtons('questions', 
                                             'Choose a Question To View',
                                             c('1' = '1', '2' = '2', '3' = '3', '4' = '4', 
                                               '5' = '5', '6' = '6', '7' = '7', '8' = '8', 
                                               '9' = '9', '12' = '12', '13' ='13', '14' = '14', 
                                               '15' = '15', '16' = '16'), inline = TRUE),
                                hr(),
                                strong("Question"),
                                verbatimTextOutput("value"),
                                hr(),
                                dataTableOutput('survey.responses')
                                ),#sidebarPanel end
                              
                              mainPanel(
                                plotOutput("plot"),
                                plotOutput("plot2")
                              )
                   ) #fluidPage end
                   ),
                   
                   tabPanel('Place Holder',
                            fluidPage(
                              
                              sidebarPanel(
                                radioButtons('questions2', 
                                             'Choose a Question To View',
                                             c('10' = '10', '11' = '11'), inline = TRUE),
                                hr(),
                                strong("Question"),
                                #verbatimTextOutput("value"),
                                hr()#,
                                #dataTableOutput('survey.responses')
                              ),#sidebarPanel end
                              
                              mainPanel(
                                #plotOutput("plot"),
                                #plotOutput("plot2")
                              )
                            ) #fluidPage end
                   )
)#navbarPage end
)#ShinyUI end