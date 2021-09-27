dx=read.csv("C:/Users/arjun/Documents/DSC520/DATA/week-6-housing.csv")
library(dplyr) 

#Applying FILTER to dataframe columns
select(dx, Sale Date,Sale_Price,sale_reason,sale_instrument,sale_warning,sitetype,	
addr_full,zip5,ctyname,postalctyn,lon,lat,building_grade,square_feet_total_living,bedrooms,bath_full_count,
bath_half_count,bath_3qtr_count,year_built,year_renovated,current_zoning,sq_ft_lot,	prop_type,present_use)

filter(dx, zip5 == "98052")


#Arranging data
arrange(dx, Sale_Price, ctyname, desc(square_feet_total_living))


# Selecting data
select(dx, Sale_Date, sq_ft_lot, Sale_Price)


# Mutate Data
mutate(dx, Total_SqFt = square_feet_total_living + sq_ft_lot)


# Group By
summarise_at(group_by(dx,zip5),vars(square_feet_total_living),funs(mean(.,na.rm=TRUE)))



# Summarize Data
summarize(dx, Arg_Sale_Prc = mean(Sale_Price, na.rm = T))

# Using the purrr package - perform 2 functions on your dataset.  
#You could use zip_n, keep, discard, compact, etc.

install.packages("tidyverse")
install.packages("purrr")
install.packages("assertthat")

library(purrr)
library(tidyverse)

# example - declaring vector with sample values
vector <- c(1.0212, 2.483, 3.189, 4.5938)

# displaying vector information
vector

# KEEP - selecting data with values less than 3
keep(vector, ~ .x < 3)


# DISCARD - selecting data with values less than 3
discard(vector, ~ .x < 3)


# c)	Use the cbind and rbind function on your dataset

#creating a data frame

dm<-data.frame(Column_1=c(1,2,3,4,5), Column_2=c(6,7,8,9,10), Column_3=c(11,12,13,14,15))
dm

#creating second data frame

dm_1<-data.frame(New_column_1=c(2,4,6,8,10))
dm_1

#binding 2 data frames
#Cbind
cbind(dm,dm_1)

#Rbind
# create new data frames with same number of columns with  as the first data frame

library(plyr) 



x1 <- c(7, 4, 4, 9)                  # Column 1 of data frame
x2 <- c(5, 2, 8, 9)                  # Column 2 of data frame
x3 <- c(1, 2, 3, 4)                  # Column 3 of data frame
df_m <- data.frame(x1, x2, x3)


x1 <- c(7, 1)                        # Column 1 of data frame 2
x2 <- c(4, 1)                        # Column 2 of data frame 2
x3 <- c(4, 3)                        # Column 3 of data frame 2
df_z <- data.frame(x1, x2, x3)

rbind(df_m, df_z)  


# Split a string, then concatenate the results back together

exmp_string <- "This is a test to show how strings are split"
exmp_string

strsplit(exmp_string, " ")


#Concatenate strings together
paste("Hello", "world", sep=" ")

