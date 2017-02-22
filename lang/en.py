"""
English language pack
"""


class LangPack:
    """English Language pack"""
    def __init__(self):
        self.now = 'Now'
        self.today = 'Today'
        self.pressure = 'Air pressure (hPA)'
        self.temperature = 'Temperature (°C)'
        self.sunrise = 'Sunrise'
        self.sunset = 'Sunset'
        self.clouds = 'Clouds'
        self.temp_forecast = 'Temperature forecast'
        self.err_no_today_forecast = 'No forecast data for today'
        self.week_days = {
            0: 'Sunday',
            1: 'Monday',
            2: 'Tuesday',
            3: 'Wednesday',
            4: 'Thursday',
            5: 'Friday',
            6: 'Saturday'
        }
