library(dplyr)
library(shiny)
library(ggplot2)


cert.test.14 = readRDS('../data/cert_test_s14.rds')
cert.test.15 = readRDS('../data/cert_test_s15.rds')

survey.questions = read.csv('../data/t_survey_items.csv')
questions.answers = read.csv('../data/t_survey_responses.csv')

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


test15 <- readRDS("../data/cert_test_s15.rds") %>%
  select(StudentID,Pct_Correct,S10.1:S23.2)

test14 <- readRDS("../data/cert_test_s14.rds") %>%
  select(c(3,12,c(58:85)))

colnames(test14) <- colnames(test15)

test14[,3:30] <- as.integer(!is.na(test14[,3:30]))
test15[,3:30] <- as.integer(!is.na(test15[,3:30]))

BehavChange <- function(before,after){
  if(is.na(before) | is.na(after))
    return(NA)
  if(before == "N" & after == "N")
    return("No/No")
  if(before == "Y" & after == "Y")
    return("Yes/Yes")
  if(before == "N" & after == "Y")
    return("No/Yes")
  if(before == "Y" & after == "N")
    return("Yes/No")
  
}

Response <- function(first,second){
  if(first == 1 & second == 0)
    return("Y")
  if(first == 0 & second == 1)
    return("N")
  if(first == second)
    return(NA)
}

test14$R10 = mapply(Response,test14$S10.1,test14$S10.2)
test14$R11 = mapply(Response,test14$S11.1,test14$S11.2)
test14$R12 = mapply(Response,test14$S12.1,test14$S12.2)
test14$R13 = mapply(Response,test14$S13.1,test14$S13.2)
test14$R14 = mapply(Response,test14$S14.1,test14$S14.2)
test14$R15 = mapply(Response,test14$S15.1,test14$S15.2)
test14$R16 = mapply(Response,test14$S16.1,test14$S16.2)
test14$R17 = mapply(Response,test14$S17.1,test14$S17.2)
test14$R18 = mapply(Response,test14$S18.1,test14$S18.2)
test14$R19 = mapply(Response,test14$S19.1,test14$S19.2)
test14$R20 = mapply(Response,test14$S20.1,test14$S20.2)
test14$R21 = mapply(Response,test14$S21.1,test14$S21.2)
test14$R22 = mapply(Response,test14$S22.1,test14$S22.2)
test14$R23 = mapply(Response,test14$S23.1,test14$S23.2)

test14$B1 = as.factor(mapply(BehavChange,test14$R10,test14$R17))
test14$B2 = as.factor(mapply(BehavChange,test14$R11,test14$R18))
test14$B3 = as.factor(mapply(BehavChange,test14$R12,test14$R19))
test14$B4 = as.factor(mapply(BehavChange,test14$R13,test14$R20))
test14$B5 = as.factor(mapply(BehavChange,test14$R14,test14$R21))
test14$B6 = as.factor(mapply(BehavChange,test14$R15,test14$R22))
test14$B7 = as.factor(mapply(BehavChange,test14$R16,test14$R23))

test15$R10 = mapply(Response,test15$S10.1,test15$S10.2)
test15$R11 = mapply(Response,test15$S11.1,test15$S11.2)
test15$R12 = mapply(Response,test15$S12.1,test15$S12.2)
test15$R13 = mapply(Response,test15$S13.1,test15$S13.2)
test15$R14 = mapply(Response,test15$S14.1,test15$S14.2)
test15$R15 = mapply(Response,test15$S15.1,test15$S15.2)
test15$R16 = mapply(Response,test15$S16.1,test15$S16.2)
test15$R17 = mapply(Response,test15$S17.1,test15$S17.2)
test15$R18 = mapply(Response,test15$S18.1,test15$S18.2)
test15$R19 = mapply(Response,test15$S19.1,test15$S19.2)
test15$R20 = mapply(Response,test15$S20.1,test15$S20.2)
test15$R21 = mapply(Response,test15$S21.1,test15$S21.2)
test15$R22 = mapply(Response,test15$S22.1,test15$S22.2)
test15$R23 = mapply(Response,test15$S23.1,test15$S23.2)

test15$B1 = as.factor(mapply(BehavChange,test15$R10,test15$R17))
test15$B2 = as.factor(mapply(BehavChange,test15$R11,test15$R18))
test15$B3 = as.factor(mapply(BehavChange,test15$R12,test15$R19))
test15$B4 = as.factor(mapply(BehavChange,test15$R13,test15$R20))
test15$B5 = as.factor(mapply(BehavChange,test15$R14,test15$R21))
test15$B6 = as.factor(mapply(BehavChange,test15$R15,test15$R22))
test15$B7 = as.factor(mapply(BehavChange,test15$R16,test15$R23))

behavior.list = c('Use a spending plan/budget.',
              'Have a bank account.',
              'Save money on a regular basis.',
              'Talk about money matters with my parents/guardians.',
              'Have financial goals.',
              'Compare prices when I shop.',
              'Have plans for further education.')

behavior.full = rbind(test14,test15)