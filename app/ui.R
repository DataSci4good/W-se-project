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
                   
                   tabPanel('Behavioral Change',
                            fluidPage(
                              
                              sidebarPanel(
                                verbatimTextOutput('intro'),
                                radioButtons('behaviors', 
                                             'Choose a Behavior To View',
                                             c('1' = '1', '2' = '2', '3' = '3', '4' = '4',
                                               '5' = '5', '6' = '6', '7' = '7'), inline = TRUE),
                                hr(),
                                strong("Behavior"),
                                #verbatimTextOutput("value"),
                                textOutput("behavior"),
                                hr(),
                                #strong("Key"),
                                dataTableOutput("behavior.key")
                              ),#sidebarPanel end
                              
                              mainPanel(
                                plotOutput("plot3"),
                                plotOutput("plot4")
                              )
                            ) #fluidPage end
                   )
)#navbarPage end
)#ShinyUI end