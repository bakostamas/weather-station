--
-- File generated with SQLiteStudio v3.0.7 on Wed Sep 7 23:30:43 2016
--
-- Text encoding used: windows-1250
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: weather_forecast
CREATE TABLE weather_forecast (
    id               INTEGER  PRIMARY KEY AUTOINCREMENT,
    date_of_query    DATETIME DEFAULT (datetime('now', 'localtime') ) 
                              NOT NULL,
    date_of_forecast DATETIME,
    day_of_week      TEXT,
    country_code     TEXT,
    city_code        NUMERIC,
    city_name        TEXT,
    weather_id       NUMERIC,
    weather_sum      TEXT,
    weather_desc     TEXT,
    temp_min         NUMERIC,
    temp_max         NUMERIC,
    pressure         NUMERIC,
    humidity         NUMERIC,
    wind_speed       NUMERIC,
    wind_dir         NUMERIC,
    clouds           NUMERIC
);


-- Table: weather_now
CREATE TABLE weather_now (
    id                INTEGER  PRIMARY KEY AUTOINCREMENT,
    date_of_query     DATETIME DEFAULT (datetime('now', 'localtime') ) 
                               NOT NULL,
    date_of_published DATETIME,
    day_of_week       TEXT,
    country_code      TEXT,
    city_code         NUMERIC,
    city_name         TEXT,
    weather_id        NUMERIC,
    weather_sum       TEXT,
    weather_desc      TEXT,
    temp_now          NUMERIC,
    pressure          NUMERIC,
    humidity          NUMERIC,
    wind_speed        NUMERIC,
    wind_dir          NUMERIC,
    clouds            NUMERIC,
    rain_volume       NUMERIC,
    snow_volume       NUMERIC,
    sensor_temp       NUMERIC,
    sensor_hum        NUMERIC,
    sensor_pres       NUMERIC
);


-- Index: idx1_weather_now
CREATE INDEX idx1_weather_now ON weather_now (
    date_of_published
);


-- View: v_temperature_history
CREATE VIEW v_temperature_history AS
    SELECT - 3 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0 AND 0.125
           )
     GROUP BY city_code
    UNION
    SELECT - 6 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.125001 AND 0.25
           )
     GROUP BY city_code
    UNION
    SELECT - 9 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.250001 AND 0.375
           )
     GROUP BY city_code
    UNION
    SELECT - 12 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.375001 AND 0.5
           )
     GROUP BY city_code
    UNION
    SELECT - 15 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.500001 AND 0.625
           )
     GROUP BY city_code
    UNION
    SELECT - 18 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.625001 AND 0.75
           )
     GROUP BY city_code
    UNION
    SELECT - 21 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.750001 AND 0.875
           )
     GROUP BY city_code
    UNION
    SELECT - 24 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.875001 AND 1
           )
     GROUP BY city_code
    UNION
    SELECT - 27 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.000001 AND 1.125
           )
     GROUP BY city_code
    UNION
    SELECT - 30 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.125001 AND 1.25
           )
     GROUP BY city_code
    UNION
    SELECT - 33 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.250001 AND 1.375
           )
     GROUP BY city_code
    UNION
    SELECT - 36 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.375001 AND 1.5
           )
     GROUP BY city_code
    UNION
    SELECT - 39 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.500001 AND 1.625
           )
     GROUP BY city_code
    UNION
    SELECT - 42 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.625001 AND 1.75
           )
     GROUP BY city_code
    UNION
    SELECT - 45 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.750001 AND 1.875
           )
     GROUP BY city_code
    UNION
    SELECT - 48 period,
          round(avg(temp_now), 2) avg_temp_now,
          round(min(temp_now), 2) min_temp_now,
          round(max(temp_now), 2) max_temp_now,
          city_code
      FROM (
               SELECT min(t.temp_now) temp_now,
                      t.city_code
                 FROM weather_now t
                WHERE (t.temp_now IS NOT NULL AND 
                       t.temp_now <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.875001 AND 2
           )
     GROUP BY city_code;


-- View: v_pressure_history
CREATE VIEW v_pressure_history AS
    SELECT - 3 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0 AND 0.125
           )
     GROUP BY city_code
    UNION
    SELECT - 6 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.125001 AND 0.25
           )
     GROUP BY city_code
    UNION
    SELECT - 9 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.250001 AND 0.375
           )
     GROUP BY city_code
    UNION
    SELECT - 12 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.375001 AND 0.5
           )
     GROUP BY city_code
    UNION
    SELECT - 15 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.500001 AND 0.625
           )
     GROUP BY city_code
    UNION
    SELECT - 18 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.625001 AND 0.75
           )
     GROUP BY city_code
    UNION
    SELECT - 21 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.750001 AND 0.875
           )
     GROUP BY city_code
    UNION
    SELECT - 24 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 0.875001 AND 1
           )
     GROUP BY city_code
    UNION
    SELECT - 27 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.000001 AND 1.125
           )
     GROUP BY city_code
    UNION
    SELECT - 30 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.125001 AND 1.25
           )
     GROUP BY city_code
    UNION
    SELECT - 33 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.250001 AND 1.375
           )
     GROUP BY city_code
    UNION
    SELECT - 36 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.375001 AND 1.5
           )
     GROUP BY city_code
    UNION
    SELECT - 39 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.500001 AND 1.625
           )
     GROUP BY city_code
    UNION
    SELECT - 42 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.625001 AND 1.75
           )
     GROUP BY city_code
    UNION
    SELECT - 45 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.750001 AND 1.875
           )
     GROUP BY city_code
    UNION
    SELECT - 48 period,
          round(avg(pressure), 2) avg_pressure,
          round(min(pressure), 2) min_pressure,
          round(max(pressure), 2) max_pressure,
          city_code
      FROM (
               SELECT min(t.pressure) pressure,
                      t.city_code
                 FROM weather_now t
                WHERE (t.pressure IS NOT NULL AND 
                       t.pressure <> '') 
                GROUP BY julianday(t.date_of_published),
                         t.city_code
               HAVING julianday(datetime('now', 'localtime') ) - julianday(t.date_of_published) BETWEEN 1.875001 AND 2
           )
     GROUP BY city_code;


-- View: v_todays_forecast
CREATE VIEW v_todays_forecast AS
    SELECT t.*
      FROM weather_forecast t
     WHERE t.id = (
                      SELECT max(f.id) 
                        FROM weather_forecast f
                       WHERE date(f.date_of_forecast) = date('now', 'localtime') 
                  );


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
