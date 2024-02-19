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
class("succ")
class("sex")


#The Data type of dur is POSIXct and POSIXt

Batisdat_tidy$dur_seconds <- second(Batisdat_tidy$dur)

Batisdat_t_pivot <- Batisdat_tidy %>%
  select("succ", "dur_seconds", "sex") %>%
  group_by("sex") %>%
  pivot_longer(cols = c("succ", "dur_seconds"), 
               names_to = "Variable", values_to = "Values") %>%

  ggplot() +
  geom_boxplot(aes(y = "succ", x = "dur_seconds")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(vars("sex"), scales = "free")

#Pivoting data into wide format


Batisdat_pivot <- Batisdat_tidy %>%
  select("succ", "dur_seconds", "sex") %>%
  pivot_longer(cols = c("succ", "dur_seconds", "sex"), 
               names_to = "Variable", values_to = "Values") %>%
  
  
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
