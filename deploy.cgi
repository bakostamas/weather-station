#!./bin/python
# coding: utf-8
from wsgiref.handlers import CGIHandler
from start_app import app
CGIHandler().run(app)
