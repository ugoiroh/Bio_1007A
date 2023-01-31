##### Simple Data Analysis and More Complex Control Structures
##### 30 Jan 2023
##### UUI

#Loading Data
dryadData <- read.table(file="Data/veysey-babbitt_data_amphibians.csv", header=T, sep=",")

#Setting up libraries
library(tidyverse)
library(ggthemes)


##### Types of Analyses

#Experimental Designs:
#Independent variable (x-axis) vs dependent variable (y-axis)

#continuous (range of numbers. for example, height, weight, temperature -> anything number related) vs. discrete/categorical (categories, for example, species, treatments, locations) 

#comparing two continuous: linear regression analysis--use a scatterplot to visualize!
#comparing x and y: t-test (2 groups) and ANOVA (2 groups)--use a boxplot, barplot to visualize!
#comparing two categorical (x-axis): ex. number of males and females: chi-square--use table or mosaic 

glimpse(dryadData)


### Basic linear regression (2 continuous variables)

######Example 1:
#We're asking if there is a relationship btwn mean pool hydroperiod and the number of breeding frogs caught?

## remember yVar~xVar
regModel <- lm(count.total.adults~mean.hydro, data=dryadData) #lm=linear model
summary(regModel) #summary gives us all the important info of the relationship
hist(regModel$residuals) #residuals under summary gives us hist info
summary(regModel)$"r.squared" #mean of coefficient 

#making a scatterplot with this data

regPlot <- ggplot(data=dryadData, aes(x=mean.hydro, y=count.total.adults)) +
  geom_point(size=2) +
  stat_smooth(method=lm, se=0.99) #lets say we want to add a linear regression, se=standard error
  regPlot + theme_few() 

### Basic ANOVA
#Question: Was there a statistically significant different in the number of adults between the wetlands?
  
#Remember: yVar~xVar  
ANOmodel <- aov(count.total.adults~factor(wetland), data=dryadData) #always make sure that factor is there because it tells R that they are two DIFFERENT groups
summary(ANOmodel)

dryadData %>%
  group_by(factor(wetland)) %>%
  summarize(avgHydro=mean(count.total.adults, na.rm=T), N=n()) 

##Making Boxplot with ANOVA

# making sure that wetlands is factored: we can override the entire data

dryadData$wetland <- factor(dryadData$wetland)
class(dryadData$wetland)

ANOplot2 <- ggplot(data=dryadData, aes(x=wetland, y=count.total.adults, fill=species)) + 
  geom_boxplot() + scale_fill_grey()
ANOplot2
ggsave(file="SpeciesBoxPlots.pdf", plot=ANOplot2, device="pdf") #saves image 


##Logistic and Regression
##Let'simulate our own dataframe since the old one isn't really appropriate for what we want


xVar <- sort(rgamma(n=200, shape=5, scale=5)) #gamma probabilities are best for continuous variables that are always positive and have a skewed distribution. We're just setting up parameters for this distribution

yVar <- sample(rep(c(1,0), each=100), prob=seq_len(200)) #seq_length=(1:200)
logRegData <- data.frame(xVar, yVar)

### Logistic Regression Analysis of our simulated Data

logRegData <- glm(yVar~xVar, data=logRegData, 
                  family=binomial(link=logit))
summary(logRegData)

logRegPlot <- ggplot(data=logRegData, aes(x=xVar, y=yVar)) + geom_point() +
  stat_smooth(method="glm", method.args=list(family=binomial))


#### Contingency table (chi-squared analysis)--both variables are categorical
##Question: Are there differences in count between male and females between species?

countData <- dryadData %>%
  group_by(species) %>%
  summarize(Males=sum(No.males, na.rm=T), Females=sum(No.females, na.rm=T)) %>%
  select(-species) %>% #remove species column
  as.matrix() #converts to matrix
countData 

row.names(countData)=c("SS", "WF") #names of rows

##chi-squared
chisq.test(countData)$residuals #residuals=how far away observations is from expected observation

##Visualize chi-squared using mosaic plot 

mosaicplot(x=countData, col=c("goldenrod", "grey"), shade=F)

##Making barplots of these counts

countDataLong <- countData %>%
  as_tibble() %>% #convert to tibble first, it won't work unless otherwise
  mutate(Species=c(rownames(countData))) %>% #gives us a column of these names
  pivot_longer(cols=Males:Females, names_to="Sex", values_to="Count") 

ggplot(data=countDataLong, aes(x=Species, y=Count, fill=Sex)) + geom_bar(stat="identity", position="dodge") + scale_fill_manual(values=c("darkslategrey", "midnightblue")) #dodge plots bars next to each other 

##############################################################################################

###Control Structure is the structure of code. Specifying the arguments and within the argument specifying the code, etc.

## if else statements

 # if (condition) {expression(s)}
# if (condition){expression 2} else {expression 2} #this says "if condition if met, do this, if not, do this)

###connecting multiple if else statements

# if (condition 1) {expression 1} else
# if (condition 2) {expression 2} else {expression 3}
### if any final unspecified else, it captures the rest of unspecified conditions
### else must appear on the same line as the expression

### we use if else for single values

z <-signif(runif(1), digits=2) #give me one uniform number rounded to the 2nd significant number
#z >0.5 #gives you T or F

###use {} or not
if (z>0.8) {cat(z, "is a large number", "\n")} else
  if (z<0.2) {cat(z, "is a small number", "\n")} else
  {cat(z, "is a number of typical size", "\n")
  cat("z^2=", z^2,"\n")} 

#if z>0.8 give us the value and spit back a line break. if z<0.2, print  "is a small number" and a line break, if not put that it's a typical size and line break. then, give me z^2, print, then line break.

##### Ifelse to fill vectors

##ifelse(condition, yes, no)

##Suppose we have an insect population where females lay 10.2 eggs, follows Poisson distribution (type of stats distribution--discrete probability showing likely number of times an event will occur). There is a 35% chance of parasitism where no eggs are laid. Let's make a distribution for 1000 individuals.

tester <- runif(1000) #give me 1000 random numbers
eggs <- ifelse(tester>0.35, rpois(n=1000,lambda = 10.2), 0) 

#if its >0.35  then give me a 1000 random numbers, if not then give me 0


#### vector of p-values from a simulation. we want to create a vector to highlight the significant ones for plotting

pVals <- runif(1000)
z <- ifelse(pVals <= 0.025, "lowerTail", "nonSig") 

z[pVals >= 0.975] <- "upperTail"   #if it's over 0.975, give it an upperTail
table(z)

#### for loops is a workhorse function for doing repetitive tasks. it's slow with certain operations

## for(variable in a sequence){#starts the for loop
#body of the for loop
#end of for loop
}

#var is a counter variable that holds the current value of the loop (usually i, j, k)
# sequence is an integer vector that defines the starting and end points of the loop


for(i in 1:5){
  cat("stuck in a loop", i, "\n")  #i is counter variable, 1:5 is 5x. it has to be a sequence
cat(3+2, "\n")
cat(3+i, "\n")} #3 + whatever number in the sequence
 
print(i) #will print the last number in the loop

###use a counter variable that maps to the position of each element
my_dogs <- c("chow", "nikita", "malamute", "husky", "samoyed")

for(i in 1:length(my_dogs)){
  cat("i=", i, "my_dogs[i]=", my_dogs[i], "\n")
}

##can use double for loops

m <- matrix(round(runif(20), digits=2), nrow=5) 

for (i in 1:nrow(m)){
  m[i,] <- m[i,] + i #go the first row, add 1 to everything. go to the second row, add 2 to everything, go to the 3rd row, etc
}
#loop over columns. use J for cols
m <- matrix(round(runif(20), digits=2), nrow=5)
for(j in 1:ncol(m)){
  m[,j] <- m[,j] + j
}


##loop over rows and cols

m <- matrix(round(runif(20), digits=2), nrow=5)
for (i in 1:nrow(m)){
  for (j in 1:ncol(m)){
    m[i, j] <- m[i, j] + i +j
    }
}
print(m)





