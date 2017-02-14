"""
Process the connected sensor's data
Implemented for Adafruit (Bosch) BME280 sensor
"""

try:
    # Get data from BME280 sensor
    import Adafruit_Python_BME280.Adafruit_BME280 as bme
    sensor = bme.BME280(mode=bme.BME280_OSAMPLE_8)
    temp = round(sensor.read_temperature(), 1)
    hum = round(sensor.read_humidity())
    pres = round(sensor.read_pressure()/100, 2)

except:
    # Show default 0 values
    temp = 0
    hum = 0
    pres = 0


class SensorData:
    """Connected sensor's class"""
    def __init__(self):
        self.temperature = temp
        self.humidity = hum
        self.pressure = pres
