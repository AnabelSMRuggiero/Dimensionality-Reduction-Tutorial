source("./OpenData.r")

library(ggplot2)
library(uwot)
#prcomp vs princomp
#prcomp SVD
#princomp eigen decomp of A^T A

pcaTime <- system.time(pca <- prcomp(FashionTrainData, tol = sqrt(.Machine$double.eps), rank = 2))
#pcaFrame <- data.frame(pca[["x"]])
#ggplot(pcaFrame, aes(x = PC1, y = PC2, color = TrainSplittingIndicies)) + geom_point(size = 1, shape = ".")

#embedding <- umap(FashionTrainData)
#umapFrame <- data.frame(embedding)
#ggplot(umapFrame, aes(x = X1, y = X2, color = TrainSplittingIndicies)) + geom_point(size = 1, shape = ".") + scale_color_continuous(type = "viridis")


#embeddingModel <- umap(FashionTrainData, ret_model = TRUE)
#transformedCOMs <- umap_transform(CentersOfMass[[2]], embeddingModel)
#umapFrame <- data.frame(embeddingModel[1])
#COMsFrame <- data.frame(transformedCOMs)
#ggplot(umapFrame, aes(x = X1, y = X2, color = TrainSplittingIndicies)) + geom_point(size = 1, shape = ".") + scale_color_continuous(type = "viridis")
#compositePlot <- ggplot() + geom_point(data = umapFrame, aes(x = embedding.1, y = embedding.2, color = TrainBlockNumbers), size = 1, shape = ".") +
#  geom_point(data = COMsFrame, aes(x = X1, y = X2, color = (1:nrow(transformedCOMs))), size = 2) +
#  scale_color_continuous(type = "viridis", guide = guide_colorbar(title = "Block Number"))



#for (i in 1:length(MetaGraph[[1]])){
#  blockNumber <- MetaGraph[[1]][i]
#  weightAccumulator <- 0.0
  #for (j in 1:length(MetaGraph[[2]][[i]])){
#  for (j in 1:3){
    #I accidentally reverse sorted this data. Go back and fix it later
#    entryLength <- length(MetaGraph[[2]][[i]])
#    targetBlock <- MetaGraph[[2]][[i]][entryLength/2-j, 1]
#    edgeWeight <- MetaGraph[[2]][[i]][entryLength/2-j, 2]
#    weightAccumulator <- weightAccumulator + edgeWeight
#    if (targetBlock != blockNumber){
#      curvePoints <- data.frame(x1 = COMsFrame[[1]][blockNumber+1], y1 = COMsFrame[[2]][blockNumber+1], x2 = COMsFrame[[1]][targetBlock+1], y2 = COMsFrame[[2]][targetBlock+1])
#      compositePlot <- compositePlot + geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2),
#                                                  data = curvePoints,
#                                                  alpha = 0.4,
#                                                  curvature = 0.2)
#    }
#  }
#}

#print(compositePlot)