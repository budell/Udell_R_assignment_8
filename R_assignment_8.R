library(dplyr)

#here is a funciton to get the mammal size data
# this code is part of problem 1
get_data <- function(){
  #first we use read.csv to querry the downloaded flie.  -999 is treated as NAs, and strings as factors.
  data <- read.csv("data/MOMv3.3.txt",sep = "\t",header=F,stringsAsFactors = FALSE, na.strings = "-999")
  
  # Here the function adds collumn names to the data file
  colnames(data) <- c("continent", "status", "order", 
                              "family", "genus", "species", "log_mass", "combined_mass", 
                              "reference")
  #this line removes the mammals that went extinct in the recent past
  data <- subset(data,status != "historical")
  
  return(data)
}


#here is a function to calculate the mean mass of extant species and of extinct species
# this code is part of problem 2.  
get_mean_size_extant_exticnt <- function(df){
  #this fuction takes a data frame of mammal sizes, and returns the mean mass of extant and extinct species
    status_means <- df %>%
     select(status, order,species,combined_mass) %>% #select the needed collumns
      filter(status == "extinct"|status=="extant") %>% #filer for only extant and extinct
      na.omit() %>%                                    #omit NAs for mean
    group_by(status) %>%                               # group by extant vs extinct
     summarize(mean_mass= mean(combined_mass))         # mean of each group. 
   return(status_means)
}



mammal_sizes <- get_data()
head(mammal_sizes)


mean_sizes <- get_mean_size_extant_exticnt(mammal_sizes)
meanmean_sizes



