library(xlsx)

readItems <- function(filename){
    items <- read.xlsx(filename, 
                           sheetIndex = "Bank for ITS",
                           startRow = 5, 
                           endRow = 154,
                           colIndex = c(1:9),
                           header = FALSE, 
                           stringsAsFactors = FALSE)
    
    names(items) <- c('Item_ID',
                          'Anchor_Question',
                          'Answer_Key',
                          'Delivery_Seq',
                          'Form',
                          'Item_#',
                          'Topic_Code',
                          'Elaine_Ques_Bank_#',
                          'New_Question')
    return(items)
}


items_S14 <- readItems("data/ItemInfoFile spring14 Tests ABC (March 21).xls")
items_S15 <- readItems("data/ItemInfoFile spring15 Tests ABC.1.xls")