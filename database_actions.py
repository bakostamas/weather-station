import app_settings, sqlite3, time
from weather import fetch_weather_now, fetch_weather_forecast

def connect_db():
    return sqlite3.connect(app_settings.DATABASE)


def save_current_data_sql():
    query = 'insert into weather_now(date_of_query, date_of_published, day_of_week, country_code, city_code, city_name, weather_id,'
    query += 'weather_sum, weather_desc, temp_now, pressure, humidity, wind_speed, wind_dir, clouds, rain_volume, snow_volume)'
    query += 'values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
    return query


def save_current_data_params(weather_now_fetch):
    parameters = [weather_now_fetch.query_date, weather_now_fetch.date, weather_now_fetch.day_of_week,
                  weather_now_fetch.country_code, app_settings.city_code,
                  weather_now_fetch.city_name, weather_now_fetch.weather_id, weather_now_fetch.weather_sum,
                  weather_now_fetch.weather_desc,
                  weather_now_fetch.temp_now, weather_now_fetch.pressure, weather_now_fetch.humidity,
                  weather_now_fetch.wind_speed,
                  weather_now_fetch.wind_dir, weather_now_fetch.clouds, weather_now_fetch.rain_volume,
                  weather_now_fetch.snow_volume]

    return parameters


def save_forecast_data_sql():
    query = 'insert into weather_forecast(date_of_query, date_of_forecast, day_of_week, country_code, city_code, city_name, weather_id,'
    query += 'weather_sum, weather_desc, temp_min, temp_max, pressure, humidity, wind_speed, wind_dir, clouds)'
    query += 'values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
    return query


def save_forecast_data_params(forecast_fetch, index):
    parameters = [forecast_fetch.query_date, forecast_fetch.date2[index], forecast_fetch.day_of_week[index],
                  forecast_fetch.country_code, app_settings.city_code,
                  forecast_fetch.city_name, forecast_fetch.weather_id[index], forecast_fetch.weather_sum[index],
                  forecast_fetch.weather_desc[index],
                  forecast_fetch.temp_min[index], forecast_fetch.temp_max[index], forecast_fetch.pressure[index],
                  forecast_fetch.humidity[index], forecast_fetch.wind_speed[index],
                  forecast_fetch.wind_dir[index], forecast_fetch.clouds[index]]

    return parameters


def get_pressure_history(city_code):
    query = 'select t.period, t.avg_pressure, t.min_pressure, t.max_pressure from v_pressure_history t '
    query += 'where t.city_code = '+ str(city_code) +' order by t.period'
    cur = connect_db().execute(query)
    pressure_history = cur.fetchall() #Puts the collected historical data to "pressure_history" list
    cur.close()
    return pressure_history



def get_temperature_history(city_code):
    query = 'select t.period, t.avg_temp_now, t.min_temp_now, t.max_temp_now from v_temperature_history t '
    query += 'where t.city_code = '+ str(city_code) +' order by t.period'
    cur = connect_db().execute(query)
    temperature_history = cur.fetchall()  # Puts the collected historical data to "temperature_history" list
    cur.close()
    return temperature_history


def getTodaysForecastTemp(city_code):
    query = 'select t.temp_min, t.temp_max, t.weather_id, t.weather_desc, t.humidity, t.pressure from v_todays_forecast t where t.city_code = '+ str(city_code)
    cur = connect_db().execute(query)
    todays_forecast_temp = cur.fetchall()
    cur.close()
    return todays_forecast_temp


#Save current weather data to database
def save_current_weather_to_db(weather_now_fetch = []):
    if not weather_now_fetch: #weather_now_fetch is emty (the function was called without this parameter)
        weather_now_fetch = fetch_weather_now(app_settings.city_code)

    db = connect_db()
    query = save_current_data_sql()
    params = save_current_data_params(weather_now_fetch)

    db.execute(query, params)
    db.commit()
    db.close()


#Save forecasted weather data to database
def save_forecast_weather_to_db(forecast_fetch = []):
    if not forecast_fetch: #forecast_now_fetch is emty (the function was called without this parameter)
        forecast_fetch = fetch_weather_forecast(app_settings.city_code)

    db = connect_db()
    query = save_forecast_data_sql()
    for i in range(0, 5): #Save 5 days forecast as 5 new records in database
        params = save_forecast_data_params(forecast_fetch, i)

        db.execute(query, params)
        db.commit()
    db.close()


# Get and save to database the current weather data if the package was called directly
# You can call it as a scheduled job by crontab
if __name__ == "__main__":
    save_current_weather_to_db()
    time.sleep(10)  # Wait 10 seconds before the next query (needed for openweathermap.org to work correctly)
    save_forecast_weather_to_db()
