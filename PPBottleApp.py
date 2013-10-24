from bottle import Bottle, run, template,request,TEMPLATE_PATH,static_file,HeaderDict,BaseResponse

import time
import urllib
import ast
import sys

import LogFeedback
import LogActivity
import requests
 
from ppGuiConfig import URLToPPSearchApiSolr,GoogleAnalyticsInclusionScript,\
     PricesPaidAPIUsername,PricesPaidAPIPassword,\
     PricesPaidAPIBasicAuthUsername,PricesPaidAPIBasicAuthPassword


import auth

PathToBottleWebApp = "./"
PathToExternalFiles = "../"


PathToCSSFiles=PathToExternalFiles+"css/"

app = Bottle()


@app.route('/theme/<path:path>')
def server_static(path):
    return static_file(path, root=PathToBottleWebApp+"theme/")

@app.route('/css/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToCSSFiles)

from bottle import template

@app.route('/')
def legalNotice():
    LogActivity.logPageTurn("nosession","LegalNotice")
    return template('LegalNotice',goog_anal_script=GoogleAnalyticsInclusionScript)

@app.route('/SearchHelp')
def searchHelp():
    LogActivity.logPageTurn("nosession","SearchHelp")
    return template('SearchHelp',goog_anal_script=GoogleAnalyticsInclusionScript)

@app.route('/Logout',method='POST')
def logoutViaPost():
    LogActivity.logPageTurn("nosession","Logout")

    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')
    auth.del_session(ses_id)
    return template('Logout',goog_anal_script=GoogleAnalyticsInclusionScript)

@app.route('/Logout',method='GET')
def logoutViaGet():
    LogActivity.logPageTurn("nosession","Logout")

    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')
    auth.del_session(ses_id)
    return template('Logout',goog_anal_script=GoogleAnalyticsInclusionScript)

@app.route('/Login')
def login():
    LogActivity.logPageTurn("nosession","LoginPage")
    return template('Login',message='',goog_anal_script=GoogleAnalyticsInclusionScript)

@app.route('/StartPage',method='POST')
def pptriv():
    username = request.forms.get('username')
    password = request.forms.get('password')
    # just a little throttle to slow down any denial of service attack..
    time.sleep(1.0);
    if (not auth.does_authenticate(username,password)):
        LogActivity.logBadCredentials(username)
        return template('Login',message='Improper Credentials.',goog_anal_script=GoogleAnalyticsInclusionScript)
    search_string = request.forms.get('search_string')
    search_string = search_string if search_string is not None else "Dell Latitude"
    psc_pattern = request.forms.get('psc_pattern')
    ses_id = auth.create_session_id()
    LogActivity.logSessionBegin(username,ses_id)
    LogActivity.logPageTurn(ses_id,"StartPage")
    return template('StartPage',search_string=search_string,\
                    acsrf=auth.get_acsrf(ses_id),\
                    username=username, \
                    session_id=ses_id,\
                    psc_pattern=psc_pattern,goog_anal_script=GoogleAnalyticsInclusionScript)

# I want to swallow these silently due to a weird browser problem
@app.route('/PricesPaid',method='GET')
def swallow(): 
    return "true"


@app.route('/PricesPaid',method='POST')
def pptriv():
    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')

    if (not auth.is_valid_acsrf(ses_id)):
        return template('Login',message='Improper Credentials or Timeout.',goog_anal_script=GoogleAnalyticsInclusionScript)
    
    auth.update_acsrf(ses_id)

    search_string = request.forms.get('search_string')
    search_string = search_string if search_string is not None else "Dell Latitude"
    commodity_id = request.forms.get('commodity_id')
    print 'COMMODITY_ID = '+commodity_id

    LogActivity.logPageTurn(ses_id,"MainPage")
    return template('MainPage',search_string=search_string,\
                    acsrf=auth.get_acsrf(ses_id),\
                    session_id=ses_id,\
                    commodity_id=commodity_id,goog_anal_script=GoogleAnalyticsInclusionScript)


@app.route('/search',method='POST')
def apisolr():
    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')

    if (not auth.is_valid_acsrf(ses_id)):
        dict = {0: {"status": "BadAuthentication"}}
        return dict;

    auth.update_acsrf(ses_id)

    search_string = request.forms.get('search_string')
    psc_pattern = request.forms.get('psc_pattern')

    LogActivity.logSearchBegun(ses_id,psc_pattern,search_string)


    payload = { 'username' : PricesPaidAPIUsername,\
                                'password' : PricesPaidAPIPassword,\
                                'search_string': search_string,\
                                'psc_pattern': psc_pattern}

    r = requests.post(URLToPPSearchApiSolr, data=payload, \
                          auth=(PricesPaidAPIBasicAuthUsername, PricesPaidAPIBasicAuthPassword), verify=False)

    LogActivity.logDebugInfo("Got Past Post to :"+URLToPPSearchApiSolr)

    content = r.text

    # This is inefficient, but I can't seem to get Bottle to
    # let me procure a correct JSON response with out using a dictionary.
    # I tried using BaseResponse.  This could be my weakness
    # with Python or confusion in Bottle.
    d = ast.literal_eval(content)

    LogActivity.logSearchDone(ses_id,psc_pattern,search_string)
    return d

@app.route('/record_feedback',method='POST')
def feedback():
    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')

    LogActivity.logDebugInfo("acsrf ses_d :"+acsrf+ses_id)
    if (not auth.is_valid_acsrf(ses_id)):
        dict = {0: {"status": "BadAuthentication"}}
        return dict;

    LogActivity.logDebugInfo("authenticated !")
    LogActivity.logFeedback(ses_id)
    message = request.forms.get('message')
    name = request.forms.get('name')
    radio_list_value = request.forms.get('radio_list_value')
    LogFeedback.logFeedback(name,message,radio_list_value);
    return "true";

