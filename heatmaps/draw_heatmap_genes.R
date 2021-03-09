# Given a list of genes, draw a heatmap of z-scores across 20 sampling points

# Import libraries
library(tidyverse)
library(viridis)

# Import gene expression z-scores and list of genes of interest
exprData <- read.csv(file="C:/Users/Bryce/Documents/microtomNetwork/heatmaps/exprDataTF.csv")
geneList <- scan(file="C:/Users/Bryce/Documents/microtomNetwork/heatmaps/UGTs_and_MTs.txt", what="list", quiet=TRUE)

sum(geneList %in% exprData$Gene)

sum(grepl(paste(geneList[1], "-", sep=""), exprData$Gene))
