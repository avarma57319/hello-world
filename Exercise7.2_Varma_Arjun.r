---
title: "Exercise7.2"
author: "Arjun Varma"
date: "10/10/2021"
output: pdf_document
---
setwd("C:/Users/arjun/Documents/DSC520/DATA")
getwd()

read.csv("C:/Users/arjun/Documents/DSC520/DATA/student-survey.csv")
str(df)

library(readr)
library(ggplot2)
library(corpcor)
library(ggpubr)
library(MASS)
library(ppcor)

View(df)


# Use R to calculate the covariance of the Survey variables and provide an 
#explanation of why you would use this calculation and what the results indicate.
cov(df)
cov(df$TimeReading,df$TimeTV)
cov(df$TimeReading,df$Gender)
cov(df$TimeReading,df$Happiness)
cov(df$TimeTV,df$Gender)
cov(df$TimeTV,df$Happiness)

#Examine the Survey data variables. What measurement is being used for the variables? 
#Explain what effect changing the measurement being used for the variables 
#would have on the covariance calculation. 
#Would this be a problem? Explain and provide a better alternative if needed.

head(df)


#Choose the type of correlation test to perform, explain why you 
#chose this test, and make a prediction if the test yields a positive or negative correlation?
cor(df)
cor(df$TimeReading,df$TimeTV)
cor(df$TimeReading,df$Gender)
cor(df$TimeReading,df$Happiness)
cor(df$TimeTV,df$Gender)
cor(df$TimeTV,df$Happiness)

#A single correlation between two of the variables
#Happiness vs. reading 
#Happiness vs. tv 

cor(df$TimeReading,df$Happiness, method=c("spearman"))
cor(df$TimeReading,df$Happiness, method=c("kendall"))
cor(df$TimeReading,df$Happiness, method=c("pearson"))


cor(df$TimeTV,df$Happiness, method=c("kendall"))
cor(df$TimeTV,df$Happiness, method=c("spearman"))
cor(df$TimeTV,df$Happiness, method=c("pearson"))


#Repeat your correlation test in step 2 but set the confidence interval at 99%
cor.test(df$TimeReading,df$Happiness, conf.level = 0.99)
cor.test(df$TimeTV,df$Happiness, conf.level = 0.99)

#Calculate the correlation coefficient and the coefficient of determination

cor.test(df$TimeReading,df$Happiness)
readcor <- cor(df$TimeReading,df$Happiness)
readcor
readcor2 <- readcor ^ 2
readcor2

cor.test(df$TimeTV,df$Happiness)
tvcor <- cor(df$TimeTV,df$Happiness)
tvcor
tvcor2 <- tvcor ^ 2
tvcor2


cor.test(df$TimeReading,df$TimeTV)
readtvcor <- cor(df$TimeReading,df$TimeTV)
readtvcor
readtvcor2 <- readtvcor ^ 2
readtvcor2

#Pick three variables and perform a partial correlation, documenting which variable you are “controlling”. Explain how this changes your interpretation and explanation of the results.
library(ggm)
survey1 <- df[, c("TimeReading", "TimeTV", "Happiness")]
pc <- pcor(c("TimeReading", "TimeTV", "Happiness"), var(survey1))
pc^2
