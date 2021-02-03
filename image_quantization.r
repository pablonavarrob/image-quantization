setwd("/Users/pablo/Desktop/Herts Master/Machine Learning /Exercises/Lab 2")
library("jpeg")
library("png")
library("grid")
library("gridExtra")
library(OpenImageR)


# Exercise 4 of sheet 2
# Reduce number of colors that occur in an image
dims = 100

# Load JPEG
raw_image <- readJPEG("image.jpeg")
r <- c(raw_image[,,1], dim=c(622104))
g <- c(raw_image[,,2], dim=c(622104))
b <- c(raw_image[,,3], dim=c(622104))
  
img <- data.frame('r'= r, 'g'= g, 'b'=b)

# Run k-means on the data frame 
kmeans_img <- kmeans(img, dims)

# Need to replace the colors from the original arrays
# with the mean ones. Can do so recursively I guess?
# dims = amount of clusters aka different color values 
cluster_means = kmeans_img$centers
cluster_index = kmeans_img$cluster

for (i in 1:dims){
  r[cluster_index == i] <- cluster_means[,1][i]
  g[cluster_index == i] <- cluster_means[,2][i]
  b[cluster_index == i] <- cluster_means[,3][i]
}

quantized_image <- array(c(r, g, b), dim=dim(raw_image))
writeImage(quantized_image, sprintf("quantized_image_dims%s.jpeg", dims))
