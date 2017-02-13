"""
Start script for Weather Station application
"""

from weather import fetch_weather_now, fetch_weather_forecast, calculate_temp_dif
from flask import Flask, render_template
from contextlib import closing
import app_settings, database_actions, json, importlib, locale, time


app = Flask(__name__)
app.config.from_object(app_settings)  # The UPPERCASE variables contain the configuration


# Initiate the database, run it only once!
# Call from python shell:
# from start_app import init_db
# init_db()
def init_db():
    with closing(database_actions.connect_db()) as db:
        with app.open_resource('sql/schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()


# Localization
language_pack = 'lang.' + app_settings.lang

lang = importlib.import_module(language_pack)  # Import the needed language pack
lang_dict = lang.LangPack()


if app_settings.lang == 'en':
    locale.setlocale(locale.LC_ALL, 'en_US.utf8')  # on windows: 'en'
elif app_settings.lang == 'hu':
    locale.setlocale(locale.LC_ALL, 'hu_HU.utf8')  # on windows: 'hu'
else:
    locale.setlocale(locale.LC_ALL, 'en_US.utf8')  # on windows: 'en'


@app.route("/")
def index():
    # Get and save to database current weather data
    weather_now_fetch = fetch_weather_now(app_settings.city_code)
    if app_settings.log_gathered_data == True:
        database_actions.save_current_weather_to_db(weather_now_fetch)

    time.sleep(2)  # Wait 2 seconds before the next query (needed for openweathermap.org to work correctly)

    # Get and save to database forecast weather data
    forecast_fetch = fetch_weather_forecast(app_settings.city_code)
    if app_settings.log_gathered_data == True:
        database_actions.save_forecast_weather_to_db(forecast_fetch)

    # Get air pressure history from recorded data
    pressure_history = database_actions.get_pressure_history(app_settings.city_code)
    # Appends "pressure_history" with current data as period 0, for AVG, MIN and MAX also:
    pressure_history.append(
        [lang_dict.now, weather_now_fetch.pressure, weather_now_fetch.pressure, weather_now_fetch.pressure])

    # Get temperature history from recorded data
    temperature_history = database_actions.get_temperature_history(app_settings.city_code)
    # Appends "temperature_history" with current data as period 0, for AVG, MIN and MAX also:
    temperature_history.append(
        [lang_dict.now, weather_now_fetch.temp_now, weather_now_fetch.temp_now, weather_now_fetch.temp_now])

    # Get today's forecast from recorded data
    forecast_temp_history = database_actions.getTodaysForecastTemp(app_settings.city_code)

    # Update the forecasted array at index 0 with today's forecasted data
    if len(forecast_temp_history) != 0:
        forecast_fetch.weather_id[0] = forecast_temp_history[0][2]
        forecast_fetch.weather_desc[0] = forecast_temp_history[0][3]
        forecast_fetch.temp_min[0] = forecast_temp_history[0][0]
        forecast_fetch.temp_max[0] = forecast_temp_history[0][1]
        forecast_fetch.humidity[0] = forecast_temp_history[0][4]
        forecast_fetch.pressure[0] = forecast_temp_history[0][5]

        # Recalculate the temperature difference at index 1
        difference = calculate_temp_dif(forecast_fetch.temp_max[1], forecast_fetch.temp_max[0])
        forecast_fetch.temp_diff[1] = difference['temp_diff']
        forecast_fetch.temp_diff_trend[1] = difference['temp_diff_trend']
    else:
        forecast_fetch.weather_desc[0] = lang_dict.err_no_today_forecast

    # Get sensor's pressure history from recorded data
    sensor_pres_history = database_actions.get_sensor_pres_history(app_settings.city_code)

    return render_template('index.html',
                           weather_now=weather_now_fetch,
                           forecast=forecast_fetch,
                           # pressure_hist=json.dumps(pressure_history),  # json needed to javascript to understand
                           # temperature_hist=json.dumps(temperature_history),  # json needed for javascript to understand
                           # forecast_temp_hist= json.dumps(forecast_temp_history),
                           sensor_pres_history=json.dumps(sensor_pres_history), # json needed for javascript to understand
                           lang_dict = lang_dict
                           )



# @app.route("/<int:city_id>")
# def index_by_cityid(city_id):
#     return render_template('index.html',
#                            weather_now=fetch_weather_now(city_id),
#                            forecast=fetch_weather_forecast(city_id)
#                            )


if __name__ == "__main__":
    app.run()  # Debug mode declared in app_settings!
