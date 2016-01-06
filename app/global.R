library(dplyr)
library(shiny)
library(ggplot2)

cert.test.14 = readRDS('C:\\Users\\Gordon\\Desktop\\GitHub\\W-se-project\\data\\cert_test_s14.rds')
cert.test.15 = readRDS('C:\\Users\\Gordon\\Desktop\\GitHub\\W-se-project\\data\\cert_test_s15.rds')

survey.questions = read.csv('C:\\Users\\Gordon\\Desktop\\GitHub\\W-se-project\\data\\t_survey_items.csv')
questions.answers = read.csv('C:\\Users\\Gordon\\Desktop\\GitHub\\W-se-project\\data\\t_survey_responses.csv')

#All questions except 10 and 11
survey.questions = survey.questions[-c(10:23), ]
rownames(survey.questions) = append(1:9,12:16)
survey.questions[c(seq(10, 14, 1)), 1] = seq(12, 16, 1)
questions = as.vector(survey.questions[-c(10,11),2])
answers = questions.answers[!(questions.answers$Item %in% c(10,11)), ]

#Columns for all questions except 10 and 11
banking.columns = colnames(cert.test.15)[20:length(cert.test.15)][-c(44:47)]
banking.df = cert.test.15[, banking.columns]

#Making a temporary dataframe to store the 2014 data before combining it with the 2015 data
temp.year.14 = cert.test.14[, seq(15,105,1)][-c(44:47)]
colnames(temp.year.14) = colnames(banking.df)
banking.df = rbind(temp.year.14, banking.df)

banking.df[is.na(banking.df)] = 0
banking.questions.percentages = colSums(banking.df)
banking.questions.percentages.df = data.frame(banking.questions.percentages)
banking.questions.percentages.df$answers = banking.columns

#Test scores by survey response
cert.test.15$Pct_Correct[is.na(cert.test.15$Pct_Correct)] = mean(cert.test.15$Pct_Correct, na.rm = TRUE)
score.by.survey.answer = round(colSums(cert.test.15$Pct_Correct*banking.df)/colSums(banking.df),2)
score.by.survey.answer.df = data.frame(score.by.survey.answer)
score.by.survey.answer.df$answers = banking.columns


#removed response 29 because it corresponds to S6.6 which isn't in the data.
#The others removed are for questions 10 and 11
questions.answers.vector = as.vector(questions.answers[-c(29, 45:48), 3])
display.survey.responses = data.frame(banking.columns, questions.answers.vector)
colnames(display.survey.responses) = c('Code', 'Response')

