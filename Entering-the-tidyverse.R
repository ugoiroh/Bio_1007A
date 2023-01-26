#### Entering the tidyverse
#### 23 Jan 2023
### UUI

## The tidyverse is a collection of packages that include how a code is structured, grammar, and data structures. It is designed to be intuitive and quicker.

## Operators are signals that tells R to perform different operations. Usually go btwn variables or functions. 
    ## Arithmetic operators: + - * / ^ 
    ## Assignment operator: <-
    ## Logical operators: ! & |(this is the 'or' operator) > < >= <=
    ## Miscellaneous operators: %>% (forward pipe operator), %in%

## You only need to install packages once. 
library(tidyverse) #use library function to load in packages. We can also look at the packages panel 

# dplyr: newer packages that names the functions for what you actually want to do. It is fast and dyplr manages large datasets fast. 

# The core verbs
   #filter()
   #arrange()
   #select()
   #group_by() and summarize()
   #mutate() -> creates new dataframe

## Built-in data set
data(starwars)
class(starwars)

#Tibble is a dataframe that minimizes headaches by keeping great aspects of data frame and leaves out the annoying parts; e.g. it can change the input type.

glimpse(starwars) #use this to clean up data.

## NAs
anyNA(starwars) #tells us "T" or "F" if there are NA. you can also use is.na or complete.cases

starwarsClean <- starwars[complete.cases(starwars[,1:10]),] #comma at the end = give us back all the cols
glimpse(starwarsClean)
is.na(starwarsClean[,1:10]) #give me all the rows, but give me the first ten indices in the cols

filter() #use to subset by rows
filter(starwarsClean, gender=="masculine"&height<180)
filter(starwarsClean, gender=="masculine",height<180, height>100) #multiple conditions for the same variable
filter(starwarsClean, gender=="masculine"|height<180) # | <- or

## %in% #similar to matching operator but you can compare vectors of different lengths

# Sequence of letters
  # a<- LETTERS[1:10]
  length(a) #gives us length of vector
  
  b <- LETTERS[4:10]
  length(b)
  
# The output of %in% depends on first vector
  
a %in% b #checks within a and sees if it is in b. "IS FIRST VECTOR IN THE SECOND?"

eyes <- filter(starwars, eye_color %in%c("blue", "brown")) 

                       # or you can do 

eyes2 <- filter(starwars, eye_color=="blue"|eye_color=="brown")

View(eyes) & View(eyes2) # lets you view table 


## Arrange() arranges variables by what you specify. lets you see ROWS
    arrange(starwarsClean, by=height)
    arrange(starwarsClean, by=desc(height)) # you can also use helper function for descending order
    
    arrange(starwarsClean, height, by=desc(mass)) # the second variable used to break tie if both heights are the same.
    
    sw <- arrange(starwars, by=height)
    tail(sw) #missing values are at the end of the index


## Select() chooses variables and COLS by their names. Subsets by cols
    
select(starwarsClean, 1:10) #give me first 10 cols
select(starwarsClean, name:species) #use names of cols to only select what we want
select(starwarsClean, -(films:starships))
starwarsClean[,1:11]

## Rearrange function
select(starwarsClean, name, gender, species, everything()) #everything with open brackets will take other cols and put them at the end. It is a type of HELPER function.

## Contains() helper function
select(starwarsClean, contains("color")) 
# other helper functions such as ends_with(), starts_with(), num_range()
# select() is super versatile bc it can also rename cols
  select(starwarsClean, haircolor=hair_color) #returns only renamed column
#rename function
  rename(starwarsClean, haircolor=hair_color) # return WHOLE data set with renamed column

## Mutate() creates new variables using functions of existing variables. It add the new variables to the data frame without deleting the old variables.
   (mutate(starwarsClean, ratio=height/mass)) #we want height:mass ratio. 
   view(starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2)) #conversion
   starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything())
   transmute(starwarsClean, mass_lbs=mass*2.2) #we only want a new dataframe with updated variable. only returns mutated col
   transmute(starwarsClean, mass, mass_lbs=mass*2.2, height) #transmutate add new variables and deletes the old ones

   # use .before or .after function to put something after or before another thing
   
## Group_by() and summarize() is easiest to use them together
   summarize(starwarsClean, meanHeight=mean(height)) #gives us mean height of all the characters in one dataframe. Also throws NA if it is in dataframe; use na.rm=T to remove.
   summarize(starwarsClean, meanHeight=mean(height), TotalNumber=n()) #average height for dataset and total numbers=everything after 

# Use group_by() for maximum usefulness
   starwarsGenders <- group_by(starwars, gender)
   summarize(starwarsGenders, meanHeight=mean(height, na.rm=T), TotalNumber=n()) #gives us table of these variables
   
##Piping %>% pipes the function from one function to another. Used to emphasize a sequence of actions. Uses output of one function as input of the next function.Helpful if you need to manipulate more than one object at a time or if you have meaningful intermediate (btwn 2 important variables) data
   #formatting: always have space between %>% followed by a new line. Start with variable you wann conduct code on
   
starwarsClean %>% 
  group_by(gender) %>%
  summarize(meanHeight=mean(height, na.rm=T),TotalNumber=n())

## Case_when() is used for multiple if or ifelse statements 
   starwarsClean %>%
     mutate(sp=case_when(species=="Human"~"Human", T~"Non-Human")) #if species is Human, put it in new col in human, if not, put it in non-Human col. Puts Human if T in sp col, put Non-Human if false
   
   
### Publishing quality graphs requires a package called ggplot 
library(ggplot2)
library(ggthemes)  
library(patchwork)

### Template for ggplot code:
# ggplot(data=add data here, mapping=aes(x=xVariable, y=yVariable)) + GEOM function
#  then print()
   
## Let's load in another built-in data set as an example:
d <- mpg
str(mpg)

library(dplyr)   #first have to load dyplyr
glimpse(d) #use glimpse to clean data

## qplot: quick plotting, not for publications though
qplot(x=d$hwy)

qplot(x=d$hwy, fill=I("darkblue"), color=I("black")) #use this to fill in and outline colors for graphs. Remember to put 'I' in front of what color you want.

####Making Scatterplot
qplot(x=d$displ, y=d$hwy, geom=c("smooth", "point")) 

####Making Linear model
qplot(x=d$displ, y=d$hwy, geom=c("smooth", "point"), method=lm) 
   
####Making Boxplots   
qplot(x=d$fl, y=d$cty, geom="boxplot", fill=I("forestgreen"))  
  
####Making Bar plots
qplot(x=d$fl, geom="bar", fill=I("forestgreen"))

####Making data with specific counts

x_trt <- c("Control", "Low", "High")
y_resp <- c(12, 2.5, 22.9)  
qplot(x=x_trt, y=y_resp, geom="col",fill=I(c("darkblue","slategray", "goldenrod")))
  
###Using ggplot to make dataframes

p1 <-ggplot(data=d, mapping=aes(x=displ, y=cty, color=cyl)) + 
  geom_point()
 print(p1)
 
   #adding plot arguments
 
p1 + theme_base() #changes background
p1 + theme_bw()  #adds gridelines
p1 + theme_classic() #changes margins
p1 + theme_linedraw() #changes margins
p1 + theme_dark() #dark background
p1 + theme_light()

# Change specifications of graph: font size, font type, etc

p1 + theme_bw(base_size=20, base_family="serif")

p2 <- ggplot(data=d, aes(x=fl, fill=fl)) +
  geom_bar()
p2 + coord_flip() + theme_classic(base_size=15, base_family="sans")
                                   
##Theme modifications

p3 <- ggplot(data=d, aes(x=displ, y=cty)) + geom_point(size=7, shape=25, color="magenta", fill="black") + 
  xlab("Count") + ylab("Fuel") + labs(title="My Title", subtitle="my subtitle") 
print(p3)

p3 + xlim(1,10) +ylim(0,35)

#Another example
library(viridis)
cols <- viridis(7, option="plasma") #the number of groups has to match the number you put in the parenthesis. 
ggplot(data=d, aes(x=class, y=hwy, fill=class)) +
  geom_boxplot() +
  scale_fill_manual(values=cols)
  

###Multipanel layout
library(patchwork)
p1 + p2+ p3

p1/p2/p3

(p1+p2) / p3




