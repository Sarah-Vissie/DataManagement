library(pacman)

Batisdat <- read_xlsx("Raw Data Unedited.xlsx", sheet = "Sheet2")

install.packages("readxl")
library(readxl)
Batisdat <- read_xlsx("Raw Data Unedited.xlsx", sheet = "Sheet2")

class(Batisdat$`Success:`)

#Pivoting data into wide format
Batisdat %>%
  select("Duration :","Success:","Male/Female:")
  pivot_longer(cols = c(Duration :, Success:, Male/Female:), 
               names_to = "Variable", values_to = "Values")
?pivot_longer


#splitting my data into sex groups
#Take Note: When a common name as symbols like (/:) place it in single reverse colon (``)

library(dplyr)

male <- filter(Batisdat, `Male/Female:` == "M")

female <- filter(Batisdat, `Male/Female:` == "F")


sum_male_succ <- sum(male$`Success:`)

View(sum_male_succ)
