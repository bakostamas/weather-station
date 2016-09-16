# Deployment on web server

--FULL ENGLISH VERSION IS COMMING SOON!--

## Use Python 3.x version!

## Recommended to install under virtualenv, but it's not a must have.
More info here: http://docs.python-guide.org/en/latest/dev/virtualenvs

## Install dependencies:
  pip install -r requirements.txt


LINUX: locale -a  (kilistázza a rendszeren lévő valid locale kódokat pl.: 'hu_HU.utf8')

app_settings.py-ben ez legyen (ha ez előző lekérdezés visszaadta 'hu_HU.utf8'-at):
locale.setlocale(locale.LC_ALL, 'hu_HU.utf8')

A database.db fájlon kell hogy legyen WRITE jog OTHER-nek is és ezen kívül az adott mappán is
kell WRITE jog OTHER-nek, amiben a database.db fájl van. SQLITE igényli, mert temp fájlokat is létrehoz, commit előtt.

start_app.py elejére ez is kell, így nincs karakter gond python 2-vel sem:
import sys
reload(sys)
sys.setdefaultencoding('utf-8')


deploy.cgi fájl ugyanott legyen, ahol start_app.py, tartalma pedig ez legyen
(fontos, hogy LINUX jellegű sorvégek legyenek a fájlban):

#!/usr/bin/python
# coding: utf-8
from wsgiref.handlers import CGIHandler
from start_app import app
CGIHandler().run(app)


deploy.cgi fájlra kell EXECUTE jog OTHER-nek is! A többi PYTHON fájlra nem szükséges EXECUTE jog.
(A project-ben lévő alkönyvtárakra is kell OTHER-nek EXECUTE jog mert egyébként nem tud a könyvtárba belépni)

Apache httpd.conf fájlba hozzáadni valami ilyesmit(/weather lesz az alias, utána meg a valós lokáció)
ScriptAlias /weather "/var/www/cgi-bin/weather/deploy.cgi"
FONTOS, hogy csak akkor jön be az oldal, ha az URL végére "/" jelet is rakunk
pl: http://bakostamas.ddns.net/weather/


Ha minden működik, app_settings.py-ben DEBUG = False

CRONTAB BEÁLLÍTÁSA (Linux ütemezett job az időjárási adatok rendszeres mentésére):
crontab -l (a jelenlegi crontab beállításokat mutatja)
crontab -e (az adott user crontab beállításainak szerkesztése)
  vi editor nyílik, itt adjuk hozzá ezt a sort (így 10 percenként fut):
  */10 * * * * /var/www/cgi-bin/weather_virtual_env/deploy/data_collector.sh>/dev/null 2>&1