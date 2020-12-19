# Install and load necessary packages
#install.packages("visNetwork")
library(visNetwork)

# Set working directory
setwd("C:/Users/bca08_000/Documents/Classes/ABE4662/project3/")

# Load and merge node datasets
metNodes <- read.csv(file="preprocessedData/metData.csv")[,c(1,2,9)]
colnames(metNodes) <- c("id", "group", "title")
metNodes$label <- metNodes$id
metNodes$color <- NA
metNodes$color[metNodes$group==0] <- "#36871F"
metNodes$color[metNodes$group==1] <- "#996800"
metNodes$color[metNodes$group==2] <- "#BE414D"
metNodes$color[metNodes$group==3] <- "#974C98"
metNodes$size <- 30
metNodes$group <- NULL

exprNodes <- read.csv(file="preprocessedData/exprData.csv")[,c(1,6)]
colnames(exprNodes) <- c("id", "title")
exprNodes$label <- exprNodes$id
exprNodes$color <- "#97C2FC"
exprNodes$size <- 15

allNodes <- rbind(metNodes, exprNodes)

# Load and merge edge datasets
metExprEdges <- read.csv(file="preprocessedData/metExprEdges.csv")[, 2:4]
colnames(metExprEdges) <- c("from", "to", "color")
metExprEdges$color[metExprEdges$color=="+"] <- "#f8766d"
metExprEdges$color[metExprEdges$color=="-"] <- "#00bfc4"

exprEdges <- read.csv(file="preprocessedData/exprEdges.csv")[, 2:4]
colnames(exprEdges) <- c("from", "to", "color")
exprEdges$color[exprEdges$color=="+"] <- "#f8766d"
exprEdges$color[exprEdges$color=="-"] <- "#00bfc4"

allEdges <- rbind(metExprEdges, exprEdges)

# Draw network
visNetwork(allNodes, allEdges) %>%
  visOptions(highlightNearest=TRUE)