# MicroTom Co-expression Network Analysis
## Overview:
The code in this repository roughly follows the workflow described by Li et al. (2020), and was used to conduct a co-expression analysis in MicroTom tomato. The co-expression network connects metabolite accumulation to gene expression throughout the life cycle of tomato, from seedling to mature fruit. This work was originally submitted as a series of assignments for the class ABE4662: Quantification of Biological Processes. For this submission, it was split into 3 projects, but some additional analyses were continued after.

## Repository contents:
<b>project1</b> - Generation of a simple gene network, with a breakdown of the Pearson Correlation Coefficient. (Python)

<b>project2</b> - Normalization of metabolite data, and separation of metabolites into clusters with k-means clustering. (Python)

<b>project3</b> - Integration of the gene network and metabolite clusters into a single co-expression network, and drawing of an interactive network diagram. (Python + R)

<b>merged</b> - Merging of all 3 projects using entire published metabolite and gene expression datasets. Z-score normalization is applied instead of quantile normalization.

<b>heatmaps</b> - Generation of metabolite and gene expression heatmaps from Z-score data.

## References:
Li, Y., Chen, Y., Zhou, L., You, S., Deng, H., Chen, Y., Alseekh, S., Yuan, Y., Fu, R., Zhang, Z., Su, D., Fernie, A. R., Bouzayen, M., Ma, T., Liu, M., & Zhang, Y. (2020). MicroTom Metabolic Network: Rewiring Tomato Metabolic Regulatory Network throughout the Growth Cycle. Molecular Plant, 13(8), 1203–1218. https://doi.org/10.1016/j.molp.2020.06.005