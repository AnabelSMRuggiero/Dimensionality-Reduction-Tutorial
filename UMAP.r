source("./OpenData.r")

library(ggplot2)
library(uwot)

umapTime <- system.time(embedding <- umap(FashionTrainData, n_threads = 1))
umapFrame <- data.frame(embedding)
umapPlot<- ggplot(umapFrame, aes(x = X1, y = X2, color = TrainBlockNumbers)) +
             geom_point(size = 1, shape = ".") + scale_color_continuous(type = "viridis")

print(umapPlot)