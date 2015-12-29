library(openxlsx)

pretest_s15 <- read.xlsx("data/Spring 2015 Aggregate-1.xlsx",
                         sheet = "S'15 Pretest",
                         rows = c(1:25519),
                         cols = c(1:18))
saveRDS(pretest_s15,"data/pretest_s15.rds")


cert_test_s15 <- read.xlsx("data/Spring 2015 Aggregate-1.xlsx",
                           sheet = "S'15 Certification Test",
                           rows = c(1:70653),
                           cols = c(1:110))
saveRDS(cert_test_s15,"data/cert_test_s15.rds")


retake_1_s15 <- read.xlsx("data/Spring 2015 Aggregate-1.xlsx",
                          sheet = "S'15 Retakes",
                          rows = c(1:1995,1997:4014),
                          cols = c(1:18))
saveRDS(retake_1_s15,"data/retake_1_s15.rds")


retake_2_s15 <- read.xlsx("data/Spring 2015 Aggregate-1.xlsx",
                          sheet = "S'15 2nd Retake",
                          rows = c(1:180),
                          cols = c(1:18))
saveRDS(retake_2_s15,"data/retake_2_s15.rds")