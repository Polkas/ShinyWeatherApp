# Manuals
November 13, 2016  



##Introduction

During the Coursera Data Science course (Developing Data Products) it was built a Shiny apllication.
This application gives a spectrum of weather conditions across the world.
Another objective was to give  a possibility to predict future weather conditions.

Database was built using [WunderGround](http://www.wunderground.com). 
It is important to state that the application is made for educational purpose and the data should not be use in commercial purpose.
That is why the app showing only sample of Data.
Choosing cities there was taken into account a continental location and a Hemisphere.
Form many weather indicators there was chosen only 4 of them:

- Mean Temperature Celsius
- Mean Humidity
- Mean Pressure h-Pa
- Mean Wind Speed Km-h

It should be surprising that there is not indicator for raining. 
The decision was taken because of high unpredictable of raining and lack of records for this indicator.

##Usage

Within Dashboard of the App was placed 3 tabs:

- Prediction Tool
- Comparision Plot
- Sample of Data.

App contains 4 interactive widgets:

- Selecting a City and a Weather Indicator (impact on Prediction Tool and Comparision Plot)
- Prediction period and method (impact only on Prediction Tool)

###Prediction Tool

After you choose City, Weather Indicator, Forecast period and Prediction Method you have to Click the Submit Button.
For time series which have significant seasonal part Holt Winters should be better than Auto Arima. 
On the other hand the Auto Arima should be better for time series with nonstationarity and wicker seasonal part.
It should by stated that all linear exponential smoothing models could be represented by Arima. 

###Comparision Plot

After you choose City and Weather Indicator you have to Click the Submit Button. A Line for choosen City will be 4 times thicker.
