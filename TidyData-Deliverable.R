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


Batisdat_tidy$dur <- as.numeric(format(as.POSIXct(Batisdat_tidy$dur, format="%Y-%m-%d %H:%M:%S"), "%S"))

Batisdat_t_pivot <- Batisdat_tidy %>%
  select("succ", "dur_seconds", "sex") %>%
 # mutate(succ = as.factor(succ)) %>%
 # group_by("sex") %>%
  pivot_longer(cols = c("succ", "dur_seconds"), 
               names_to = "Variable", values_to = "Values") %>%
  ggplot() +
  geom_boxplot(aes(x = "Variable", y = "Values")) +
  #geom_boxplot(aes(x = "succ", y = "dur_seconds")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(vars(sex, Variable), scales = "free")

#Log Transformation

Batisdat_t_pivot <- Batisdat_tidy %>%
  select(succ, dur_seconds, sex) %>%
  pivot_longer(cols = c(succ, dur_seconds), 
               names_to = "Variable", values_to = "Values") %>%
  ggplot() +
  geom_boxplot(aes(x = Variable, y = log(Values + 1))) +  # Adding 1 to handle zeros
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(~sex + Variable, scales = "free")

#Plotted as Scatter Plot

Batisdat_t_pivot <- Batisdat_tidy %>%
  select(succ, dur_seconds, sex) %>%
  pivot_longer(cols = c(succ, dur_seconds), 
               names_to = "Variable", values_to = "Values") %>%
  ggplot() +
  geom_point(aes(x = log(Values + 1), y = sex, color = Variable)) +  # Scatter plot
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

Batisdat_t_pivot

#Removing pivot so that I can see if it looks good as a succ/durr_seconds

Batisdat_t_pivot <- Batisdat_tidy %>%
  select(succ, dur_seconds, sex) %>%
  ggplot(aes(x = dur_seconds, y = succ)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(~sex, scales = "free")


Batisdat_t_pivot

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
