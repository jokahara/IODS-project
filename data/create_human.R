# Jaakko Kähärä, 27.11.2023, Assignment 4

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
colnames(gii) <- c("GII.Rank", "Country", "GII", 'Mat.Mor', 'Ado.Birth', 'Rep.Par', 'Edu2.F', 'Edu2.M', 'Labo.F', 'Labo.M')

# add ratios of between female and male populations
gii <- mutate(gii, "Edu2.FM" = Edu2.F / Edu2.M)
gii <- mutate(gii, "Labo.FM" = Labo.F / Labo.M)

# join datasets
human = inner_join(hd, gii)
dim(human) # 195 x 19

# save to human.csv
write_csv(human, 'human.csv')
