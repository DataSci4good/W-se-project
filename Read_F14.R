library(openxlsx)

pretest_s14 <- read.xlsx("data/Fall 2014 Aggregate Data csv.xlsx",
                         sheet = "F'14 Pretest Data",
                         rows = c(1:48952),
                         cols = c(1:12))

cert_test_s14 <- read.xlsx("data/Fall 2014 Aggregate Data csv.xlsx",
                           sheet = "F'14 Cert. Test Data",
                           rows = c(1:23637),
                           cols = c(1:105))

retake_s14 <- read.xlsx("data/Fall 2014 Aggregate Data csv.xlsx",
                        sheet = "F'14 Cert. Retake",
                        rows = c(1:1217),
                        cols = c(1:13))

paper_s14 <- read.xlsx("data/Fall 2014 Aggregate Data csv.xlsx",
                       sheet = "F'14 Paper",
                       rows = c(1:1572),
                       cols = c(1:8))