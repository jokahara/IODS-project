# Jaakko Kähärä, 11.12.2023, Assignment 6

library(dplyr)
library(tidyr)
library(readr)

# download the BPRS and RATS datasets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep ="\t", header = T)

# 1. Glimpse at the data
glimpse(BPRS) # 40 rows, 11 columns
glimpse(RATS) # 16 rows, 13 columns

# 2. Convert the categorical variables of both data sets to factors. 
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3. Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.
BPRS <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% 
         arrange(weeks) %>% 
         mutate(week = as.integer(substr(weeks,5,5)))

RATS <- pivot_longer(RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight") %>%  
        mutate(Time = as.integer(substr(WD,3,4))) %>% 
        arrange(Time)

glimpse(BPRS) # 360 rows, 5 colums
glimpse(RATS) # 176 rows, 5 colums

# Summaries
summary(BPRS)
summary(RATS)

setwd('data')
# saving data
write.csv(BPRS, 'BPRS.csv')
write.csv(RATS, 'RATS.csv')
setwd('..')
