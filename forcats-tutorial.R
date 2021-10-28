## ----setup, include=FALSE------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE)


## ---- fig.align='center', echo=F, out.width = "90%"----------------------------------------------
knitr::include_graphics("pics/factors.png")


## ---- message=F----------------------------------------------------------------------------------
library(forcats)
library(dplyr)
library(ggplot2)


## ------------------------------------------------------------------------------------------------
data <- gss_cat


## ------------------------------------------------------------------------------------------------
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
# First, we create a new dataframe that includes the average ages.
partyid_age_average <- data %>%
  group_by(partyid) %>%
  summarize(
    age = mean(age, na.rm = TRUE)
  )

# Then we use the fct_reorder() function in the y-axis description of the plot aesthetics 
# to have the party identification with the highest average age 
# on top and the lowest on the bottom.
ggplot(partyid_age_average, aes(age, fct_reorder(partyid, age))) + 
  geom_point() + 
  enhance_theme



## ------------------------------------------------------------------------------------------------
# Again, we create a dataframe first that shows the average hours spent watching TV per 
# reported income group.
rincome_tv_average <- data %>%
  group_by(rincome) %>%
  summarize(
    tvhours = mean(tvhours, na.rm = TRUE)
  )

# We then use fct_relevel() in the y-axis description of the plot aesthetics to pull
# "Not applicable" to the bottom.
ggplot(rincome_tv_average, aes(tvhours, fct_relevel(rincome, "Not applicable"))) + 
  geom_point() + 
  enhance_theme



## ------------------------------------------------------------------------------------------------
# We create a new dataframe, where we aggregate the smaller religions together into
# an "Other" level using fct_lump(), keeping the 3 largest religions.
# Then we use fct_infreq() to sort the data in increasing order of the frequencies,
# and fct_rev() to make the largest level appear on the right in the plot and the 
# lowest on the left.
religion_count <- data %>%
  mutate(relig = fct_lump(relig, n = 3) %>% 
           fct_infreq() %>% 
           fct_rev())

# Then we simply plot the bar chart with the religion factor on the x-axis.
ggplot(religion_count, aes(relig)) + 
  geom_bar() +
  enhance_theme



## ------------------------------------------------------------------------------------------------
# We use fct_recode() to change the names of multiple levels into a new name, which 
# in this case is the same name, i.e. the same new "Other" level that the four
# levels get aggregated into.
rincome_recoded <- data %>%
  mutate(rincome = fct_recode(rincome,
                              "Other" = "No answer",
                              "Other" = "Don't know",
                              "Other" = "Refused",
                              "Other" = "Not applicable"
                              )) 

# Now we simply have to plot the bar chart of our new dataframe with the 
# reported income on the x-axis.
ggplot(rincome_recoded, aes(rincome)) + 
  geom_bar() + 
  enhance_theme



## ------------------------------------------------------------------------------------------------
# fct_collapse() is useful when aggregating a lot of levels together into a couple of new levels.
rincome_recoded_2 <- rincome_recoded %>%
  mutate(rincome = 
           fct_collapse(rincome,
              "low" = c("Lt $1000", "$1000 to 2999", "$3000 to 3999", "$4000 to 4999", 
                           "$5000 to 5999", "$6000 to 6999", "$7000 to 7999", "$8000 to 9999"),
              "medium" = c("$10000 - 14999", "$15000 - 19999"),
              "high" = c("$20000 - 24999", "$25000 or more")))

# It would be necessary to include information about what low, medium and high 
# stand for exactly- but this is the content of other sessions :)

# Simply plot the bar chart with the new dataframe and the reported income on the x-axis.
ggplot(rincome_recoded_2, aes(rincome)) + 
  geom_bar() + 
  enhance_theme


