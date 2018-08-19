library(dplyr)
library(tidyr)
library(ggplot2)
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

#test commit

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




#here is a function to calculate the mean mass of extant species and of extinct species by contenient
# this code is part of problem 3.  
get_mean_size_continent <- function(df){
  #this fuction takes a data frame of mammal sizes, and returns the mean mass of extant and extinct species
    mean_status_continent<- df %>%
    select(continent,status, order,species,combined_mass) %>% #select the needed collumns
    filter(status == "extinct"|status=="extant") %>% #filer for only extant and extinct
    na.omit() %>%                                    #omit NAs for mean
    group_by(continent,status) %>%                               # group by extant vs extinct
    summarize(mean_mass= mean(combined_mass))         # mean of each group. 
    cleaned <- spread(mean_status_continent,key=status,mean_mass) #this uses tidyr to make a collumn for extant and extinct
    
  return(cleaned)
}




mammal_sizes <- get_data()
head(mammal_sizes)


mean_sizes <- get_mean_size_extant_exticnt(mammal_sizes)
mean_sizes

by_continent <- get_mean_size_continent(mammal_sizes)
by_continent

##filtered mammals sizes input for the plot below
gg_input <- filter(mammal_sizes,status=="extant"|status=="extinct")
gg_input <- filter(gg_input,continent!="EA")
gg_input <- filter(gg_input,continent!="Oceanic")
gg_input <- filter(gg_input,continent!="Af")


#create a plot that shows histograms of extant vs extinct log size by continent
ggplot(gg_input, aes(x=log_mass)) +
  geom_histogram(binwidth=0.5) +
  facet_grid(status~ continent)

