# Figure out a way to iterate a function for adding manager names over Dates
library(tidyverse)
library(lubridate)
library(randomNames)

# Dates that need a name
dates <- tibble(
  Date = sample(seq.Date(ymd(20001001), ymd(20170101), by = "day"), 
                nrow(mngrs) * 2, 
                replace = T), 
  Mngr = ""
) %>% 
  arrange(Date)

# Dates with names 
return_mngr <- function(Date) {
  # Dates and names
  mngrs <- tibble(
    From = seq.Date(ymd(20001001), ymd(20170101), by = "year"), 
    To = From + 364, 
    Name = randomNames(length(From), which.names = "last")
  ) 
  
  check_date <- function(Date, From, To) {
    if(between(Date, From, To)) {
      mngrs$Name 
    }
  }
  
  map2_chr(mngrs$From, mngrs$To, check_date)
}