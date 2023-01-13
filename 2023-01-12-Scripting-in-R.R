### Programming in R
### 12 January 2023
### UI

# Advantages 
## interactive use
## used for graphics, stats
## lots of help online
## works on multiple platforms (rstudio, etc)

# Disadvantages
## lazy evaluation
## some packages are poorly documented
## some functions are hard to learn --steep learning curve
## some are unreliable packages 
## problems with big data (multiple GBs)

# Basics

## Assignment operator: used to assign a new value to a variable

x <- 5

# the little arrow is the assignment arrow. Press command-return to enter script.

print(x)

y = 4 #this format is legal but not used in function arguments 

print(y)  

y <- y + 1.1

print(z)

z <- 5

y = 4
y = y + 1.1
y <- y + 1.1
print(y)

x <- 3
print(x)
x = x - 1
x <- x - 1
print(x)

## Variables: they are used to hold information and data

z <- 3 #single letter variables may be good to have if they're not important
plantHeight <- 10 #camel case format 
plant_height <- 3.3 #snake case format #a preferred method 
plant.height <- 4.2 #lowkey avoid this one, some packages in R use periods 
. <- 5.5 #reserve periods for temporary variable, acts as placeholder

## Functions: pieces of code that perform a task; you can use a short command instead of writing block of code various times

# I can create my own function! let's say we wanna square any variable...

square <- function(x = null){
  x <- x^2
  print(x)
}
x <- 5
square(x)

z <- 103
square(z) 

#anything before equal sign is an argument. Here, the argument name is 3. 

### there are also built-in functions 
sum(109, 3, 20)

# ?sum to look at package or go to help panel

## Atomic Vectors 
# one dimensional (a single row)
# one of the most fundamental data structures in R 

### Different Types 
# character strings (usually within quotes)
# integers (whole numbers)
# double (real numbers, decimal)
# numeric (integers and doubles) 
# logical (TRUE or FALSE)
# factor (categorizes, groups variables)

# c function (combines diff elements and puts into one vector)

z <- c(3.2, 5, 5, 6)
print(z)

class(z) # this function lets you know what class of variable it is
typeof(z) # returns what type of variable
is.numeric(z) # returns T/F

## c() always "flattens" to a vector. it is useful for creating vectors

z <- c(c(3,4), c(5,6))

c(3,4, "dog", TRUE, 4.5)

# character vectors
z <- c("perch", "bass", "trout")
print(z)

z <- c("This is only 'one' character string", "a second", 'a third')
print(z)

print(z)
typeof(z)
is.logical(z) #is. functions tests whether it is a certain data type

##Logical (Boolean), no quotes, all caps: True and/or False

z <- c (T, F, T, F) #as. functions coerces data type
is.logical(z)
z <- as.character(z)
is.character(z)

# Type
#is.numeric / as.character
# typeof()

# Length shows how many items or strings
length(z)
# dim(z) shows how many dimensions. NULL is 1.

#Names
z <- runif(5) 
# runif just comes up with different numbers
names(z)

# add names
names(z) <- c("chow", "pugg", "beagle","greyhound", "akita")
print(z)

# reset names
names(z) <- NULL
names(z)

### NA (stands for missing data)
z <- c(3.2, 3.5, NA)
typeof(z)
mean(z)
sum(z)


# how to check data of NA
anyNA(z)
is.na(z)
which(is.na(z)) #this one is super helpful to know exactly where the NA is. 

## Subsetting vectors 
# vectors are indexed 
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z[4] #doing square brackets helps you find specific index in plots
z[c(4, 2, 5)] #use c for specifc multiple indices in plots
z[-c(1,2,3)] #use - in front of c to say "give me everything but these indices"

z [z==7.5] #use double equal sign to say "subset this specific number". 
z [z < 7.5] #use logical statements within square brackets to subset specific conditions

z[which(z < 7.5)] #which only outputs indices. use [] to subset values

# Creating a logical vector 
## to create TRUE's or False's, such as z < 7.5 


## subsetting chracters (named elements)
names(z) <- c("a", "b", "c", "d", "e")
z
z[c("a", "d")]

# subset
subset(x=z, subset = z>1.5)

# randomly sample
# sample function
story_vec <- c("A", "Frog", "Jumped", "Here")

sample(story_vec)

# randomly select 3 elements from vector
sample(story_vec, size=3)

story_vec <- c(story_vec[1], "Blue", story_vec[2:4])
story_vec

story_vec[2]<-"Green"
story_vec

# vector function
vec <- vector(mode="numeric", length=5)

## rep and seq functions
# used for making patterns of values
z <- rep(x=0, times = 100)
z <- rep (x=1:4, each=3)

z <- seq(from = 2, to =4)
z <- seq(from = 1, to =4, by=1)
z

