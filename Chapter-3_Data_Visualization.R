# install tidyverse if not installed already
library(tidyverse)
# to learn more about data 
?mpg
ggplot(data=mpg)+
  geom_point(mapping = aes(x = displ, y=hwy))

######################### 3.2.4 Exercises 
"1. ggplot(data=mpg) creates an empty plot."
"2. Number of rows and columns in mpg can be seen by
just typing mpg in the console"
"3. drv tells if a car has front wheel, rear wheel or four wheel drive"
"4."
ggplot(data=mpg)+
  geom_point(mapping = aes(x= cyl, y=hwy))
"5."
ggplot(data=mpg)+
  geom_point(mapping = aes(x=drv, y=class))
"Both are categorical variables. Does not reveal a lot of information."
##########################

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y=hwy, color = class))
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y=hwy, size = class))
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y=hwy, alpha = class))
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y=hwy, shape = class))
"Mappings in the aesthetics can be scaled with colour, shape, size, and transparency"
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

##################### 3.3.1 Exercises 
"1. The parenthesis are incorrectly closed."
"2. ?mpg to see details of variables."
"3. Continuous variables cannot be mapped to shape but R handles color and size."
"4. R tries to incorporate both types of mappings."
"5. stroke makes an outline around the shape."
"6. If color is mapped inside the aes the colour is mapped as a boolean TRUE and FALSE depending on the condition"
#####################

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~class, nrow = 2)
"Variable that is passed in facet_wrap() should be discrete."
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

################### 3.5.1 Exercises 
"1. R produces a plot but it diffcult to gain reasonable insights from this type of wrapping."
"2. Empty plot means no data for that situation. For example there us no car with 5 cylinders and 4 wheel drive in the data.
    The given command generates a plot which shows the relation between cyl and drv and we can see where we can expect to find no data."
"3. The following command facets the data according to the variable specified. The first command does it rwo wise while the second command does it 
    column wise."
"4. For a larger dataset it might be a good idea to use colour aesthetic. Facet wrap will give a clearer picture if the number of categorical variables are less."
"5. ?facet_grid() has all the information needed."
"6. More unique values correspond to more categorical variables which imples for plots to display."
#####################

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

############3.6.1 Exercises 
"1. geom_line(), geom_boxplot(), geom_histogram(), geom_area() respectively"
"2. Smoothing lines around drive types"
"3. Setting this option as FALSE removes the legend. Removing this shows it."
"4. se sets the confidence interval arounf the smoothing line."
"5. Both commands produce the same plots. Global and local mappings."
"6. "
ggplot(data=mpg,mapping = aes(x=displ,y=hwy))+geom_point()+geom_smooth(se = FALSE)
ggplot(data=mpg,mapping = aes(x=displ,y=hwy))+geom_point()+geom_smooth(mapping = aes(x=displ,y=hwy,group=drv),se = FALSE)
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy,color=drv))+geom_smooth(mapping = aes(x=displ,y=hwy,group=drv,color=drv),se = FALSE)
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy,color=drv))+geom_smooth(mapping = aes(x=displ,y=hwy),se = FALSE)
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy,color=drv))+geom_smooth(mapping = aes(x=displ,y=hwy,group=drv,linetype=drv),se = FALSE)
###########################

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

################ 3.7.1 Exercises 
"1. geom_histogram(), geom_freqpoly()."
"2. geom_bar() uses the height of the bar proportional to the number of cases while grom_col() uses the value of the data instead."
#################################

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
