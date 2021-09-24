
# Exercise 4.2
# 1. TEST SCORES
#setwd("C:/Users/arjun/Documents/DSC520/DATA")
#getwd()
df <- read.csv("C:/Users/arjun/Documents/DSC520/DATA/scores.csv")

reg_section = subset(df, Section=='Regular')
print(reg_section)

sports_section = subset(df, Section=='Sports')
print(sports_section)

library(ggplot2)
theme_set(theme_minimal())





df=read.csv("C:/Users/arjun/Documents/DSC520/DATA/scores.csv")
reg_section=subset(student_df1,Section=="Regular")
sports_section=subset(student_df1,Section=="Sports")
plot(regular$Score, regular$Count, pch=20,
     main= "Sports vs Regular ",xlab= "Score",ylab="Number of students",
     xlim= c(180,420) , ylim= c(8,40), col.main = "blue", col.lab="blue", col = "green")
points(sports$Score, sports$Count, pch = 20)
mtext(paste(" Black - Sports \nRed - Regular"), side= 3, line =-2, adj=1)



# 2. HOUSING DATASET

#a)
dx=read.csv("C:/Users/arjun/Documents/DSC520/DATA/week-6-housing.csv")

X <- matrix(rnorm(30), nrow=12865, ncol=24)

#SUMMING VALUES OF COLUMN 2 -- SALE PRICE
apply(X, 2, sum)


#b)
#aggregate function
agg = aggregate(dx,by = list(dx$zip5),
FUN = mean)


agg


#c)
#plyr function

library("readxl")
  
dx=read.csv("C:/Users/arjun/Documents/DSC520/DATA/week-6-housing.csv")



library(plyr)

# splitting data frame by Zip code
# Tried multiple times, does not work
#ddply(dx, "zip5", function(x) {
  #mean.count <- mean(x$count)
  #sd.count <- sd(x$count)
 # cv <- sd.count/mean.count
  #data.frame(cv.count = cv)
#})
#ddply(dx, "zip5", summarise, mean.count = mean(count))

# Transforming zip into total counts
#ddply(dx, "Sale_price", transform, total.count = sum(count))




# Data transformation example; new column created: mean.sq_ft_lot
mod_1<-ddply(dx,.(sq_ft_lot), transform,
                 mean.sq_ft_lot=mean(year_built))

head(mod_1)



# Check distributions of the data
# Histogram

library(ggplot2)
x <-dx$square_feet_total_living
t <-dx$square_feet_total_living
hist(x, breaks = 20, xlab = "Living Area Sq Ft", ylab = "Frequency", main
     = "House sales by Sq Ft")
# max spread is between 1500 to 3000sq ft



# scatter plot
ggplot(dx, aes(x=square_feet_total_living, y=Sale_Price, colour = "red")) + geom_point() + 
  ggtitle("SQ FT Vs. SALE PRICE") + 
  xlab("Sq Ft") + ylab("Sale Price")


# Create 2 new variables
#Created new column/variable: tot_residence_area which is a sum of lot size and living area
dx$tot_residence_area <- dx$square_feet_total_living + dx$sq_ft_lot

dx

#Created new column/variable: tot_rooms which is a sum of 
#bedrooms,	bath_full_count,	bath_half_count,	bath_3qtr_count

dx$tot_rooms <- dx$bedrooms + dx$bath_full_count + dx$bath_half_count + dx$bath_3qtr_count
dx
