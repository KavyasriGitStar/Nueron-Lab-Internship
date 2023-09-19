#Data visualisation 
#importing data
library(readxl)
data1<-Weather_data
View(data1)
colnames(data1)
dim(data1)

#installing packages for visualisation
install.packages("ggplot2")
library(ggplot2)

#bar graph 
#bar graph of Mininimum temperature over years from 1940-1946
ggplot(data = data1, aes(x = Date)) +
  geom_bar(aes(y = MinTemp), stat = "identity", fill = "blue", alpha = 0.7) +
  labs(
    title = "Bargraph of Min Temperatures Over Time",
    x = "Date",
    y = "Temperature (°C)"
  )+
  theme_minimal()

#bar graph of Maximum temperature over years from 1940-1946
ggplot(data = data1, aes(x = Date)) +
  geom_bar(aes(y = MaxTemp), stat = "identity", fill = "red", alpha = 0.7) +
    labs(
    title = " Bargraph of Max Temperatures Over Time",
    x = "Date",
    y = "Temperature (°C)"
  )

#Grouped bargraph shows both min and max temperatures of various contries in year 1940-1946
ggplot(data = data1, aes(x = Date)) +
  geom_bar(aes(y = MinTemp), stat = "identity", fill = "blue", alpha = 0.7) +
  geom_bar(aes(y = MaxTemp), stat = "identity", fill = "red", alpha = 0.7) +
  labs(
    title = " Grouped bar graph of Min and Max Temperatures Over Years",
    x = "Date",
    y = "Temperature (°C)"
  ) +
  scale_fill_manual(values = c("blue", "red"), name = "Temperature") +
  theme_minimal()

# the area chart
  ggplot(data = data1, aes(x = Date, y = MeanTemp)) +
  geom_area(fill = "skyblue") +
  labs(
    title = "Mean Temperature Over Years",
    x = "Date",
    y = "Mean Temperature (°C)"
  ) +
  theme_minimal()
#here we have used area chart instead of Line chart because,Area graphs are preferred 
#over line charts when we want to capture the changes over time for more than 1 group 

# Create the column histogram
#We use geom_histogram() to create the column histogram. 
#The fill aesthetic specifies the fill color of the bars, and bins controls the number of bins or columns in the histogram.
  ggplot(data = data1, aes(x = MeanTemp)) +
  geom_histogram(fill = "red", bins = 20) +
    labs(
      title = "Histogram of Mean Temperature in 1940-1960",
      x = "Mean Temperature (°C)",
      y = "Frequency"
    ) +
    theme_minimal()
  
#the line histogram
#use geom_density() to create the smoothed line histogram (density curve).
  ggplot(data = data1, aes(x = MeanTemp)) +
    geom_density(fill = "pink") +   
    labs(
      title = "Line Histogram of Mean Temperature",
      x = "Mean Temperature (°C)",
      y = "Density"
    ) +
    theme_minimal()


#bubble plot  
# Sample data (replace this with your actual data)
  data <- data.frame(
    Year = data1$Date,
    MTemperature = data1$MeanTemp,
    Weather = data1$PoorWeather  # Assuming 'Weather' represents some measure of poor weather
  )
  
  # Create a bubble plot
  ggplot(data, aes(x = Year, y = MTemperature, size = Weather )) +
    geom_point(aes(color = Year), alpha = 0.7) +
    scale_size_continuous(range = c(3, 15)) +
    labs(
      title = "Bubble Plot of Yearly Mean Temperatures vs. Poor Weather",
      x = "Year",
      y = "Mean Temperature (°C)",
      size = " Poor Weather",
      color = "Year"
    )
  
  
#boxplot
boxplot(data1$MaxTemp, data1$MinTemp, data1$MeanTemp, 
        xlab=" Temperatures (MAX, MIN, MEAN)",
        ylab="Value of Temperature",
        main="Boxplot of Temperature")



# Create two scatter plots
# Install and load ggplot2 and gridExtra packages
# install.packages("ggplot2")
# install.packages("gridExtra")
library(ggplot2)
library(gridExtra)

plot1 <- ggplot(data = data1, aes(x = MaxTemp, )) +
  geom_bar() +
  labs(title = "Bar Graph of Max Temp ")

plot2 <- ggplot(data = data1, aes(x = MinTemp, )) +
  geom_bar() +
  labs(title = "Bar Graph of Min Temp")
# Arrange the plots in a 1x2 grid (1 row, 2 columns)
grid.arrange(plot1, plot2, ncol = 2)


