# base R ----

# doing a bit of complicated arithmetic
3 * (2 + 2 + (8 - (1+(4.2 - 1.3)^3.4) + 1)) # f1 add a closing bracket
     
# add up 1 to 3
sum(1,2,3) # f2 fix the function name - R is case sensitive

# averaging 1 to 4
mean(1:4) # f3 double : = namespacing. Range operator is :

# creating a variable containing the number 3
my_n <- 3 # f4 spaces break assignment operators
my_n # f5 make sure about variable names and cases

# making a sequence from 1 to my_n-1
1:(my_n-1) # f6 add brackets to control order of operations

# making a vector of numbers, and adding two to the first two items
my_vec <- c(2, 3, "two") # f7 check names
my_vec <- as.numeric(my_vec[1:2]) # f8 make sure that you're supplying what you think you're supplying
my_vec + 2 

# multiplying two vectors together
# my_vec <- as_numeric(my_vec) # f9 now not needed, and f10 wrong function name
my_vec2 <- c(2,5,4) # f11 extra empty item removed and f12 names again
my_vec * my_vec2 # f13 a potentially complex fix. Easiest to not try and multiply incommensurable vector lengths together. Could do something like expand.grid(my_vec, my_vec2) and then multiply if you did need to catch all the combinations

# checking that an item in a sequence equals a particular value
.2 == .2
seq(0, 1, by=0.1)[2] 
seq(0, 1, by=0.1)[2] = 0.2 # f14 == to check for equality. But f15, the inequality here is expected behaviour owing to floating point errors. There are lots of ways of representing decimal numbers in use in R, but they all give subtly different results. These differences usually don't matter to us, but they do make the exacting == fall over. equal(0.2, 0.2) is less exacting

# creating a vector of three names
names <- C("Steve", "Emma", "Bob") # f16 now makes three names, rather than two odd ones
names <- c(names, NA) # f17 - this was miles away above. Moved to more sensible location

# trying to find if names contains "Steve"
if(any(names == "Steve")) "Steve's here!" #f18 if isn't vectorised

# trying to find if names contains "Steve" and/or "Emma"
if(any(names %in% c("Emma", "Steve"))) "It's the usual suspects" # f19 the %in% operator is the right way to do this 

# repeat the names object my_n times
# rm(my_n) # f 20 moved to more sensible location and commented out. Beware odd lines out of sequence!
rep(names, my_n)

# these should all give the same results, right...
iris[,"Species"] # f21 - gives the species column as a vector (exactly like iris$Species)
iris["Species"] # f22 gives the species column as a column
# iris[[,"Species"]] # f23 - meaningless
iris[["Species"]] # f24 - species column as vector again

# I'd like to find out if the names object has any NAs

is.na(names)# f25 NA is an unthing. You can't test the properties of non-things with ==.

# to try and find out if names does not contain 3 items
length(names) != 3 # f26 bracket positions again

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

checko(names,TRUE) # f27 missing argument removed

# loop over 1:3 and print the number  
for(index in 1:3) {print(index)} # f28 just to confuse the earlier advice about %in%, you'd still need in when you're writing a loop

# why doesn't this give a rounded cumulative mean?
c(6,5,7,4) |>
 cumsum() |>
 mean() |> #f29 - we're missing a pipe
round()

# tidyverse ----
library(readr) # f30 package name
library(stringr) # f31 function name
library(dplyr) # f32 moved and f33 package case
library(ggplot2) # f34 moved and f35 title tweaked

# does this data load correctly?
botw <- read_csv("https://nes-dew.github.io/KIND-community-standards/data/KIND_book_of_the_week.csv", col_types = list(col_character())) |>
  mutate(Date = lubridate::dmy(Date))# f36 ISBNs and dates don't parse correctly. You could specify everything if you can remember all the read_csv cols fiddle, or (easier) keep everything as char and then parse the dates separately

# find books recommended after June
botw |>
 filter(Date < "2024-06-01") # f37 a famous annoyance that dplyr::filter gets masked by stats. Sort the package loading (or namespace) and that gets fixed for you

# can you find any author names with brackets
brackety_authors <- botw |>
 dfilter(str_detect(Author, "\\(")) # f38 brackets are great at tripping R up. Remember to escape them with \\

# find books with more than one author
multi_authors <- botw |>
 filter(stringr::str_detect(Author, " and ")) # f39 column names are case-sensitive, and f40 some very close package names to watch out for

# how many books had multiple authors
nrow(multi_authors) # f41 my least-favourite false friend. A tibble's length() is its width...

# plot the publication year by date

botw |> #f42 variable names, always variable names
  mutate(Year = as.numeric(substr(Year, 1, 4))) |> # our years are coming out as chars because of the brackets
  ggplot() + # f44 ggplot is the function, ggplot2 the package
  geom_line(aes(x = Date, y = Year)) +  # f44 beware the number of + signs and f45 col names again
  ggtitle("A nice time-series plot of year against date") +
  theme_minimal() # f46 it's a function, rather than an object
