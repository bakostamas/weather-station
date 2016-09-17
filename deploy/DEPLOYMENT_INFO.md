# Deployment on web server


## Use Python 3.x version!


## You msut register on openweathermap.org and get your appid
Go to openweathermap.org website and register (the free plan is suitable).
You will get your private appid.
Open app_settings.py file and set your private appid at section appid = ''


## Set up you city's code
Find your city code in _city_list/city.list.json file.
Open app_settings.py file and set your city code at section city_code = 3054643 (this default value is for Budapest).


## Recommended to install under virtualenv, but it's not a must have.
More info here: http://docs.python-guide.org/en/latest/dev/virtualenvs


## Install dependencies:
```
pip install -r requirements.txt
```


## Initiate the database, run it only once!
Run this code in a Python shell:
```python

python
from start_app import init_db
init_db()

exit()
```


## Set proper file permissions
- Set WRITE permission to OTHER on database folder and database.db
SQLITE needs this permission because it creates temp files before commit.
- Set EXECUTE permission to OTHER on deploy.cgi
- Set EXECUTE permission to OTHER on all project folders

```
chmod 777 database
chmod 666 database/database.db
chmod 775 deploy.cgi
chmod 775 deploy
chmod 775 lang
chmod 775 sql
chmod 775 static
chmod 775 templates
```


## Check and set deploy.cgi file
The first line must refer to the valid path of Python3 on server.
It could be in a virtualenv also.
```
#!/usr/bin/python
# coding: utf-8
from wsgiref.handlers import CGIHandler
from start_app import app
CGIHandler().run(app)
```

## Create a ScriptAlias in Apache webserver's httpd.con file
Create some similar ScriptAlias in httpd.con file
```
ScriptAlias /weather "/var/www/cgi-bin/weather/deploy.cgi"
```
Restart Apache webserver and now you can access the working application.
It's important to put "/" at the end of the URL:
http://some-domain.com/weather/


## Other deployment options at Flask modules documentation:
http://flask.pocoo.org/docs/0.10/deploying/


## If everything is working switch off DEBUG mode!
In app_settings.py file set DEBUG = False


## Collecting weather data
By default the system saves the collected weather data to database at every access.
A better solution if you set up a linux crontab job to this task.
To check your current crontab:
```
crontab -l
```

To set up a crontab job that gathers data at every 10 minutes (must run /deploy/data_collector.sh file):
```
crontab -e

  */10 * * * * /var/www/cgi-bin/your-project-folder/deploy/data_collector.sh>/dev/null 2>&1
```


## If you have got problem with locale codes
On LINUX list the installed local codes:
```
locale -a
```
Check start_app.py file at the localization section and fix the locale codes if needed.
On Windows it's usually simply like 'en' or 'hu'.
