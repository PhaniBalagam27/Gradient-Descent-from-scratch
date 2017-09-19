# Gradient-Descent-from-scratch
Gradient Descent with Linear regression on Bike Sharing Dataset.

Data Set Analysis on Bike Rentals:
The dataset “Bike-Sharing-Dataset” was obtained by the UCI Machine Learning Repository. This is a collection of databeses, domain theories and data generators which are used by the machine learning community for empirical analyses. The archive was created in 1987 by David Aha and fellow graduate students at UC Irvine. Since then it has been widely used by student, educators and researchers. The current website was designed in 2007. The UCI Machine Learning Repository is based on donations of researchers, mostly outside of UCI. We found the dataset “Bike Sharing Dataset” under the index “regression” and chose the sub-dataset “day”.


Original columns:

weathersit:
1: Clear, Few clouds, Partly cloudy,
2: Mist and Cloudy, Mist and Broken clouds, Mist and Few clouds, Mist
3: Light Snow, Light Rain and Thunderstorm and Scattered clouds, Light Rain an dScattered clouds
4: Heavy Rain and Ice Pallets and Thunderstorm and Mist, Snow and Fog
instant: record index

dteday: date

season: season (1:spring, 2:summer, 3:fall, 4:winter)

yr: year (0: 2011, 1:2012)

mnth: month ( 1 to 12)

holiday: weather day is holiday or not (extracted from http://dchr.dc.gov/page/holiday-schedule)

weekday: day of the week

workingday: if day is neither weekend nor holiday is 1, otherwise is 0.

temp: Normalized temperature in Celsius. The values are divided to 41 (max)

atemp: Normalized feeling temperature in Celsius. The values are divided to 50 (max)

hum: Normalized humidity. The values are divided to 100 (max)

windspeed: Normalized wind speed. The values are divided to 67 (max)

casual: count of casual users

registered: count of registered users

cnt: count of total rental bikes including both casual and registered

New columns:

month.names: names of the months

weather: converted weathersituation
1 = “nice”
2 = “cloudy”
3 = “wet”
4 = “lousy”
raw.temp: converted normalized temperature in Celsius

raw.windspeed: converted normalized windspeed

raw.humidity: converted normalized humidity

raw.atemp: converted normalized feeled temperature in Celsius

raw.mean.temp.atemp: mean between converted normalized temperature and feeled temperature (raw.atemp) in Celsius

