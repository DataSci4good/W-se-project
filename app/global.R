library(dplyr)
library(shiny)
library(ggplot2)


cert.test.14 = readRDS('data/cert_test_s14.rds')
cert.test.15 = readRDS('data/cert_test_s15.rds')

survey.questions = read.csv('data/t_survey_items.csv')
questions.answers = read.csv('data/t_survey_responses.csv')

#All questions except 10 and 11.
survey.questions2 = survey.questions[-c(10:23), ]
rownames(survey.questions2) = 1:nrow(survey.questions2)
survey.questions2[c(seq(10, 14, 1)), 1] = seq(12, 16, 1)
questions = as.vector(survey.questions2[, 2])

answers = questions.answers[-c(45:72), ]
rownames(answers) = 1:nrow(answers)
answers$Item[c(45:64)] = answers$Item[c(45:64)] - 12

#Columns for all questions except 10 and 11
banking.columns = colnames(cert.test.15)[20:length(cert.test.15)][-c(44:71)]
banking.df = cert.test.15[, banking.columns]

#Making a temporary dataframe to store the 2014 data before combining it with the 2015 data
temp.year.14 = cert.test.14[, seq(15,105,1)][-c(44:71)]
colnames(temp.year.14) = colnames(banking.df)
banking.df = rbind(temp.year.14, banking.df)

#Generating a summary of the data by number of respondents per suvery question response.
banking.df[is.na(banking.df)] = 0
banking.questions.percentages = colSums(banking.df)
banking.questions.percentages.df = data.frame(banking.questions.percentages)

refactor.columns = c('S12.1', 'S12.2', 'S12.3', 
                     'S13.1', 'S13.2', 'S13.3', 
                     'S13.4', 'S13.5', 'S14.1', 
                     'S14.2', 'S14.3', 'S14.4',
                     'S14.5', 'S14.6', 'S15.1', 
                     'S15.2', 'S15.3', 'S15.4', 
                     'S16.1', 'S16.2')
adjusted.banking.columns = banking.columns
adjusted.banking.columns[c(44:length(adjusted.banking.columns))] = refactor.columns
banking.questions.percentages.df$answers = adjusted.banking.columns

#Test scores by survey response
cert.test.15$Pct_Correct[is.na(cert.test.15$Pct_Correct)] = mean(cert.test.15$Pct_Correct, na.rm = TRUE)
score.by.survey.answer = round(colSums(cert.test.15$Pct_Correct*banking.df)/colSums(banking.df),2)
score.by.survey.answer.df = data.frame(score.by.survey.answer)
score.by.survey.answer.df$answers = adjusted.banking.columns

#removed response 29 because it corresponds to S6.6 which isn't in the data.
#The others removed are for questions 10 and 11
questions.answers.vector = as.vector(questions.answers[-c(29, 45:48), 3])
display.survey.responses = data.frame(banking.columns, 
                                      questions.answers.vector[-c(44:67)], 
                                      stringsAsFactors = FALSE)
colnames(display.survey.responses) = c('Code', 'Response')
display.survey.responses$Code[c(44:63)] = refactor.columns
display.survey.responses$Code[c(44:63)]

#For questions 10 and 11
survey.questions.10.11 = survey.questions[c(10:23), ]
