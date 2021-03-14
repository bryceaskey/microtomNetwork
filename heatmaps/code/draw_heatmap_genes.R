# Given a list of genes, draw a heatmap of z-scores across 20 sampling points

# Import libraries
library(tidyverse)

# Import gene expression z-scores and list of genes of interest
exprData <- read.csv(file="C:/Users/Bryce/Documents/microtomNetwork/heatmaps/data/exprDataTF.csv")
geneList <- scan(file="C:/Users/Bryce/Documents/microtomNetwork/heatmaps/UGTs_and_MTs.txt", what="list", quiet=TRUE)

# Filter expression data to include only those genes from the list provided
plotData <- exprData[exprData$Gene %in% geneList,]

# Print a warning in case any genes from the list provided could not be found
if(length(geneList) != nrow(plotData)){
  print("Warning, the following genes could not be found in the expression dataset:")
  print(setdiff(geneList, plotData$Gene))
}

# Format data for plotting
plotData <- pivot_longer(data=plotData, cols=c(7:ncol(plotData)), names_to="Sample", values_to="Z_score")
plotData$Sample <- factor(plotData$Sample, levels=c("R30", "R45", "R85", "S30", "S45", "S85", "L30", "L45", "L85", "F30", "F45",
                                                    "DPA10", "DPA20", "IMG", "MG", "Br", "Br3", "Br7", "Br10", "Br15"))
plotData$Gene <- fct_rev(factor(plotData$Gene, levels=geneList))

# Draw heatmap
heatmap <- ggplot(data=plotData, mapping=aes(x=Sample, y=Gene, fill=Z_score)) +
  geom_raster() +
  scale_fill_gradient2(midpoint=0, low="blue", mid="white", high="red", limits=c(-max(abs(plotData$Z_score)), max(abs(plotData$Z_score)))) +
  theme_minimal() +
  theme(legend.position="top", legend.direction="horizontal",
        axis.text.x=element_text(angle=90, hjust=1),
        axis.text=element_text(color="black"))

# Save heatmap as a .pdf
ggsave(filename="C:/Users/Bryce/Documents/microtomNetwork/heatmaps/figures/UGTs_and_MTs.pdf",
       plot=heatmap,
       device=pdf(),
       width=max(str_length(geneList))/16 + 5, height=(nrow(plotData)/75) + 1.5, units="in")


graphics.off()