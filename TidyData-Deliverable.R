library(tidyverse)

install.packages("readxl")
library(readxl)
Batisdat <- read_xlsx("Raw Data Unedited.xlsx", sheet = "Sheet2")

#Renaming Column names:

Batisdat_tidy <- Batisdat %>% 
  rename(
    subcat = `Subcategory:`,
    succ = `Success:`,
    dur = `Duration :`,
    sex = `Male/Female:`)

#Reformatting "dur" into seconds; removing the date that was bought over from excel

Batisdat_tidy$dur <- as.numeric(format(as.POSIXct(Batisdat_tidy$dur, format="%Y-%m-%d %H:%M:%S"), "%S"))

#Pivoting "succ", "dur_seconds" and "sex" longer

Batisdat_t_pivot <- Batisdat_tidy %>%
  select("succ", "dur_seconds", "sex") %>%

  pivot_longer(cols = c(succ, dur_seconds), 
               names_to = "Variable", values_to = "Values") %>%
  ggplot() +
  geom_boxplot(aes(x = Variable, y = log(Values + 1))) + #Using log(+1) to handle all the zeros

  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(vars(Variable, sex), scales = "free")

#Print plot

Batisdat_t_pivot

