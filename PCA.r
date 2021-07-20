source("./OpenData.r")

library(ggplot2)
library(uwot)
#prcomp vs princomp
#prcomp SVD
#princomp eigen decomp of A^T A

pcaTime <- system.time(pca <- prcomp(FashionTrainData, rank = 2))
pcaFrame <- data.frame(pca[["x"]])
pcaPlot <- ggplot(pcaFrame, aes(x = PC1, y = PC2, color = TrainBlockNumbers)) + geom_point(size = 1, shape = ".") +
            scale_color_continuous(type = "viridis")
print(pcaPlot)

rotatedCOMs <- data.frame(CentersOfMass[[2]] %*% pca[["rotation"]])

compositePlot <- ggplot() + geom_point(data = pcaFrame, aes(x = PC1, y = PC2, color = TrainBlockNumbers), size = 1, shape = ".") +
  geom_point(data = rotatedCOMs, aes(x = PC1, y = PC2, color = (1:nrow(rotatedCOMs))), size = 2) +
  scale_color_continuous(type = "viridis", guide = guide_colorbar(title = "Block Number"))

svdTime <- system.time(TrainSVD <- svd(FashionTrainData))











translatedCOMs <- CentersOfMass[[2]]
for (i in 1:nrow(translatedCOMs)){
  for (j in 1:length(pca[["center"]])){
    translatedCOMs[i,j] <- translatedCOMs[i,j] - pca[["center"]][j]
  }
}

translatedCOMframe <- data.frame(translatedCOMs %*% pca[["rotation"]])
translatedPlot <- ggplot() + geom_point(data = pcaFrame, aes(x = PC1, y = PC2, color = TrainBlockNumbers), size = 1, shape = ".") +
  geom_point(data = translatedCOMframe, aes(x = PC1, y = PC2, color = (1:nrow(translatedCOMframe))), size = 2) +
  scale_color_continuous(type = "viridis", guide = guide_colorbar(title = "Block Number"))