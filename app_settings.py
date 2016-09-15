"""
Settings for Weather Station application
"""

appid = ''  # appid to openweathermap.com
units = 'metric'
lang = 'hu'  # 'en', 'hu'
timezone = 'Europe/Budapest'
mode = 'json'
city_code = 3054643  # Sample city codes: 3054643=Budapest, 5506956=LasVegas, 5128638=NewYork

# Available themes: natural_green.css, riverside_blue.css, sharkskin_grey.css, dusty_cedar.css, lilac_grey.css, sand_dollar.css
color_theme = 'riverside_blue.css'

log_gathered_data = True  # If True it logs the gathered weather data at every access.
# If you don't have scheduled crontab for gathering weather data set it True!

DATABASE = './database/database.db'
DEBUG = True  # On production it shouldn't be in debug mode!
