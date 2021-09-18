install.packages("pastecs")
library(ggplot2)
library(pastecs)
theme_set(theme_minimal())

df <- read.csv("C:/Users/arjun/Documents/DSC520/DATA/acs-14-1yr-s0201.csv")

# What are the elements in your data (including the categories and data types)?
# Please provide the output from the following functions: str(); nrow(); ncol()

str(df)
nrow(df)
ncol(df)

# Create a Histogram of the HSDegree variable using the ggplot2 package.
# Set a bin size for the Histogram.
# Include a Title and appropriate X/Y axis labels on your Histogram Plot.


pl <-df$HSDegree
hist(pl, breaks = 20, xlab = "HS Degree Holders", ylab = "Frequency", main
= "HS Degree Holders-Frequency Distribution")



# Include a normal curve to the Histogram that you plotted.

hist(x, breaks = 20, xlab = "HS Degree Holders", ylab = "Frequency", main
= "HS Degree Holders-Frequency Distribution", freq = FALSE)
mean1 <- mean(x)
std1 <- sd(x)
curve(dnorm(x, mean = mean1, sd = std1), add = TRUE, col = "red")






# Create a Probability Plot of the HSDegree variable.

ggplot( data = df, aes(sample = HSDegree)) + 
stat_qq(col = "blue") + stat_qq_line() + 
ggtitle("Probability plot")




# Now that you have looked at this data visually for normality, you will 
#now quantify normality with numbers using the stat.desc() function. 
#Include a screen capture of the results produced.
stat.desc(df$HSDegree, basic = FALSE, norm = TRUE)




