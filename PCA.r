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











comTranslations <- colMeans(rotatedCOMs)
for (i in 1:length(rotatedCOMs[[1]])){
  rotatedCOMs[[1]][i] <- rotatedCOMs[[1]][i] - comTranslations[1]
  rotatedCOMs[[2]][i] <- rotatedCOMs[[2]][i] - comTranslations[2]
}