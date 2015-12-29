
library(dplyr)

test <- readRDS("data/cert_test_s15.rds") %>%
        select(StudentID,S10.1:S23.2)


test[,2:29] <- as.integer(!is.na(test[,2:29]))

BehavChange <- function(before,after){
                   if(before == "N" & after == "N")
                       return("No/No")
                   if(before == "Y" & after == "Y")
                       return("Yes/Yes")
                   if(before == "N" & after == "Y")
                       return("No/Yes")
                   if(before == "Y" & after == "N")
                       return("Yes/No")
                   if(is.na(before) | is.na(after))
                       return(NA)
}

Response <- function(first,second){
                if(first == 1 & second == 0)
                    return("Y")
                if(first == 0 & second == 1)
                    return("N")
                if(first == second)
                    return(NA)
}

test$R10 = mapply(Response,test$S10.1,test$S10.2)
test$R11 = mapply(Response,test$S11.1,test$S11.2)
test$R12 = mapply(Response,test$S12.1,test$S12.2)
test$R13 = mapply(Response,test$S13.1,test$S13.2)
test$R14 = mapply(Response,test$S14.1,test$S14.2)
test$R15 = mapply(Response,test$S15.1,test$S15.2)
test$R16 = mapply(Response,test$S16.1,test$S16.2)
test$R17 = mapply(Response,test$S17.1,test$S17.2)
test$R18 = mapply(Response,test$S18.1,test$S18.2)
test$R19 = mapply(Response,test$S19.1,test$S19.2)
test$R20 = mapply(Response,test$S20.1,test$S20.2)
test$R21 = mapply(Response,test$S21.1,test$S21.2)
test$R22 = mapply(Response,test$S22.1,test$S22.2)
test$R23 = mapply(Response,test$S23.1,test$S23.2)
