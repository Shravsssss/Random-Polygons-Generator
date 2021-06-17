#Install the packages needed
#"randgeo" package is used for wkt_polygon generation
#"MODIS" package is used for getting the file size
#install.packages("randgeo")
#install.packages("MODIS")

#Start the time for polygon generation
start_time <- Sys.time()

#Include the packages installed
library(randgeo)
library("MODIS")

#Produce 10 WKT polygons with random uniform vertices between 10 and 500 for every polygon
#max_radial_length is the maximum distance that a vertex can reach out of the center of the polygon
wkt_file_data = wkt_polygon(count = 10, num_vertices = runif(1,10,500) , max_radial_length = 5)
wkt_file_data

#Create a file "polygons.txt" and store the data from "wkt_file_data" variable into this file 
fileConn<-file("polygons.txt")
writeLines(wkt_file_data, fileConn, sep="\n")
#Close the file 
close(fileConn)

#Stop the time 
end_time <- Sys.time()
#Total time taken for this random polygon generation program
time <- end_time - start_time
print(time)

#Printing the size of the file in bytes
print(fileSize('polygons.txt', units = "B"))
