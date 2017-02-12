
import json, pprint, app_settings, pytz
import connected_sensor
from datetime import datetime
from urllib.request import urlopen  # Only in Python 3

weather_list = {}


def get_weather_data(p_city_id, p_type, p_cnt):
    """
    Get weather data from openweathermap.org
    :param p_city_id: ID of the city
    :param p_type: 'DF'=Daily forecast for 7 days, 'F'=3 hours forecast for 5 days, 'NOW'=Weather Now
    :param p_cnt: Forecasted days limit, 0=No_limit
    :return: weather_data{} (dictionary)
    """
    if p_type == 'DF':
        url_domain = 'http://api.openweathermap.org/data/2.5/forecast/daily'
    elif p_type == 'F':
        url_domain = 'http://api.openweathermap.org/data/2.5/forecast'
    elif p_type == 'NOW':
        url_domain = 'http://api.openweathermap.org/data/2.5/weather'

    access_link = url_domain+'?id='+str(p_city_id)+'&appid='+app_settings.appid+'&units='+app_settings.units+\
                  '&lang='+app_settings.lang+'&mode='+app_settings.mode

    if p_cnt > 0:
        access_link += '&cnt='+str(p_cnt)

    try:
        response = urlopen(access_link)
        json_data = response.read().decode('utf-8')
        weather_data = json.loads(json_data)
    except: # If the weather server is unavailable return an empty dictionary
        weather_data = {}

    return weather_data


class WeatherNow:
    """Weather details for current weather"""
    def __init__(self):

        if len(weather_list) != 0:
            self.query_date = datetime.now(pytz.timezone(app_settings.timezone))
            self.city_name = weather_list['name']
            self.country_code = weather_list['sys']['country']
            timestamp = weather_list['dt']
            date_object = datetime.fromtimestamp(timestamp, tz=pytz.timezone(app_settings.timezone))
            self.date = date_object.strftime(app_settings.full_date_format)
            self.day_of_week = date_object.strftime("%A").capitalize()
            self.clouds = weather_list['clouds']['all']
            try:
                self.wind_dir = weather_list['wind']['deg']
            except:
                self.wind_dir = '0'
            # int() ensures to not display the .0 decimal of the rounded value
            self.wind_speed = int(round(weather_list['wind']['speed'] * 3.6, 0))  # converted to Km/h
            self.humidity = int(round(weather_list['main']['humidity'], 0))
            self.pressure = int(round(weather_list['main']['pressure'], 0))
            self.temp_now = round(weather_list['main']['temp'], 1)  # rounded to 1 decimal
            self.weather_id = weather_list['weather'][0]['id']
            self.weather_sum = weather_list['weather'][0]['main']
            self.weather_desc = weather_list['weather'][0]['description'].title()  # First letters to uppercase
            try:
                self.rain_volume = weather_list['rain']['3h']  # Rain vloume in the last 3 hours
            except:
                self.rain_volume = 0
            try:
                self.snow_volume = weather_list['snow']['3h']  # Snow volume in the last 3 hours
            except:
                self.snow_volume = 0
            timestamp_sunrise = weather_list['sys']['sunrise']
            date_object_sunrise = datetime.fromtimestamp(timestamp_sunrise, tz=pytz.timezone(app_settings.timezone))
            self.sunrise = date_object_sunrise.strftime(app_settings.time_format)
            timestamp_sunset = weather_list['sys']['sunset']
            date_object_sunset = datetime.fromtimestamp(timestamp_sunset, tz=pytz.timezone(app_settings.timezone))
            self.sunset = date_object_sunset.strftime(app_settings.time_format)
            # Define the weather icon and css template based on it's day or night now:
            if date_object_sunrise < self.query_date and self.query_date < date_object_sunset:
                self.weather_icon = 'wi-owm-day-' + str(self.weather_id)
                self.color_theme = app_settings.color_theme_day
            else:
                self.weather_icon = 'wi-owm-night-' + str(self.weather_id)
                self.color_theme = app_settings.color_theme_night

        # Get sensor's data
        self.sensor_data = connected_sensor.SensorData()



class WeatherForecast:
    """Weather details for forecast"""
    def __init__(self):
        # Init the arrays with 0 values at index zero color_theme
        self.date = ["0"]
        self.date2 = ["0"]
        self.day_of_week = ["0"]
        self.clouds = ["0"]
        self.wind_dir = ["0"]
        self.wind_speed = ["0"]
        self.humidity = ["0"]
        self.pressure = ["0"]
        self.temp_day = ["0"]
        self.temp_min = ["0"]
        self.temp_max = ["0"]
        self.temp_diff = ["0"]
        self.temp_diff_trend = ["0"]
        self.temp_night = ["0"]
        self.temp_eve = ["0"]
        self.temp_morn = ["0"]
        self.weather_id = ["0"]
        self.weather_sum = ["0"]
        self.weather_desc = ["0"]

        if len(weather_list) != 0:
            self.city_name = weather_list['city']['name']
            self.country_code = weather_list['city']['country']
            self.query_date = datetime.now(pytz.timezone(app_settings.timezone))

            for list_index in range(1, 6):  # weather_list['list']
                timestamp = weather_list['list'][list_index]['dt']
                date_object = datetime.fromtimestamp(timestamp, tz=pytz.timezone(app_settings.timezone))
                self.date.append(date_object.strftime(app_settings.short_date_format))  # The same date in different format
                self.date2.append(date_object.strftime("%Y-%m-%d"))  # The same date in different format
                self.day_of_week.append(date_object.strftime("%A").capitalize())
                self.clouds.append(weather_list['list'][list_index]['clouds'])
                self.wind_dir.append(weather_list['list'][list_index]['deg'])
                self.wind_speed.append(int(round(weather_list['list'][list_index]['speed'] * 3.6, 0)))  # converted to Km/h
                self.humidity.append(int(round(weather_list['list'][list_index]['humidity'], 0)))
                self.pressure.append(int(round(weather_list['list'][list_index]['pressure'],0)))
                self.temp_day.append(int(round(weather_list['list'][list_index]['temp']['day'], 0)))
                self.temp_min.append(int(round(weather_list['list'][list_index]['temp']['min'], 0)))
                self.temp_max.append(int(round(weather_list['list'][list_index]['temp']['max'], 0)))

                # "temp_diff" is the temperature difference between the given day's max and the previous day's max.
                difference = calculate_temp_dif(self.temp_max[list_index], self.temp_max[list_index-1])
                self.temp_diff.append(difference['temp_diff'])
                self.temp_diff_trend.append(difference['temp_diff_trend'])

                self.temp_night.append(int(round(weather_list['list'][list_index]['temp']['night'], 0)))
                self.temp_eve.append(int(round(weather_list['list'][list_index]['temp']['eve'], 0)))
                self.temp_morn.append(int(round(weather_list['list'][list_index]['temp']['morn'], 0)))
                self.weather_id.append(weather_list['list'][list_index]['weather'][0]['id'])
                self.weather_sum.append(weather_list['list'][list_index]['weather'][0]['main'])
                self.weather_desc.append(weather_list['list'][list_index]['weather'][0]['description'].title())  # First letters to uppercase

def fetch_weather_now(p_city_code):
    """
    Fetch the current weather
    :param p_city_code: ID of the city
    """
    global weather_list
    weather_list.clear()
    access_type = 'NOW'  # Current weather
    weather_list = get_weather_data(p_city_code, access_type, 0)

    weather = WeatherNow()
    return weather


def fetch_weather_forecast(p_city_code):
    """
    Fetch the forecasted weather
    :param p_city_code: ID of the city
    """
    global weather_list
    weather_list.clear()
    access_type = 'DF'  # Daily forecast
    weather_list = get_weather_data(p_city_code, access_type, 0)

    weather = WeatherForecast()  # parameter: index in the weather_list
    return weather


def calculate_temp_dif(temp_today, temp_last_day):
    """
    Calculate the difference between two temperature and determine the appropriate icon code
    :param temp_today: Today's max temperature forecast
    :param temp_last_day: Yesterday's max temperature
    """
    diff = int(temp_today) - int(temp_last_day)

    if diff > 0:
        temp_diff = '+' + str(diff)
        temp_diff_trend = ['wi-direction-up', 'red']
    elif diff < 0:
        temp_diff = str(diff)
        temp_diff_trend = ['wi-direction-down', 'blue']
    else:
        temp_diff = str(diff)
        temp_diff_trend = ['wi-direction-right', 'green']

    return {'temp_diff': temp_diff, 'temp_diff_trend': temp_diff_trend}


# ONLY FOR TESTING PURPOSE:

#  weather_list = get_weather_data(3054643, 'DF', 0)
#  pprint.pprint(weather_list)

# for list_index in weather_list['list']:
#     print(list_index)
#
# print('----')
# print(weather_list['list'][6])




