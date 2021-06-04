Goals/Objectives
The goal of this repository is to create a package that can quickly and easily take an image fine (that is in the proper format), and run a color segmentation program on it to allow for the identification of water (well, blue) in image files. This program will work with three channel RBG .tif files and four channel RGBA .tif files.
Motivation
There is an existing method for detecting water using multispectral satellite imagery which uses NDWI and MNDWI to identify water and create a raster mask of the image that excludes anything that is not water. Considering that my project for GIS 2 was attempting to color segment a raster image to find the water, I decided that I should generalize my code from that project and make a package out of it. That package is WaterDetect, and its only function is Detect_water. 
Data/Spatial Temporal scale. 
https://towardsdatascience.com/water-detection-in-high-resolution-satellite-images-using-the-waterdetect-python-package-7c5a031e3d16
My Data was the existing .tif files I had used for the project for GIS 2 as well and manipulated screen shots that I used to provide some variability in size shape and composition of the rasters, as well as be in both RGB and RGBA formats. The scale of data inputs can be big for small. One .tif file is a map of the city of Angkor in Cambodia an ancient city that stretches over hundreds of square kilometers. Another is a landscape photo of the Athenian Acropolis, with the blue sky standing in for water. Another could be the coastline of the city of New York, or Chicago.  
Methods. 
The challenges coming out from my GIS 2 project were three-fold. How to deal with RGBA files, how to branch the program depending on the .tif files dimensions (the number of color channels), and how to import packages into your own  r packages. The first was solved after doing some research on  matrix notation in R and adding an extra column into the notation fixed the issue. The second issue, required the use of an if expression, running the code twice with the decision being based on 

if (dim(Fig[,,3])) {Code} else if (dim(Fig[,,4])) {Code).
Note (code) is largely the same, with new names for the data involved to aviod crossed wires

The third column of the of the dimensions denotes the number of color channels in the image, 3 for RGB and 4 for RGBA files. The third issue revolved around both how to import packages, and later which packages to import. In the original code I used “raster”, “sf”, “tidyverse”, and “tiff”. Tiff would need to be used by the user since trying to make the package capable of reading in the user’s data quickly became too thorny of an issue. Once I managed to learn the  proper use of the use_package function, troubleshooting began to see which packages were necessary. What ended up being the solution was to edit the namespace file directly, even though we were told not to do that, to ensure the import of packages. The persistent error 
“Error in as.double(y) : cannot coerce type 'S4' to vector of type 'double.'”
 This error was due to my using sf to wrangle either the raster files or the matrices into agreeable formats. This meant that “raster” and “sf” needed to be imported with this package. 
	

Results. 
 
Image 1 ![image](https://user-images.githubusercontent.com/82319965/120856253-8cc7f380-c54d-11eb-9c03-d07baca31179.png)
Image 2 ![image](https://user-images.githubusercontent.com/82319965/120856265-92253e00-c54d-11eb-8079-13ee480a9283.png)


Image 1 is the output of a landscape photograph (See below for original image). Image 2 is a map of the city center of Angkor. Both have been recoded to make water blue.
3 ![image](https://user-images.githubusercontent.com/82319965/120856364-be40bf00-c54d-11eb-8d7a-ddf51f65e04b.png)


Results/Limitations. 
These two examples show that the work is largely successful, but it struggles with white space. In the map of Angkor, much of the green in the bottom third of the image is in fact white space. This is due to the problems of K means clustering with the RGB values for white and black. Since the k means vary from image to image, back-end work needs to be done to remove white cells from the images. Fortunately, anything less than the pure white of a prepared figure like a map doesn’t have this problem to a meaningful degree, as shown by the successful capture of the sky in the landscape photograph. In the future this would need to be fixed within the package, perhaps as a second “cleanup” function, or within the Detect_water function itself. 
