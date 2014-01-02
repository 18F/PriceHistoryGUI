# This file is responsible for checking secure hashes
# against configured user/password sistuations.
import os
import random,string
import datetime
import LogActivity

import pickle
import hashlib
from ppGuiConfig import RelativePathToHashesFile,P3APISALT,TokenTimeout

hashes = {}

GLOBAL_BAD_LOGIN = {}
LIMIT_NUMBER_BAD_LOGINS = 5
# We'll make them wait one hour if they have 5 bad logins.
LIMIT_TIME_TO_RETRY = 60*60

# Load from disk
def loadHashes():
    hshs_file = RelativePathToHashesFile
    if os.path.exists(hshs_file):
        hashes = pickle.load(open(hshs_file, "rb"))
    else:
        hashes = {}
    return hashes

def record_bad_login(username):
    if username not in GLOBAL_BAD_LOGIN:
        GLOBAL_BAD_LOGIN[username] = [0,datetime.datetime.now()]
    else:
        GLOBAL_BAD_LOGIN[username][0] = GLOBAL_BAD_LOGIN[username][0]+1
        GLOBAL_BAD_LOGIN[username][1] = datetime.datetime.now()

def does_authenticate(username,password):
    hashes = loadHashes()
    if username in GLOBAL_BAD_LOGIN:
        timenow = datetime.datetime.now()
        timestamp = GLOBAL_BAD_LOGIN[username][1]
        timedelta = timenow - timestamp
        if (timedelta >=  datetime.timedelta(seconds=LIMIT_TIME_TO_RETRY)):
            # An hour has gone by, so we givem them a pass....
            GLOBAL_BAD_LOGIN.pop(username, None)

    if username in GLOBAL_BAD_LOGIN:
        count = GLOBAL_BAD_LOGIN[username][0]
        if (count >= LIMIT_NUMBER_BAD_LOGINS):
            # Probably should have a separate log message for this..
            LogActivity.logTooManyLoginAttempts(username)
            return False;
            
    if username not in hashes:
        LogActivity.logBadCredentials(username)
        record_bad_login(username)
        return False;
    if hashes[username] == hashlib.sha256(password+P3APISALT).hexdigest():
        return True;
    else:
        LogActivity.logBadCredentials(username)
        record_bad_login(username)
        return False;

GLOBAL_SESSION_DICT = {}

def create_session_id():
    session_id = get_rand_string(13);
    acsrf = get_rand_string(13);
    timestamp = datetime.datetime.now();
    GLOBAL_SESSION_DICT[session_id] = [acsrf,timestamp]
    return session_id;

def update_acsrf_nonce_form(session_id):
    acsrf = get_rand_string(13);
    return update_new_acsrf(session_id,acsrf)

def update_acsrf(session_id):
    acsrf = GLOBAL_SESSION_DICT[session_id][0];
    return update_new_acsrf(session_id,acsrf)

def update_new_acsrf(session_id,acsrf):
    timestamp = datetime.datetime.now();
    GLOBAL_SESSION_DICT[session_id] = [acsrf,timestamp]
    LogActivity.logDebugInfo("SETTING ACSRF session, acsrf "+session_id+"."+GLOBAL_SESSION_DICT[session_id][0])
    return session_id;
    
    
CHARS = string.ascii_letters + string.digits
def get_rand_string(length):
    return ''.join(random.choice(CHARS) for i in range(length))

def is_valid_acsrf_old(session_id):
    if (session_id in GLOBAL_SESSION_DICT):
        timestamp = GLOBAL_SESSION_DICT[session_id][1]
        timenow = datetime.datetime.now()
        timedelta = timenow - timestamp
        if (timedelta < datetime.timedelta(seconds=TokenTimeout)):
            return True
        else:
            LogActivity.logTimeout(session_id)
            return False
    else:
        LogActivity.logMissingSession(session_id)
        return False;

def is_valid_acsrf(session_id,acsrf):
    if (session_id in GLOBAL_SESSION_DICT):
        timestamp = GLOBAL_SESSION_DICT[session_id][1]
        timenow = datetime.datetime.now()
        timedelta = timenow - timestamp
        if (timedelta < datetime.timedelta(seconds=TokenTimeout)):
            if (acsrf != GLOBAL_SESSION_DICT[session_id][0]):
                LogActivity.logDebugInfo("ACSRF Mismatch provided vs. stored :"+acsrf+","+GLOBAL_SESSION_DICT[session_id][0])
                return False
            else:
                return True
        else:
            LogActivity.logTimeout(session_id)
            return False
    else:
        LogActivity.logMissingSession(session_id)
        return False;
        

def get_acsrf(session_id):
    return GLOBAL_SESSION_DICT[session_id][0]

def del_session(session_id):
    obj = (GLOBAL_SESSION_DICT.pop(session_id, None))
    if session_id in GLOBAL_SESSION_DICT:
        LogActivity.logMissingSession(str(session_id)+"failed to remove")
    else:
        LogActivity.logMissingSession(str(session_id)+"removed")


    
