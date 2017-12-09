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

ggplot(data = diamonds, mapping = aes(x = price )) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

ggplot(diamonds) + 
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

################### 7.5.1.1 Exercises ######3####
 "1. "
nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot() +
  geom_boxplot(mapping = aes(y = sched_dep_time, x = cancelled))

"3. "
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()

"4. "
library("lvplot")
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_lv()

"5. "
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_violin() +
  coord_flip()
"6. "
library("ggbeeswarm")
ggplot(data = mpg) +
  geom_quasirandom(mapping = aes(x = reorder(class, hwy, FUN = median),
                                 y = hwy))
ggplot(data = mpg) +
  geom_quasirandom(mapping = aes(x = reorder(class, hwy, FUN = median),
                                 y = hwy),
                   method = "tukey")
#############################################

ggplot(data = diamonds) + 
  geom_count(mapping = aes(x = cut, y = color))

diamonds %>%
  count(color, cut)

diamonds %>%
  count(color, cut) %>%
  ggplot(mapping = aes(x = color, y = cut)) + 
  geom_tile(mapping = aes(fill = n))

############ 7.5.2.1 Exercises ##############

"1. "
diamonds %>%
  count(color, cut) %>%
  group_by(color) %>%
  mutate(prop = n/ sum(n)) %>%
  ggplot(mapping = aes(x = color, y = cut)) + 
  geom_tile(mapping = aes(fill = prop))  
  
"2. "
flights %>%
  group_by(month, dest) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = factor(month), y = dest, fill = dep_delay)) + 
  geom_tile() + 
  labs(x = "Month", y = "Destination", fill = "Departure Delay")
"3. It's usually better to use the categorical variable with a larger number of categories or the longer labels on the y axis. If at all possible, labels should be horizontal because that is easier to read."
################################################

ggplot(data = diamonds) + 
  geom_point(mapping = aes(x=carat, y=price))

ggplot(data = diamonds) + 
  geom_point(mapping = aes(x=carat, y=price), alpha = 1/100)

ggplot(data = smaller) + 
  geom_bin2d(mapping = aes(x = carat, y = price))

library(hexbin)
ggplot(data=smaller) + 
  geom_hex(mapping = aes(x = carat, y = price))

ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))

#################7.5.3.1 Exercises #########
"1."
ggplot(data = diamonds, 
       mapping = aes(x = price,
                     colour = cut_width(carat, 0.3))) +
  geom_freqpoly()

"2. "
ggplot(diamonds, aes(x = cut_number(price, 10), y = carat)) +
  geom_boxplot() +
  coord_flip() +
  xlab("Price")

ggplot(diamonds, aes(x = cut_width(price, 2000, boundary = 0), y = carat)) +
  geom_boxplot(varwidth = TRUE) +
  coord_flip() +
  xlab("Price")

"4."
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_hex() +
  facet_wrap(~ cut, ncol = 1)

ggplot(diamonds, aes(x = cut_number(carat, 5), y = price, color = cut)) +
  geom_boxplot()

ggplot(diamonds, aes(color = cut_number(carat, 5), y = price, x = cut)) +
  geom_boxplot()
#############################################

ggplot(data = faithful) + 
  geom_point(mapping = aes(x = eruptions, y = waiting))

library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>%
  add_residuals(mod) %>%
  mutate(resid = exp(resid))

ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))

ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))

ggplot(faithful, aes(eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()
