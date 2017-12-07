library(tidyverse)

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
diamonds %>% count(cut)

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
diamonds %>% count(cut_width(carat, 0.5))

smaller <- diamonds %>%
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) + 
  geom_histogram(binwidth = 0.1)
  
ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) + 
  geom_freqpoly(binwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat)) + 
  geom_histogram(binwidth = 0.01)

ggplot(data=faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.25)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x=y), binwidth = 0.5)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x=y), binwidth = 0.5) + 
  coord_cartesian(ylim = c(0, 50))

unusual <- diamonds %>% 
  filter(y < 3| y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)
unusual

#########7.3.4 Exercises ####################

"1."
diamonds %>%
  mutate(id = row_number()) %>%
  select(x, y, z, id) %>%
  gather(variable, value, -id) %>%
  ggplot(aes(x = value)) + 
  geom_density() + 
  geom_rug() + 
  facet_grid(variable ~ .)
"2."
ggplot(filter(diamonds, price < 2500), aes(x = price)) +
  geom_histogram(binwidth = 10, center = 0)

ggplot(filter(diamonds), aes(x = price)) +
  geom_histogram(binwidth = 100, center = 0)
"3. "
diamonds %>%
  filter(carat >= 0.99, carat <= 1) %>%
  count(carat)
"4. "
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = price)) + 
  coord_cartesian(xlim = c(100,5000), ylim =c(0, 3000) )
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x=price)) + 
  xlim(100, 5000) + 
  ylim(0, 3000)
"coord_cartesian just zooms the plot within the given limits 
while xlim and ylim first reomve the values outside the limits and 
then calculate the histogram."

##############################################

diamonds2 <- diamonds %>%
  filter(between(y, 3, 20))

diamonds2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
ggplot(data = diamonds2, mapping = aes(x=x, y=y)) + 
  geom_point()

nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time), 
    sched_hour = sched_dep_time %/% 100, 
    sched_min = sched_dep_time %% 100, 
    sched_dep_time = sched_hour + sched_min / 60
  ) %>%
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(colour = cancelled), binwidth = 1/4)

ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

ggplot(diamonds) + 
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

ggplot(data = diamonds, mapping = aes(x=cut, y=price)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()
