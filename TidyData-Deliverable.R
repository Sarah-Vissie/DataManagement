library(tidyverse)

Batisdat <- read_xlsx("Raw Data Unedited.xlsx", sheet = "Sheet2")

install.packages("readxl")
library(readxl)
Batisdat <- read_xlsx("Raw Data Unedited.xlsx", sheet = "Sheet2")

#Renaming Coloumn names:

Batisdat_tidy <- Batisdat %>% 
  rename(
    subcat = `Subcategory:`,
    succ = `Success:`,
    dur = `Duration :`,
    sex = `Male/Female:`)

#Reformatting dur into seconds; removing the date that was bought over from excel

class(Batisdat_tidy$dur)

#The Data type of dur is POSIXct and POSIXt



Batisdat_tidy_dur <- as.difftime(Batisdat_tidy$dur, units = "secs")

#Pivoting data into wide format

Batisdat_pivot <- Batisdat_tidy %>%
  select("succ", "dur", "sex") %>%
  pivot_longer(cols = c("succ", "dur", "sex"),
               names_to = "Variable", values_to = "Values")


Batisdat_pivot <- Batisdat %>%
  select("Duration :", "Success:", "Male/Female:") %>%
  pivot_longer(cols = c("Duration :", "Success:", "Male/Female:"), 
               names_to = "Variable", values_to = "Values") %>%




  
  
#Practicing with data. Decided to leave it so I could come back to it.
  
#splitting my data into sex groups
#Take Note: When a common name as symbols like (/:) place it in single reverse colon (``)

library(dplyr)

male <- filter(Batisdat, `Male/Female:` == "M")

female <- filter(Batisdat, `Male/Female:` == "F")


sum_male_succ <- sum(male$`Success:`)

View(sum_male_succ)
