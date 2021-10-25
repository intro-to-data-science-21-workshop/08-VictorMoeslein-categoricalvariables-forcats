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

ggplot(data, aes(rincome)) +
  geom_bar() 



## ------------------------------------------------------------------------------------------------

partyid_age_average <- data %>%
  group_by(partyid) %>%
  summarize(
    age = mean(age, na.rm = TRUE)
  )

ggplot(partyid_age_average, aes(age, fct_reorder(partyid, age))) + geom_point()



## ------------------------------------------------------------------------------------------------

rincome_age_average <- data %>%
  group_by(rincome) %>%
  summarize(
    tvhours = mean(tvhours, na.rm = TRUE)
  )

ggplot(rincome_age_average, aes(tvhours, fct_relevel(rincome, "Not applicable"))) + geom_point()



## ------------------------------------------------------------------------------------------------

religion_count <- data %>%
  mutate(relig = fct_lump(relig, n = 3) %>% 
           fct_infreq() %>% 
           fct_rev())

ggplot(religion_count, aes(relig)) + geom_bar() 



## ------------------------------------------------------------------------------------------------

rincome_recoded <- data %>%
  mutate(rincome = fct_recode(rincome,
                              "Other" = "No answer",
                              "Other" = "Don't know",
                              "Other" = "Refused",
                              "Other" = "Not applicable"
                              )) 

ggplot(rincome_recoded, aes(rincome)) + geom_bar()



## ------------------------------------------------------------------------------------------------

rincome_recoded_2 <- rincome_recoded %>%
  mutate(rincome = 
           fct_collapse(rincome,
              "<10000" = c("Lt $1000", "$1000 to 2999", "$3000 to 3999", "$4000 to 4999", "$5000 to 5999", "$6000 to 6999", "$7000 to 7999", "$8000 to 9999"),
              ">=10000_&_<20000" = c("$10000 - 14999", "$15000 - 19999"),
              ">=20000" = c("$20000 - 24999", "$25000 or more")))

ggplot(rincome_recoded_2, aes(rincome)) + geom_bar()



