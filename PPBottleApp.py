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
     PricesPaidAPIBasicAuthUsername,PricesPaidAPIBasicAuthPassword,\
     LocalURLToRecordFeedback

import auth

import cPickle as pickle
from cStringIO import StringIO

# I am duplicating this because I don't really know how t organize python 
# classes.  Probably it should be removed.
import morris_config

URL_TO_MORRIS_PORTFOLIOS_API = "http://localhost:" + str(morris_config.BOTTLE_DEORATOR_PORTFOLIOS_API_PORT)
URL_TO_MORRIS_TAGS_API = "http://localhost:" + str(morris_config.BOTTLE_DEORATOR_TAGS_API_PORT)


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

@app.route('/js/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToBottleWebApp+"js/")

@app.route('/MorrisDataDecorator/js/<filename>')
def server_static(filename):
    return static_file(filename, root="../MorrisDataDecorator/js/")

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
                    feedback_url=LocalURLToRecordFeedback,\
                    commodity_id=commodity_id,goog_anal_script=GoogleAnalyticsInclusionScript)

@app.route('/PortfolioPage',method='POST')
def render_portfolio():
    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')

    if (not auth.is_valid_acsrf(ses_id)):
        return template('Login',message='Improper Credentials or Timeout.',goog_anal_script=GoogleAnalyticsInclusionScript)

    auth.update_acsrf(ses_id)

    LogActivity.logPageTurn(ses_id,"Portfolio")

    portfolio = request.forms.get('portfolio')

    return template('Portfolio',acsrf=auth.get_acsrf(ses_id),\
                    session_id=ses_id,\
                    portfolio=portfolio,\
                    feedback_url=LocalURLToRecordFeedback,\
                        goog_anal_script=GoogleAnalyticsInclusionScript)


@app.route('/returnPortfolio',method='POST')
def apisolr():
    acsrf = request.forms.get('antiCSRF')
    ses_id = request.forms.get('session_id')

    if (not auth.is_valid_acsrf(ses_id)):
        dict = {0: {"status": "BadAuthentication"}}
        return dict;
    auth.update_acsrf(ses_id)
    portfolio = request.forms.get('portfolio')

    print "portfolio = "+portfolio
    r = requests.get(URL_TO_MORRIS_PORTFOLIOS_API+"/decoration/"+portfolio)
    content = r.text
    d = ast.literal_eval(r.text)
    p3ids = d['data']

    payload = { 'username' : PricesPaidAPIUsername,\
                                'password' : PricesPaidAPIPassword,\
                                'p3ids' : pickle.dumps(p3ids)
                }

    r = requests.post(URLToPPSearchApiSolr+"/fromIds", data=payload, \
                          auth=(PricesPaidAPIBasicAuthUsername, PricesPaidAPIBasicAuthPassword), verify=False)

    LogActivity.logDebugInfo("Got Past Post to :"+URLToPPSearchApiSolr)

    content = r.text

    # This is inefficient, but I can't seem to get Bottle to
    # let me procure a correct JSON response with out using a dictionary.
    # I tried using BaseResponse.  This could be my weakness
    # with Python or confusion in Bottle.
    d = ast.literal_eval(content)
    return d

@app.route('/SimpleHTML',method='GET')
def apisolr():
    acsrf = request.query['antiCSRF']
    ses_id = request.query['session_id']

    if (not auth.is_valid_acsrf(ses_id)):
        dict = {0: {"status": "BadAuthentication"}}
        return dict;
    auth.update_acsrf(ses_id)
    portfolio = request.query['portfolio']

    print "portfolio = "+portfolio
    r = requests.get(URL_TO_MORRIS_PORTFOLIOS_API+"/decoration/"+portfolio)
    content = r.text
    d = ast.literal_eval(r.text)
    p3ids = d['data']

    payload = { 'username' : PricesPaidAPIUsername,\
                                'password' : PricesPaidAPIPassword,\
                                'p3ids' : pickle.dumps(p3ids)
                }

    r = requests.post(URLToPPSearchApiSolr+"/fromIds", data=payload, \
                          auth=(PricesPaidAPIBasicAuthUsername, PricesPaidAPIBasicAuthPassword), verify=False)

    LogActivity.logDebugInfo("Got Past Post to :"+URLToPPSearchApiSolr)

    content = r.text

    d = ast.literal_eval(content)
    html = ""
    for key, vdict in d.iteritems():
# Turn this into a function!
        html = html + produceHTML(vdict)
    # Actually, here we need to loop over a template, but I will try this first!
    return html

def produceHTML(valuesdict):
    html = ""
    html = html + "<h2>"+valuesdict["productDescription"]+"</h1>"
    html = html + "<h3>"+valuesdict["longDescription"]+"</h2>"
    html = html + "<p>"+valuesdict["unitPrice"]+"</p>"
    html = html + "<p>"+valuesdict["unitsOrdered"]+"</p>"
    html = html + "<p>"+valuesdict["vendor"]+"</p>"
    for k,v in valuesdict.iteritems():
        html = html + "<p>"+k + ":" + str(v) + "</p>" + "\n"
    html = html + "<p></p>" + "\n"
    return html

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

# This file is a directoy copy fromt he MorrisData Decorator.  It 
# out to be possible to avoid this duplication, but I don't really 
# know how to do that in Python.  I will have to spend the next day 
# in refactoring.

# BEGIN SERVER-SIDE CALLS TO MORRIS PORTFOLIO API
@app.route('/portfolio', method='GET')
def get_portfolios():
    LogActivity.logDebugInfo("Begin Create Portfolios")
    r = requests.get(URL_TO_MORRIS_PORTFOLIOS_API+"/decoration")
    d = ast.literal_eval(r.text)
    return d

@app.route('/portfolio/<name>', method='GET')
def get_specific_tags(name):
    r = requests.get(URL_TO_MORRIS_PORTFOLIOS_API+"/content/"+name)
    return r.text

@app.route('/portfolio/<name>', method='POST')
def get_create_portfolio(name):
    r = requests.post(URL_TO_MORRIS_PORTFOLIOS_API+"/decoration/"+name)
    return r.text

@app.route('/portfolio_export', method='GET')
def get_export_portfolio():
    r = requests.get(URL_TO_MORRIS_PORTFOLIOS_API+"/decoration_export")
    return r.text

@app.route('/portfolio_records', method='GET')
def get_records():
    r = requests.get(URL_TO_MORRIS_PORTFOLIOS_API+"/decoration_records")
    return r.text

@app.route('/portfolio_records_with_cd/<columns>', method='GET')
def get_records(columns):
    r = requests.get(URL_TO_MORRIS_PORTFOLIOS_API+"/content_records_with_client_data/"+columns)
    return r.text

@app.route('/portfolio/add_record/<portfolio>/<key>',method='POST')
def add_record_to_portfolio(key,portfolio):
    r = requests.post(URL_TO_MORRIS_PORTFOLIOS_API+"/decoration/add_record/"+portfolio+"/"+key)
    return r.text
# End Portfolio work

# Begin Tag work
@app.route('/tag', method='GET')
def get_tags():
    r = requests.get(URL_TO_MORRIS_TAGS_API+"/decoration")
    d = ast.literal_eval(r.text)
    return d

@app.route('/tag/<name>', method='GET')
def get_specific_tags(name):
    r = requests.get(URL_TO_MORRIS_TAGS_API+"/content/"+name)
    return r.text

@app.route('/tag/<name>', method='POST')
def get_create_tag(name):
    r = requests.post(URL_TO_MORRIS_TAGS_API+"/decoration/"+name)
    return r.text

@app.route('/tag_export', method='GET')
def get_export_tag():
    r = requests.get(URL_TO_MORRIS_TAGS_API+"/decoration_export")
    return r.text

@app.route('/tag_records', method='GET')
def get_records():
    r = requests.get(URL_TO_MORRIS_TAGS_API+"/decoration_records")
    return r.text

@app.route('/tag_records_with_cd/<columns>', method='GET')
def get_records(columns):
    r = requests.get(URL_TO_MORRIS_TAGS_API+"/decoration_records_with_client_data/"+columns)
    return r.text

@app.route('/tag/add_record/<tag>/<key>',method='POST')
def add_record_to_tag(tag,key):
    r = requests.post(URL_TO_MORRIS_TAGS_API+"/decoration/add_record/"+tag+"/"+key)
    return r.text
