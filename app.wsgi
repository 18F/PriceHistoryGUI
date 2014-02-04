# This file is for (for example) Apache with mod_wsgi.

import PPBottleApp
import os

# Note this is quite different from PricesPaid.py,
# which is the entry point for using bottle as your webserver.
application = PPBottleApp.app


def application(environ, start_response):
  os.environ['PricesPaidAPIUsername']  = environ['PricesPaidAPIUsername']
  os.environ['PricesPaidAPIPassword']  = environ['PricesPaidAPIPassword']
  os.environ['PricesPaidAPIBasicAuthUsername']  = environ['PricesPaidAPIBasicAuthUsername']
  os.environ['PricesPaidAPIBasicAuthPassword']  = environ['PricesPaidAPIBasicAuthPassword']
  os.environ['P3APISALT']  = environ['P3APISALT']
  os.environ['PYCAS_SECRET']  = environ['PYCAS_SECRET']
  return PPBottleApp.app(environ, start_response)


