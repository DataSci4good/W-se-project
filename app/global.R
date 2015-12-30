library(dplyr)
library(shiny)
library(ggplot2)

cert.test.14 = readRDS('~\cert_test_s14.rds')
cert.test.15 = readRDS('~\cert_test_s15.rds')

survey.questions = read.csv('~\t_survey_items.csv')
questions.answers = read.csv('~\t_survey_responses.csv')

#Banking/Employment: Questions 2-7
questions = as.vector(survey.questions[2:7,2])
answers = subset(questions.answers, Item %in% seq(2,7,1))
banking.columns = colnames(cert.test.15)[23:53] #columns for questions 2-7
banking.df = cert.test.15[, banking.columns]

banking.df[is.na(banking.df)] = 0
banking.questions.percentages = colSums(banking.df)*100/nrow(banking.df)
banking.questions.percentages.df = data.frame(banking.questions.percentages)
banking.questions.percentages.df$answers = banking.columns

questions.answers.vector = as.vector(questions.answers[4:35, 3])[-26]
display.survey.responses = data.frame(banking.columns, questions.answers.vector)
#removed response 26 because it corresponds to S6.6 which isn't in the data.
