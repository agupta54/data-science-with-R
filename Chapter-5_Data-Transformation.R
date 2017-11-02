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
##########################################

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
rename(flights, tail_num = tailnum)
select(flights, time_hour, air_time, everything())

############################ 5.4.1 Exercises
"1." 
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with("dep_"), starts_with("arr_"))
"2. It detects and still selects just one time."
"3. one_of() selects the elements of the vector in the dataframe. It is useful since 
we can pass a vector and no need to pass names again and again."
"4. To incluse case sensitivity we need to add ignore.case = FALSE"
select(flights, contains("TIME", ignore.case = FALSE))
#############################################

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance, 
                      air_time
                      )
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60 
       )

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

####################### 5.5.2 Exercises
"1. "
mutate(flights,
       dep_time_mins = dep_time %% 100 * 60 + dep_time %% 100,
       sched_dep_time_mins = sched_dep_time %% 100 * 60 + sched_dep_time %% 100) %>%
select(dep_time, dep_time_mins, sched_dep_time, sched_dep_time_mins)

time2mins <- function(x) {
  x %% 100 * 60 + x %% 100
} 
mutate(flights,
       dep_time_mins = time2mins(dep_time),
       sched_dep_time_mins = time2mins(sched_dep_time)) %>%
  select(dep_time, dep_time_mins, sched_dep_time, sched_dep_time_mins)
"2. "
mutate(flights,
       air_time2 = arr_time - dep_time, 
       air_time_diff = air_time2 - air_time) %>%
filter(air_time_diff != 0) %>%
select(air_time, air_time2, dep_time, arr_time, dest)
"3. dep_time - sched_dep_time = dep_delay"
mutate(flights,
       dep_delay2 = time2mins(dep_time) - time2mins(sched_dep_time)) %>%
  filter(dep_delay2 != dep_delay) %>%
  select(dep_time, sched_dep_time, dep_delay, dep_delay2)
"4. "
mutate(flights,
       dep_delay_rank = min_rank(-dep_delay)) %>%
  arrange(dep_delay_rank) %>% 
  filter(dep_delay_rank <= 10)
"5. Error since the length of the longer vector is not a multiple of the length of the shorter vector."
"6. sin(), cos() etc. "
##############################################

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest, 
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
                   )
delay <- filter(delay, count > 20, dest != "HNL")
ggplot(data = delay, mapping = aes(x = dist, y = delay)) + 
  geom_point(aes(size = count), alpha = 1/3) + 
  geom_smooth(se = FALSE)
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
delays <- not_cancelled %>% 
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay)
  )
ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n())
ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)
delays %>%
  filter(n > 25) %>%
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)
batting <- as_tibble(Lahman::Batting)
batters <- batting %>%
  group_by(playerID) %>%
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )
batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() + 
  geom_smooth(se = FALSE)
