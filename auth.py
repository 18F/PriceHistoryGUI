# This file is responsible for checking secure hashes
# against configured user/password sistuations.
import os
import random,string
import datetime

import pickle
import hashlib
from ppGuiConfig import RelativePathToHashesFile,P3APISALT,TokenTimeout

# Load from disk
def loadHashes():
    hshs_file = RelativePathToHashesFile
    if os.path.exists(hshs_file):
        pwds = pickle.load(open(hshs_file, "rb"))
    else:
        pwds = {}
    return pwds

def does_authenticate(username,password):
    pwds = loadHashes()
    print len(pwds)
    # Check password
    # Likely need to catch an exception here
    if pwds[username] == hashlib.sha256(password+P3APISALT).hexdigest():
        print "Good"
        return True;
    else:
        print "No match"
        # here we should log the failure.
        return False;

GLOBAL_SESSION_DICT = {}

def create_session_id():
    session_id = get_rand_string(13);
    acsrf = get_rand_string(13);
    timestamp = datetime.datetime.now();
    GLOBAL_SESSION_DICT[session_id] = [acsrf,timestamp]
    print "Length: "+str(len(GLOBAL_SESSION_DICT))
    print "value "+repr(GLOBAL_SESSION_DICT[session_id])
    return session_id;

def update_acsrf(session_id):
    acsrf = get_rand_string(13);
    timestamp = datetime.datetime.now();
    GLOBAL_SESSION_DICT[session_id] = [acsrf,timestamp]
    return session_id;
    
    
CHARS = string.ascii_letters + string.digits
def get_rand_string(length):
    return ''.join(random.choice(CHARS) for i in range(length))

def is_valid_acsrf(session_id):
    if (session_id in GLOBAL_SESSION_DICT):
        timestamp = GLOBAL_SESSION_DICT[session_id][1]
        timenow = datetime.datetime.now()
        timedelta = timenow - timestamp
        print timedelta
        if (timedelta < datetime.timedelta(seconds=TokenTimeout)):
            return True
        else:
            print "Ran out of time!"
            return False
    else:
        return False;
        

def get_acsrf(session_id):
    timestamp = GLOBAL_SESSION_DICT[session_id][1]
    return GLOBAL_SESSION_DICT[session_id][0]
    
