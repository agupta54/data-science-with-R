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
filter(flights, arr_delay > 120 & dep_delay <= 0)
filter(flights, dep_delay >= 60 & dep_delay - arr_delay > 30)
filter(flights, dep_time <= 600| dep_time == 2400)
"2. ?between "
"3. " 
sum(is.na(flights$dep_time))
"4. One TRUE in an OR condition is enough for it to be true. NA does not matter in this case."
##########################

arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))
# missing values are always sorted in the end. 
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

######################## 5.3.1 Exercises 
"1. "
arrange(flights, desc(is.na(dep_time)), dep_time)
"2. "
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)
"3. "
arrange(flights, air_time)
"4. "
arrange(flights, desc(distance))
