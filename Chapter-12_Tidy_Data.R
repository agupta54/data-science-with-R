library(tidyverse)

table1
table2
table3
table4a
table4b

table1 %>%
  mutate(rate = cases / population * 10000)
table1 %>%
  count(year, wt = cases)

library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group=country), colour = "grey50") + 
  geom_point(aes(colour = country))
