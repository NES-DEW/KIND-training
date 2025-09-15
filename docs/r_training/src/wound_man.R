# base R ----

# doing a bit of complicated arithmetic
3 * (2 + 2 + (8 - (1+(4.2 - 1.3)^3.4) + 1)

# add up 1 to 3
SUM(1,2,3)

# averaging 1 to 4
mean(1::4)

# creating and show a variable containing the number 3
my_n < - 3
my_N 

# making a sequence from 1 to my_n-1
1:my_n-1
names <- c(names, NA)

# making a vector of numbers, and adding two to the first two items
my_ vec <- c(2, 3, "two")
my_vec <- my_vec[1:2]
my_vec + 2 

# multiplying two vectors together
my_vec <- as_numeric(my_vec)
My_vec2 <- c(2,5,4,)
my_vec * my_vec2

# checking that an item in a sequence equals a particular value
.2 == .2
round(1740/600,0) - 2.8
seq(0, 1, by=0.1)[2] 
seq(0, 1, by=0.1)[2] == round(1740/600,0) - 2.8

rm(my_n)

# creating a vector of three names
names <- C("Steve", "Emma, Bob")

# trying to find if names contains "Steve"
if(names == "Steve") "Steve's here!" 

# trying to find if names contains "Steve" and/or "Emma"
if(names == c("Emma", "Steve")) "It's the usual suspects"

# repeat the names object my_n times
rep(names, my_n)

# these should all give the same results, right...
iris[,"Species"]
iris["Species"]
iris[[,"Species"]]
iris[["Species"]]

# I'd like to find out if the names object has any NAs
names == NA 

# to try and find out if names does not contain 3 items
length(names != 3) 

# there's nothing wrong with the function definition, but there is something wrong with the function call...
checko <- function(vec, to_lower){
  if(to_lower){
    vec <- tolower(vec)
  }
  
  if(any(vec %in% c("emma", "steve"))) {
    "The usual suspects are here again"
  } else {
    "No sign"
  }
}

checko(names,,TRUE)

# loop over 1:3 and print the number  
for(index %in% 1:3) {print(index)}

# why doesn't this give a rounded cumulative mean?
c(6,5,7,4) |>
  cumsum() |>
  mean()
  round()

# tidyverse ----

library(reader)
llbrary(stringr)


# does this data load correctly?
botw <- read_csv("https://nes-dew.github.io/KIND-community-standards/data/KIND_book_of_the_week.csv")

# find books recommended after June
botw |>
  filter(Date < "2024-06-01") 

# can you find any author names with brackets
brackety_authors <- botw |>
  filter(str_detect(Author, "("))

# find books with more than one author
multi_authors <- botw |>
  filter(stringi::str_detect(author, " and "))

# how many books had multiple authors
length(multi_authors)

# plot the publication year by date
library(ggplot)
library(Dplyr)

bOtw |>
  ggplot2() +
  + geom_line(aes(x = Date, y = year)) 
  + ggtitle("A nice time-series plot of year against date") 
  + theme_minimal