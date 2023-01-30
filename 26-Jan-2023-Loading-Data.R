##### Lecture 8: Loading in Data into R as a Dataframe
##### 26 Jan 2023
##### UUI

##Steps to load Data:


#Create and save a dataset
### write.table() takes in your data set. use this one to specify 
  #write.table(x=varName, file="outputFileName.csv", header=T, sep=",") # comma in quotes if csv

#Read in a data set
### read.csv() #another option to read data
  # read.table(file="pathway to.csv", header=T, sep=",")
  #read.csv(file="pathway to data.csv", header=T)

#Use RDS to create an R object when only working in R. Instead of sending huge file, you can save it as RDS object and send it to other people who also want to see your work. Helpful with large datasets
  #saveRDS(my_data, file="FileName. RDS")
  #readRDS("FileName.RDS")
#to save: p<- readRDS("FileName.RDS")

#Long vs Wide data formats
  #wide format contains values that DO NOT repeat in the ID column
  #long format contains values that DO repeat in the ID column

####example:

library(tidyverse)
library(ggthemes)
head(billboard)

b1 <- billboard %>% #tibbit
  pivot_longer(
    cols=starts_with("wk"), #specify which columns you want to make 'longer'
    names_to="Week", #name of new column which will contain header column
    values_to="Rank", #name of new column which will contain the values
    values_drop_na=T #drops all the rows where there are NAs
  )
View(b1)    

##Pivot_wider 
glimpse(fish_encounters)
View(fish_encounters)    

fish_encounters %>%
  pivot_wider(names_from=station,#which column you want to turn into multiple columns
              values_from=seen) #which columns contain the values for the new cells

#Remove NAs
fish_encounters %>%
  pivot_wider(names_from=station,
              values_from=seen, 
              values_fill=0) #fills any NAs with 0.


### Dryad: is a research data website that helps you load data

##read.table()
dryadData <- read.table(file="Data/veysey-babbitt_data_amphibians.csv", header=T, sep=',')
glimpse(dryadData)
head(dryadData)
table(dryadData$species) # allows you to see different groups of character column
summary(dryadData$mean.hydro)




