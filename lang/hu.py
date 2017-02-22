"""
Hungarian language pack
"""


class LangPack:
    """Hungarian Language pack"""
    def __init__(self):
        self.now = 'Most'
        self.today = 'A mai nap'
        self.pressure = 'Légnyomás (hPA)'
        self.temperature = 'Hőmérséklet (°C)'
        self.sunrise = 'Napkelte'
        self.sunset = 'Napnyugta'
        self.clouds = 'Felhők'
        self.temp_forecast = 'Hőmérséklet előrejelzés'
        self.err_no_today_forecast = 'Nincs mai előrejelzés adat'
        self.week_days = {
            0: 'Vasárnap',
            1: 'Hétfő',
            2: 'Kedd',
            3: 'Szerda',
            4: 'Csütörtök',
            5: 'Péntek',
            6: 'Szombat'
        }
