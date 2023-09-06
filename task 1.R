#Explorative data analysis

#installing necessary packages for analysis
install.packages("ggplot2")
library(ggplot2)
install.packages("tidyverse")
library(tidyverse)
install.packages("dplyr")
library(dplyr)
-------------------------------------------
#loading the data 
#loaded the data using import option in R
data<-Sales_January_2019
------------------------------------------
#explore the data
View(data)
head(data)
str(data)
dim(data) #the dim function informs there are 9723 observations and 6 variables
colnames(data) #used to know the column names/variables in data.
summary(data) #the summary function is used to get descriptive statistic analysis of 
#all variables in data(i.e mean, median, Q1, Q3, Max and Min values)
------------------------------------------------------------------------------------------------
#Data cleaning- handling missing values by replacing with mean 
# Calculate the mean of the numeric_column
mean_value1 <- mean(data$`Order ID`, na.rm = TRUE)
mean_value2<-mean(data$`Quantity Ordered`, na.rm=TRUE)
mean_value3<-mean(data$`Price Each`,na.rm=TRUE)

# Replacing NA values with the mean
data$`Order ID`[is.na(data$`Order ID`)] <- mean_value1
data$`Quantity Ordered`[is.na(data$`Quantity Ordered`)]<-mean_value2
data$`Price Each`[is.na(data$`Price Each`)]<-mean_value3
----------------------------------------------------------------------------------
#Handling Outliers
#boxplot
ggplot(data = data, aes(x = data$`Quantity Ordered`, y = "")) +
  geom_boxplot()+
  labs(x = "Quantity ordered", y = "") +
  ggtitle("Boxplot of Quantities oredered in Jan 2019")

ggplot(data = data, aes(x = data$`Price Each`, y = "")) +
  geom_boxplot()+
  labs(x = "Price of goods", y = "") +
  ggtitle("Boxplot of Prices of Goods Ordered in Jan 2019")

#In both boxplots obtained the presence of bold dots outside whiskers, proofs the existence of outliers

#scatterplot
ggplot(data = data, aes(x = `Quantity Ordered`, y =`Price Each`)) +
  geom_point(color = "blue", size = 3) +
  labs(x = "Quantity ordered", y = "Prices of each quantity ordered") +
  ggtitle("Scatterplot of Quantity ordered vs Prices") +
  theme_minimal() +
  scale_x_continuous(limits = c(0, 7), breaks = seq(0, 7, by = 0.5)) +
  scale_y_continuous(limits = c(0, 1700), breaks = seq(0, 1700, by = 100))
#The obtained scatterplot identifies the presence of many outliers in the dataset.It implies data has extreme values

#z scores
zscore1<-scale(data$`Quantity Ordered`) #scale function is used to obtain z scores.
View(zscore1) 
#counting number of extreme values in Quantity ordered column
zscore1 %>%
  sum(zscore1 >= 3 | zscore1 <= -3) %>%
  print()
#216 -there are total 216 outliers whose z scores are greater than 3 and less than in -3
zscore2<-scale(data$`Price Each`)
View(zscore2)
#Counting umber of extreme values in Price each column
zscore2 %>%
  sum(zscore2 >= 3 | zscore2 <= -3) %>%
  print()
#235 - total number of outliers whose z scores are greater than 3 and less than in -3 are present

  