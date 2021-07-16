OpenFashionTrain <- function(){
  fashionTrainFile <- file("./BinaryData/MNIST-Fashion-Train-Uint8.bin", "rb")
  fashionData <- readBin(fashionTrainFile, "integer", 28*28*60000, 1, signed = FALSE)
  fashionDataMatrix <- matrix(fashionData, 60000, 28*28, TRUE)
  close(fashionTrainFile)
  return(fashionDataMatrix)
}



OpenFashionTest <- function(){
  fashionTestFile <- file("./BinaryData/MNIST-Fashion-Test.bin", "rb")
  fashionTestData <- readBin(fashionTestFile, "double", 28*28*10000, 4, endian="big")
  fashionTestDataMatrix <- matrix(fashionTestData, 10000, 28*28, TRUE)
  close(fashionTestFile)
  return(fashionTestDataMatrix)
}

OpenCentersOfMass <- function(){
  centerOfMassFile <- file("./BinaryData/MNIST-Fashion-Train-COMs.bin", "rb")
  #open(centerOfMassFile)
  
  numEntries <- readBin(centerOfMassFile, "integer", 1, 8, endian="big")
  vectorLength <- readBin(centerOfMassFile, "integer", 1, 8, endian="big")
  
  #splittingIndicies <- vector("integer", numEntries)
  COMweight <- vector("integer", numEntries)
  dataMatrix <- matrix(nrow = 0, ncol = vectorLength)
  
  for (i in 1:numEntries){
    #splittingIndicies[i] <- readBin(centerOfMassFile, "integer", 1, 8, endian="big")
    COMweight[i] <- readBin(centerOfMassFile, "integer", 1, 8, endian="big")
    dataMatrix <- rbind(dataMatrix, readBin(centerOfMassFile, "double", vectorLength, 8, endian="big"))
  }
  
  close(centerOfMassFile)
  
  #weightFrame <- data.frame(COMweight, row.names = splittingIndicies)
  
  retList <- list(COMweight, dataMatrix)
  return(retList)
}

OpenMetaGraph <- function(){
  metaGraphFile <- file("./BinaryData/MNIST-Fashion-Test-MetaGraphEdges.bin", "rb")
  #open(metaGraphFile)
  
  graphSize <- readBin(metaGraphFile, "integer", 1, 8, endian="big")
  
  blockNums <- vector("integer", graphSize)
  verticies <- vector("list", graphSize)
  
  for (i in 1:graphSize){
    blockNums[i] <- readBin(metaGraphFile, "integer", 1, 8, endian="big")
    numEdges <- readBin(metaGraphFile, "integer", 1, 8, endian="big")
    edges <- matrix(nrow = numEdges, ncol = 2)
    for (j in 1:numEdges){
      edges[j,1] <- readBin(metaGraphFile, "integer", 1, 8, endian="big")
      edges[j,2] <- readBin(metaGraphFile, "double", 1, 8, endian="big")
    }
    verticies[[i]] <- edges
  }
  
  close(metaGraphFile)
  retList <- list(blockNums, verticies)
  return(retList)
}

OpenTrainBlockNumbers <- function(){
  indiciesFile <- file("./BinaryData/MNIST-Fashion-Train-SplittingIndicies.bin", "rb")
  vectorSize <- readBin(indiciesFile, "integer", 1, 8, endian="big")
  trainSplittingIndicies <- readBin(indiciesFile, "integer", vectorSize, 8, endian="big")
  close(indiciesFile)
  return(trainSplittingIndicies)
}

FashionTrainData <- OpenFashionTrain()
FashionTestData <- OpenFashionTest()
CentersOfMass <- OpenCentersOfMass()
MetaGraph <- OpenMetaGraph()
TrainBlockNumbers <- OpenTrainBlockNumbers()

