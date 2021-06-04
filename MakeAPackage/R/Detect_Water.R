Detect_water <- function(x) {
#Load necessary packages
  library(sf)
  library(raster)
#Read in file
Fig = x
#Check for an alpha (transparency) channel
dim(Fig)
if (dim(Fig[,,3])) {
  #K-means clustering
  df = data.frame(
    #Segment data "Test" raster into three matrices by color channel
    red = matrix(Fig[,,1], ncol=1),
    green = matrix(Fig[,,2], ncol=1),
    blue = matrix(Fig[,,3], ncol=1))
  K = kmeans(df,4)
  df$label = K$cluster
  #Replace values with the center or mean value for each color
  colors = data.frame(
    label = 1:nrow(K$centers),
    R = K$centers[,"red"],
    G = K$centers[,"green"],
    B = K$centers[,"blue"]
  )
  df$order = 1:nrow(df)
  df = merge(df, colors)
  df = df[order(df$order),]
  df$order = NULL
  #Reshape matricies so they match the original raster
  R = matrix(df$R, nrow=dim(Fig)[1])
  G = matrix(df$G, nrow=dim(Fig)[1])
  B = matrix(df$B, nrow=dim(Fig)[1])
  #Convert to Raster
  B_raster <- raster(B)
  R_raster <- raster(R)
  G_raster <- raster(G)
  plot(B_raster)} else if (dim(Fig[,,4])) {
    df = data.frame(
      #Segment data "Test" raster into three matrices by color channel
      red.A = matrix(Fig[,,1], ncol=1),
      green.A = matrix(Fig[,,2], ncol=1),
      blue.A = matrix(Fig[,,3], ncol=1))
    #K-means clustering
    K = kmeans(df,4)
    df$label = K$cluster
    #Replace values with the center or mean value for each color
    colors = data.frame(
      label = 1:nrow(K$centers),
      R = K$centers[,"red.A"],
      G = K$centers[,"green.A"],
      B = K$centers[,"blue.A"]
    )
    df$order = 1:nrow(df)
    df = merge(df, colors)
    df = df[order(df$order),]
    df$order = NULL
    #Reshape matricies so they match the original raster
    R = matrix(df$R, nrow=dim(Fig)[1])
    G = matrix(df$G, nrow=dim(Fig)[1])
    B = matrix(df$B, nrow=dim(Fig)[1])
    #Convert to Raster
    B_raster <- raster(B2)
    R_raster <- raster(R)
    G_raster <- raster(G)
    #plot
    plot(B_raster)}}
