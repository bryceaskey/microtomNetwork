# Install and load necessary packages
#install.packages("visNetwork")
library(visNetwork)

# Set working directory
setwd("C:/Users/Bryce/Research/microtomNetwork/merged/metaboliteSubset/")

# Load metabolite-gene interaction dataset and subset to include only edges of interest
metExprEdges <- read.csv(file="metExprEdges.csv")[, 2:4]
metExprEdgesSubset <- metExprEdges[metExprEdges$Gene == "Solyc05g005150.1", ]

# Load gene-gene interaction dataset and subset to include only edges of interest
exprEdges <- read.csv(file="exprEdgesNegative.csv")[, 2:4]
exprEdgesSubset <- exprEdges[exprEdges$Gene1 == "Solyc05g005150.1" | exprEdges$Gene2 == "Solyc05g005150.1", ]

# Check if there are any interactions between genes in network
networkGenes <- unique(c(exprEdgesSubset$Gene1, exprEdgesSubset$Gene2))
networkGenes <- networkGenes[networkGenes != "Solyc05g005150.1"]
exprEdgesSubset <- rbind(exprEdgesSubset, exprEdges[exprEdges$Gene1 %in% networkGenes & exprEdges$Gene2 %in% networkGenes, ] )

# Check if genes in network have any associations with metabolites in network
networkMetabolites <- unique(metExprEdgesSubset$Metabolite)
metExprEdgesSubset <- rbind(metExprEdgesSubset, metExprEdges[metExprEdges$Gene %in% networkGenes & metExprEdges$Metabolite %in% networkMetabolites, ])

# Format both edge dataframes
colnames(metExprEdgesSubset) <- c("from", "to", "color")
metExprEdgesSubset$color[metExprEdgesSubset$color=="+"] <- "#f8766d"
metExprEdgesSubset$color[metExprEdgesSubset$color=="-"] <- "#00bfc4"

colnames(exprEdgesSubset) <- c("from", "to", "color")
exprEdgesSubset$color[exprEdgesSubset$color=="+"] <- "#f8766d"
exprEdgesSubset$color[exprEdgesSubset$color=="-"] <- "#00bfc4"

# Merge edge datasets into a single dataframe
allEdges <- rbind(metExprEdgesSubset, exprEdgesSubset)

# Load gene expression dataset and subset  to only include genes in network
exprNodes <- read.csv(file="exprDataNegative.csv")[,c(1,2,7)]
colnames(exprNodes)[1] <- "Gene"
networkGenes <- unique(c(exprEdgesSubset$from, exprEdgesSubset$to))

exprNodesSubset <- exprNodes[exprNodes$Gene %in% networkGenes, ]
colnames(exprNodesSubset) <- c("id", "group", "title")
exprNodesSubset$label <- exprNodesSubset$id
exprNodesSubset$color <- NA
exprNodesSubset$color[exprNodesSubset$group==0] <- "#fafa6e"
exprNodesSubset$color[exprNodesSubset$group==1] <- "#85df81"
exprNodesSubset$color[exprNodesSubset$group==2] <- "#00ba9b"
exprNodesSubset$color[exprNodesSubset$group==3] <- "#008fa1"
exprNodesSubset$color[exprNodesSubset$group==4] <- "#00628a"
exprNodesSubset$color[exprNodesSubset$group==5] <- "#28385b"
exprNodesSubset$size <- 15
#exprNodesSubset$group <- NULL

# Load metabolite dataset
metNodes <- read.csv(file="subsetMetDataTF.csv")[,c(1,2,9)]
metNodesSubset <- metNodes[metNodes$Index %in% networkMetabolites, ]
colnames(metNodesSubset) <- c("id", "group", "title")
metNodesSubset$label <- metNodesSubset$id
metNodesSubset$color <- NA
metNodesSubset$color[metNodesSubset$group==0] <- "#fafa6e"
metNodesSubset$color[metNodesSubset$group==1] <- "#85df81"
metNodesSubset$color[metNodesSubset$group==2] <- "#00ba9b"
metNodesSubset$color[metNodesSubset$group==3] <- "#008fa1"
metNodesSubset$color[metNodesSubset$group==4] <- "#00628a"
metNodesSubset$color[metNodesSubset$group==5] <- "#28385b"
metNodesSubset$size <- 30
#metNodesSubset$group <- NULL

# Merge gene expression and metabolite datasets to generate node data
allNodes <- rbind(metNodesSubset, exprNodesSubset)

# Draw network
visNetwork(allNodes, allEdges) %>%
  visPhysics(timestep = 0.25) %>%
  visOptions(highlightNearest=list(enabled=TRUE, degree=1)) %>%
  visLegend(
    addNodes=list(
      list(label="0", shape="ellipse", color="#fafa6e"),
      list(label="1", shape="ellipse", color="#85df81"),
      list(label="2", shape="ellipse", color="#00ba9b"),
      list(label="3", shape="ellipse", color="#008fa1"),
      list(label="4", shape="ellipse", color="#00628a", font=list(color="#ffffff")),
      list(label="5", shape="ellipse", color="#28385b", font=list(color="#ffffff"))
    ),
    main=list(text="Cluster legend:", style="font-family:sans-serif;font-size:16px"),
    useGroups=FALSE
  ) %>%
  visSave(file="network.html")
