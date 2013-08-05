from bottle import Bottle, run, template,request,TEMPLATE_PATH,static_file,HeaderDict,BaseResponse

# from SearchApi import searchApi
import urllib
import ast
 
from ppconfig import MasterPassword,MasterUsername,URLToPPSearchApi

# Hopefully this will work!
PathToBottleWebApp = "./"
PathToExternalFiles = "../"


PathToJSFiles=PathToExternalFiles+"js/"
PathToCSSFiles=PathToExternalFiles+"css/"
PathToJSPlugins=PathToJSFiles + "plugins/"
PathToSlickGridMaster=PathToExternalFiles+"/SlickGrid-master/"

app = Bottle()

# Bottle seems to be fairly restrictive with static files,
# there might be a better way to do this.
@app.route('/js/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToJSFiles)

@app.route('/theme/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToBottleWebApp+"theme/")

@app.route('/theme/css/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToBottleWebApp+"theme/css/")

@app.route('/theme/img/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToBottleWebApp+"theme/img/")

@app.route('/css/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToCSSFiles)

@app.route('/js/plugins/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToJSFiles + "plugins/")

@app.route('/SlickGrid-master/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToSlickGridMaster)

@app.route('/SlickGrid-master/css/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToSlickGridMaster+"css/")

@app.route('/SlickGrid-master/images/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToSlickGridMaster+"images/")

@app.route('/SlickGrid-master/css/smoothness/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToSlickGridMaster+"css/smoothness/")

@app.route('/SlickGrid-master/css/smoothness/images/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToSlickGridMaster+"css/smoothness/images")

@app.route('/SlickGrid-master/lib/<filename>')
def server_static(filename):
    return static_file(filename, root=PathToSlickGridMaster+"lib/")

# this needs to move to config!
def does_authenticate(user,password):
    return (user == MasterUsername and password == MasterPassword)


from bottle import template

@app.route('/')
def login():
    return template('Login')

@app.route('/PricesPaid',method='POST')
def pptriv():
    user = request.forms.get('user')
    password = request.forms.get('password')
    if (not does_authenticate(user,password)):
        return template('BadAuthentication')
    search_string = request.forms.get('search_string')
    search_string = search_string if search_string is not None else "Dell Latitude"
    psc_pattern = request.forms.get('psc_pattern')
    return template('MainPage',search_string=search_string,user=user,\
                    password=password,psc_pattern=psc_pattern)
                    
# This appears to be necessary in order to support the same-origin policy.
# To separate this better, we serve-side pass-through to a different domain
# and then server it here.
@app.route('/api',method='POST')
def pptriv():
    user = request.forms.get('user')
    password = request.forms.get('password')
    if (not does_authenticate(user,password)):
        return template('BadAuthentication')        
    search_string = request.forms.get('search_string')
    psc_pattern = request.forms.get('psc_pattern')
    print "API search_string" + search_string
    # I'm doing this as a call to keep the API separated as
    # completely from the GUI as possible.
    params = urllib.urlencode({'user': user, 'password': password,\
                               'search_string': search_string,
                               'psc_pattern': psc_pattern})
    f = urllib.urlopen(URLToPPSearchApi, params)
    content = f.read()
    # This is inefficient, but I can't seem to get Bottle to
    # let me procue a correct JSON response with out using a dictionary.
    # I tried using BaseResponse.  This could be my weakness
    # with Pyton or confusion in Bottle.
    d = ast.literal_eval(content)
    return d



