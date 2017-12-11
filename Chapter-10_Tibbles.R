library(tidyverse)
as_tibble(iris)

tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y
)

tb <- tibble(
  `:)` = "smile", 
  ` ` = "space", 
  `2000` = "number"
)
tb

tribble(
  ~x, ~y, ~z, 
  #--/--/----
  "a", 2, 3.6, 
  "b", 1, 8.5
)

tibble(
  a = lubridate::now() + runif(1e3) * 86400, 
  b = lubridate::today() + runif(1e3) * 30, 
  c = 1:1e3, 
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

nycflights13::flights %>%
  print(n = 10, width = Inf)

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
df$x
df[["x"]]
df[[1]]
df %>% .$x
df %>% .[["x"]]

class(as.data.frame(tb))

######################## 10.5 Exercises ####

"1. "
class(mtcars)

"2. "
df <- data.frame(abc = 1, xyz = "a")
df$x 
df[,"xyz"]
df[,c("abc", "xyz")]

tbl <- as_tibble(df)
tbl$x 
tbl[, "xyz"]
tbl[,c("abc", "xyz")]

"3. Cannot use $ sign. It will look for a column name."

"4. "
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying[["1"]]
annoying$`1`

ggplot(annoying, aes(x = `1`, y=`2`)) + 
  geom_point()

annoying[["3"]] <- annoying$`2` / annoying$`1`
annoying <- rename(annoying, one = `1`, two = `2`, three = `3`)
glimpse(annoying)
########################################################################