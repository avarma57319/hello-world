setwd("C:/Users/arjun/Documents/DSC520/DATA")
getwd()
library(ggplot2)
theme_set(theme_minimal())
heights_df <- read.csv("C:/Users/arjun/Documents/DSC520/DATA/heights.csv")
str(heights_df)
# https://ggplot2.tidyverse.org/reference/geom_point.html
## Using `geom_point()` create three scatterplots for
## `height` vs. `earn`
ggplot(heights_df, aes(x=height, y=ï..earn)) + geom_point()
## `age` vs. `earn`
ggplot(heights_df, aes(x=age, y=ï..earn)) + geom_point()
## `ed` vs. `earn`
ggplot(heights_df, aes(x=ed, y=ï..earn)) + geom_point()
## Re-create the three scatterplots and add a regression trend line using
## the `geom_smooth()` function
ggplot(heights_df, aes(x=height, y=ï..earn)) + geom_point() + geom_smooth()
ggplot(heights_df, aes(x=age, y=ï..earn)) + geom_point() + geom_smooth()
ggplot(heights_df, aes(x=ed, y=ï..earn)) + geom_point() + geom_smooth()
## Create a scatterplot of `height`` vs. `earn`. Use `sex` as the `col` (color) attribute
ggplot(heights_df, aes(x=height, y=ï..earn, colour = "red")) + geom_point()
## Using `ggtitle()`, `xlab()`, and `ylab()` to add a title, x label, and y label to the previous plot
## Title: Height vs. Earnings
## X label: Height (Inches)
## Y Label: Earnings (Dollars)
ggplot(heights_df, aes(x=height, y=ï..earn, colour = "red")) + geom_point() + ggtitle("Height vs. Earnings") +
  xlab("Height (Inches)") + ylab("Earnings (Dollars)")
# https://ggplot2.tidyverse.org/reference/geom_histogram.html
## Create a histogram of the `earn` variable using `geom_histogram()`
ggplot(heights_df, aes(ï..earn)) + geom_histogram()
# https://ggplot2.tidyverse.org/reference/geom_density.html
## Create a kernel density plot of `earn` using `geom_density()`
ggplot(heights_df, aes(ï..earn)) + geom_density()
