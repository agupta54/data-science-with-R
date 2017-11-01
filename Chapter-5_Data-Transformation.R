library(nycflights13)
library(tidyverse)
?flights
filter(flights, month==1, day==1)
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month ==12, day ==25))
sqrt(2)^2 == 2
near(sqrt(2)^2,2)
filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11,12))
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)
x <- NA
is.na(x)
df <- tibble(x = c(1,NA,3))
filter(df,x > 1)
filter(df, is.na(x) | x > 1)

####################5.2.4 Exercises 
"1."
filter(flights, arr_delay >= 120)
filter(flights, dest == 'IAH' | dest == 'HOU')
filter(flights, carrier == 'UA' | carrier == 'AA' | carrier == 'DL')
filter(flights, month == 7 | month == 8 | month == 9)
