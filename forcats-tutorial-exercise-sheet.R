## ----setup, include=FALSE------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE)


## ---- fig.align='center', echo=F, out.width = "90%"----------------------------------------------
knitr::include_graphics("pics/factors.png")


## ---- message=F----------------------------------------------------------------------------------
# Step 1: Load the packages `forcats`, `dplyr` and `ggplot2`.
library(forcats)
library(dplyr)
library(ggplot2)


## ------------------------------------------------------------------------------------------------
# Step 2: Load the GSS data into a variable.
data <- gss_cat


## ------------------------------------------------------------------------------------------------
# Step 3: Inspect the data.
data


## ------------------------------------------------------------------------------------------------

data %>% count(rincome)



## ------------------------------------------------------------------------------------------------
# This code just makes all the following graphs nicer to look at.
enhance_theme <- theme_minimal() + 
  theme(panel.grid.major.x = element_blank() , 
        panel.grid.major.y = element_line( size=.1, color="black" ))

ggplot(data, aes(rincome)) +
  geom_bar() + 
  enhance_theme
  


## ------------------------------------------------------------------------------------------------
## EXERCISES

# Task 1
# Investigate the average age across the party identifications and plot 
# the result in a graph. Reorder the levels so that the overall trend becomes easily visible.





## ------------------------------------------------------------------------------------------------
# Task 2
# Investigate the average number of hours spent watching TV per day 
# across the reported income groups and plot the result in a graph. 
# Pull the "Not applicable" level to the front. 





## ------------------------------------------------------------------------------------------------
# Task 3
# Provide a bar chart showing the three largest levels of the `relig` factor in 
# increasing order. Aggregate the other religions into an "Other" level.





## ------------------------------------------------------------------------------------------------
# Task 4
# Group these four levels ("No answer", "Don't know", "Refused", "Not applicable") 
# into one "Other" level and provide a new plot for the distribution of reported incomes.

# (Note that you should generally be careful with recoding various levels into one. 
# Is giving "No answer" as answer really to be treated equal to "Don't know"? 
# I don't know- we are doing it for practice reasons here, but in real-world data science, 
# they are probably not the same thing.)






## ------------------------------------------------------------------------------------------------
# Task 5
# Create a bar chart showing three larger reported income brackets than provided 
# in the data, plus the "Other" factor.






