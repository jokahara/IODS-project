# Jaakko Kähärä, 13.11.2023, Assignment 2

# Access the dplyr library
library(dplyr)

# read learning2014 data table
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = T)

# print dimensions of the table
dim(learning2014) # 183 x 60
# print first few rows
head(learning2014)

# questions related to deep, surface and strategic learning
col_names = colnames(learning2014)
deep_questions <- col_names[grepl("D[0-9]", col_names)]
surface_questions <- col_names[grepl("SU[0-9]", col_names)]
strategic_questions <- col_names[grepl("ST[0-9]", col_names)]

# select columns for analysis 
analysis = select(learning2014, c("gender", "Age", "Attitude", "Points"))
# set the column names to lowercase
colnames(analysis) <-  c("gender", "age", "attitude", "points")

# select the different learning columns and add averages to analysis
analysis$deep <- rowMeans(select(learning2014, one_of(deep_questions)))
analysis$surf <- rowMeans(select(learning2014, one_of(surface_questions)))
analysis$stra <- rowMeans(select(learning2014, one_of(strategic_questions)))

# filter out results where points is zero
analysis <-filter(analysis, points > 0)

dim(analysis) # 166 x 7
head(analysis)

# Save analysis data set to "data" folder
library(readr)
setwd("data") # change working directory
write_csv(analysis, "learning2014.csv") # save data to learning2014.csv file

# Reread the data set
d <- read_csv("learning2014.csv")
head(d)

setwd("..")

