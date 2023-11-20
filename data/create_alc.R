# Jaakko Kähärä, 20.11.2023, Assignment 3
# Data wrangling files downloaded from http://www.archive.ics.uci.edu/dataset/320/student+performance

# access the dplyr package
library(dplyr)

# read the math class questionnaire data into memory
math <- read.table("data/student-mat.csv", sep = ";" , header = TRUE)

# read the Portuguese class questionnaire data into memory
por <- read.table("data/student-por.csv", sep = ";", header = TRUE)

# columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the join_cols identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    # if the first column vector is not numeric
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# There are 35 columns 370 students are left in the joined data
dim(alc) 

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use,  fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the new combined data
glimpse((alc))

# Save analysis data set to "data" folder
library(readr)
setwd("data") # change working directory
write_csv(alc, "alc_use.csv") # save modified data to csv file

setwd("..")
