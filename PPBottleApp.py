from bottle import Bottle, run, template,request,TEMPLATE_PATH,static_file,HeaderDict,BaseResponse

# from SearchApi import searchApi
import urllib
import ast

import LogFeedback
 
from ppGuiConfig import URLToPPSearchApiSolr,GoogleAnalyticsInclusionScript,\
     PricesPaidAPIUsername,PricesPaidAPIPassword


import auth

# Hopefully this will work!
PathToBottleWebApp = "./"
PathToExternalFiles = "../"


PathToJSFiles=PathToExternalFiles+"js/"
PathToCSSFiles=PathToExternalFiles+"css/"
PathToJSPlugins=PathToJSFiles + "plugins/"
PathToSlickGridMaster=PathToExternalFiles+"/SlickGrid-master/"

app = Bottle()
prefix = ''

# Bottle seems to be fairly restrictive with static files,
# there might be a better way to do this.
@app.route(prefix+'/js/<path:path>')
def server_static(path):
    return static_file(path, root=PathToJSFiles)

@app.route(prefix+'/theme/<path:path>')
def server_static(path):
    return static_file(path, root=PathToBottleWebApp+"theme/")

@app.route(prefix+'/css/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToCSSFiles)

@app.route(prefix+'/SlickGrid-master/<path:path>')
def server_static(path):
    return static_file(path, root=PathToSlickGridMaster)

from bottle import template

@app.route(prefix+'/')
def login():
    return template('Login',message='',goog_anal_script=GoogleAnalyticsInclusionScript)



@app.route(prefix+'/StartPage',method='POST')
def pptriv():
    username = request.forms.get('username')
    password = request.forms.get('password')
    if (not auth.does_authenticate(username,password)):
        return template('Login',message='Improper Credentials.',goog_anal_script=GoogleAnalyticsInclusionScript)
    search_string = request.forms.get('search_string')
    search_string = search_string if search_string is not None else "Dell Latitude"
    psc_pattern = request.forms.get('psc_pattern')
    ses_id = auth.create_session_id()
    return template('StartPage',search_string=search_string,\
                    acsrf=auth.get_acsrf(ses_id),\
                    session_id=ses_id,\
                    psc_pattern=psc_pattern,goog_anal_script=GoogleAnalyticsInclusionScript)

@app.route(prefix+'/PricesPaid',method='POST')
def pptriv():
    username = request.forms.get('username')
    password = request.forms.get('password')
    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')

    if (not auth.is_valid_acsrf(ses_id)):
        return template('Login',message='Improper Credentials or Timeout.',goog_anal_script=GoogleAnalyticsInclusionScript)
    
    auth.update_acsrf(ses_id)

    search_string = request.forms.get('search_string')
    search_string = search_string if search_string is not None else "Dell Latitude"
    commodity_id = request.forms.get('commodity_id')
    print 'COMMODITY_ID = '+commodity_id
    return template('MainPage',search_string=search_string,user=username,\
                    acsrf=auth.get_acsrf(ses_id),\
                    session_id=ses_id,\
                    password=password,commodity_id=commodity_id,goog_anal_script=GoogleAnalyticsInclusionScript)
                    

@app.route(prefix+'/search',method='POST')
def apisolr():
    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')
    if (not auth.is_valid_acsrf(ses_id)):
        return template('Login',message='Improper Credentials.',goog_anal_script=GoogleAnalyticsInclusionScript)

    auth.update_acsrf(ses_id)

    search_string = request.forms.get('search_string')
    psc_pattern = request.forms.get('psc_pattern')
    print "API search_string" + search_string
    # I'm doing this as a call to keep the API separated as
    # completely from the GUI as possible.
    print "URL"+URLToPPSearchApiSolr
    params = urllib.urlencode({ 'username' : PricesPaidAPIUsername,\
                                'password' : PricesPaidAPIPassword,\
                                'search_string': search_string,\
                                'psc_pattern': psc_pattern})
    f = urllib.urlopen(URLToPPSearchApiSolr, params)
    content = f.read()
    # This is inefficient, but I can't seem to get Bottle to
    # let me procue a correct JSON response with out using a dictionary.
    # I tried using BaseResponse.  This could be my weakness
    # with Pyton or confusion in Bottle.
    d = ast.literal_eval(content)
    return d

@app.route(prefix+'/record_feedback',method='POST')
def feedback():
    message = request.forms.get('message')
    name = request.forms.get('name')
    LogFeedback.logFeedback(name,message);
    return "true";

