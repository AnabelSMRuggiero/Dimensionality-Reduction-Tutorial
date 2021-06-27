#source("./OpenData.r")


#prcomp vs princomp
#prcomp SVD
#princomp eigen decomp of A^T A
pca <- prcomp(FashionTrainData, tol = sqrt(.Machine$double.eps))
