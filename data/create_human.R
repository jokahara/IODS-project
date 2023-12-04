# Jaakko Kähärä, 4.12.2023, Assignment 4 and 5

library(dplyr)
library(readr)
# download “Human development” and “Gender inequality” data sets
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Dimensions 
dim(hd) # 195 x 8
dim(gii) # 195 x 10
# Summaries
summary(hd)
summary(gii)

# rename column names to shorter ones
colnames(hd) <- c("HDI.Rank", "Country", "HDI", 'Life.Exp', 'Edu.Exp', 'Edu.Mean', 'GNI', 'GNI.Rank')
colnames(gii) <- c("GII.Rank", "Country", "GII", 'Mat.Mor', 'Ado.Birth', 'Parli.F', 'Edu2.F', 'Edu2.M', 'Labo.F', 'Labo.M')

# add ratios of between female and male populations
gii <- mutate(gii, "Edu2.FM" = Edu2.F / Edu2.M)
gii <- mutate(gii, "Labo.FM" = Labo.F / Labo.M)

# join datasets
human = inner_join(hd, gii)
dim(human) # 195 x 19

# variables to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- human[keep]

# remove rows with missing values
human <- filter(human, complete.cases(human))

# remove regional observations (last 7 rows)
last <- nrow(human) - 7
human <- human[1:last, ]

dim(human) # 155 x 9

# save to data/human.csv
setwd('data')
write_csv(human, 'human.csv')
setwd('..')