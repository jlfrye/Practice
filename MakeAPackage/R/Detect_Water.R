#' Title
#'
#' @param x Must be a .tif file
#'Checks dimensions
#'Diverts by if into RGB and RGBA
#'Performs K-means clustering
#'Segments data "Fig" raster into three matrices by color channel
#'Replaces matrix values with the K mean for each color
#'Reshapes matricies so they match the original raster
#'Converts back to Raster
#' @return Plot of color segmented raster with green = blue
#' @export
#'
#'
Detect_water <- function(x) {
Fig = x
if (dim(Fig[,,3])) {

  df = data.frame(
    red = matrix(Fig[,,1], ncol=1),
    green = matrix(Fig[,,2], ncol=1),
    blue = matrix(Fig[,,3], ncol=1))
  K = kmeans(df,4)
  df$label = K$cluster
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

  R = matrix(df$R, nrow=dim(Fig)[1])
  G = matrix(df$G, nrow=dim(Fig)[1])
  B = matrix(df$B, nrow=dim(Fig)[1])

  B_raster <- raster(B)
  R_raster <- raster(R)
  G_raster <- raster(G)
  plot(B_raster)} else if (dim(Fig[,,4])) {

    dfA = data.frame(

      red.A = matrix(Fig[,,1], ncol=1),
      green.A = matrix(Fig[,,2], ncol=1),
      blue.A = matrix(Fig[,,3], ncol=1))

    KA = kmeans(df,4)
    df$label = K$cluster

    colorsA = data.frame(
      label = 1:nrow(K$centers),
      RA = K$centers[,"red.A"],
      GA = K$centers[,"green.A"],
      BA = K$centers[,"blue.A"]
    )

    dfA$order = 1:nrow(dfA)
    dfA = merge(dfA, colorsA)
    dfA = df[order(dfA$order),]
    dfA$order = NULL

    RA = matrix(dfA$RA, nrow=dim(Fig)[1])
    GA = matrix(dfA$GA, nrow=dim(Fig)[1])
    BA = matrix(dfA$BA, nrow=dim(Fig)[1])



    BA_raster <- raster(BA)
    RA_raster <- raster(RA)
    GA_raster <- raster(GA)


    sf::plot(BA_raster)}}
