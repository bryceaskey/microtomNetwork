# Given a list of metabolites, draw a heatmap of z-scores across 20 sampling points

# Import libraries
library(tidyverse)

# Import metabolite accumulation z-scores and list of metabolites of interest
metData <- read.csv(file="C:/Users/Bryce/Research/microtomNetwork/heatmaps/metDataTF.csv")
metList <- scan(file="C:/Users/Bryce/Research/microtomNetwork/heatmaps/flavonoids.txt", what="list", sep="\n", quiet=TRUE)

# Filter expression data to include only those metabolites from the list provided
plotData <- metData[metData$Compound.name %in% metList,]

# Print a warning in case any metabolites from the list provided could not be found
if(length(metList) != nrow(plotData)){
  print("Warning, the following metabolites could not be found in the metabolite dataset:")
  print(setdiff(metList, plotData$Compound.name))
}

# Format data for plotting
plotData <- pivot_longer(data=plotData, cols=c(10:ncol(plotData)), names_to="Sample", values_to="Z_score")
plotData$Sample <- factor(plotData$Sample, levels=c("R30", "R45", "R85", "S30", "S45", "S85", "L30", "L45", "L85", "F30", "F45",
                                                    "DPA10", "DPA20", "IMG", "MG", "Br", "Br3", "Br7", "Br10", "Br15"))
plotData$Compound.name <- fct_rev(factor(plotData$Compound.name, levels=metList))

# Draw heatmap
heatmap <- ggplot(data=plotData, mapping=aes(x=Sample, y=Compound.name, fill=Z_score)) +
  geom_raster() +
  scale_fill_gradient2(midpoint=0, low="blue", mid="white", high="red", limits=c(-max(abs(plotData$Z_score)), max(abs(plotData$Z_score)))) +
  theme_minimal() +
  theme(legend.position="top", legend.direction="horizontal",
        axis.text.x=element_text(angle=90, hjust=1),
        axis.text=element_text(color="black"))

# Save heatmap as a .pdf
ggsave(filename="C:/Users/Bryce/Research/microtomNetwork/heatmaps/figures/flavonoids.pdf",
       plot=heatmap,
       device=pdf(),
       width=max(str_length(metList))/16 + 5, height=(nrow(plotData)/75) + 1.5, units="in")

graphics.off()