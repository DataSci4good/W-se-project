shinyUI(navbarPage('Wise Project', id='nav',
                   
                   tabPanel('Banking/Employment',
                            fluidPage(
                              
                              sidebarPanel(
                                selectInput("question", 
                                            "Choose A Question", 
                                            choices = questions, 
                                            selected = questions[1]),
                                dataTableOutput('survey.responses')
                                ),
                              #sidebarPanel end
                              
                              mainPanel(
                                plotOutput("plot")
                                #dataTableOutput('table')
                              )
                   ) #fluidPage end
                   ),
                   
                   tabPanel('Second',
                            fluidPage(
                              
                              sidebarPanel(
                                selectInput("question", 
                                            "Choose A Question", 
                                            choices = questions, 
                                            selected = questions[1])
                              ),#sidebarPanel end
                              
                              mainPanel(
                                
                              )
                            ) #fluidPage end
                   ),
                   
                   tabPanel('Third',
                            fluidPage(
                              
                              sidebarPanel(
                                selectInput("question", 
                                            "Choose A Question", 
                                            choices = questions, 
                                            selected = questions[1])
                              ),#sidebarPanel end
                              
                              mainPanel(
                              
                              )
                            ) #fluidPage end
                   )
)#navbarPage end
)#ShinyUI end