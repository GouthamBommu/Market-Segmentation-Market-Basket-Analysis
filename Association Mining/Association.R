#importing required libraries [4]
install.packages('arules')
install.packages('plyr', dependencies = TRUE)
library(arules)
library(plyr)
#read csv files
OnlineRetail <- read.csv("C:\\Users\\Goutham\\Desktop\\CDA Assignments - 2nd sem\\Data Mining\\All assignment codes\\Assignment3\\OnlineRetail_final.csv")
OnlineRetail <- ddply(OnlineRetail, c("invoice"), function(dfl)paste(dfl$description, collapse = ","))
#export as output file .csv after transformations.
OnlineRetail$invoice <- NULL
write.table(OnlineRetail, "C:\\Users\\Goutham\\Desktop\\CDA Assignments - 2nd sem\\Data Mining\\All assignment codes\\Assignment3\\out_final.csv", quote = FALSE, row.names = FALSE, col.names = FALSE)
#inspecting rules
trans <- read.transactions("C:\\Users\\Goutham\\Desktop\\CDA Assignments - 2nd sem\\Data Mining\\All assignment codes\\Assignment3\\out_final.csv", sep = ",")
summary(trans)
itemFrequencyPlot(trans, topN = 10)
rules <- apriori(trans, parameter = list(supp=0.03, conf=0.4))
inspect(sort(rules[!is.redundant(rules)],by='lift'))
#Identifying maximal frequent sets,support ,confidence &lift
itemsets=unique(generatingItemsets(sort(rules, by="confidence")))
inspect(sort(itemsets, by="support"))
inspect(sort(itemsets[is.maximal(itemsets)], by="support"))
inspect(sort(rules, by='confidence'))
