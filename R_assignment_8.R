
#here is a funciton to get the mammal size data
get_data <- function(){
  #first we use read.csv to querry the downloaded flie.  -999 is treated as NAs, and strings as factors.
  data <- read.csv("data/MOMv3.3.txt",sep = "\t",header=F,stringsAsFactors = FALSE, na.strings = "-999")
  # Here the function adds collumn names to the data file
  colnames(data) <- c("continent", "status", "order", 
                              "family", "genus", "species", "log_mass", "combined_mass", 
                              "reference")
  return(data)
}







mammal_sizes <- get_data()
head(mammal_sizes)
