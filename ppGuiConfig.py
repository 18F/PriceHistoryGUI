# These configuration are necessary if you are using Bottle as your webserver
BottlePortNumber = 8080
BottleHostname = 'localhost'
PathToDataFiles = "../cookedData"
URLToPPSearchApiSolr = "http://127.0.0.1/apisolr"
URLToSolr = 'http://localhost:8983/solr'

LocalURLToRecordFeedback = '/gui/record_feedback'

# If you want google analytics, put it here, if not, use an empty script
GoogleAnalyticsInclusionScript = """   <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-43185448-4', 'ec2-54-213-123-158.us-west-2.compute.amazonaws.com');
  ga('send', 'pageview');

   </script>"""

RelativePathToHashesFile = "../configuration/p3api.hashes.txt"

# I'm going to use a 10-minute timeout
TokenTimeout = 600*2

LIMIT_NUMBER_BAD_LOGINS = 5

# We'll make them wait one hour if they have 5 bad logins.
LIMIT_TIME_TO_RETRY = 60*60

GITHUB_APPLICATION__PUBLIC_KEY = 'R8uvWsUFvbGR6dKowJMHo4ozcnM'

# it would be better to use boolean, but these are interpreted 
# directly in templates, and so it easier to use strings
GITHUB_DISPLAY_VALUE = 'F'
MYUSA_DISPLAY_VALUE = 'F'
MAX_DISPLAY_VALUE = 'F'
BASIC_DISPLAY_VALUE = 'T'

CAS_SERVER = 'http://127.0.0.1:8099'

# This should be in the form of a python "requests" proxies dictionary
# CAS_SERVER_PROXY =  {
#  "http": "http://10.10.1.10:3128",
#   "https": "http://10.10.1.10:1080",
# }

CAS_PROXY =  {
}


CAS_RETURN_SERVICE_URL = 'http://127.0.0.1/gui/ReturnLoginViaMax'

CAS_LEVEL_OF_ASSURANCE = "assurancelevel3"
CAS_LEVEL_OF_ASSURANCE_PREDICATE_LOA3 = lambda loa,piv: {
    ("http://idmanagement.gov/icam/2009/12/saml_2.0_profile/assurancelevel3" == loa)
}
CAS_LEVEL_OF_ASSURANCE_PREDICATE_LOA2 = lambda loa,piv: {
    ("http://idmanagement.gov/icam/2009/12/saml_2.0_profile/assurancelevel2" == loa)
    or 
    ("http://idmanagement.gov/icam/2009/12/saml_2.0_profile/assurancelevel3" == loa)

}

CAS_LEVEL_OF_ASSURANCE_PREDICATE_LOA2_AND_PIV = lambda loa,piv: {
    (("http://idmanagement.gov/icam/2009/12/saml_2.0_profile/assurancelevel2" == loa)
    or
    ("http://idmanagement.gov/icam/2009/12/saml_2.0_profile/assurancelevel3" == loa))
    and
    ("urn:max:fips-201-pivcard" == piv)

}
CAS_PIV_CARD = lambda loa,piv: {
   ("urn:max:fips-201-pivcard" == piv)
}
CAS_PASSWORD_OR_PIV = lambda loa, piv: {
   ("urn:max:fips-201-pivcard" == piv)
   or
   ("urn:oasis:names:tc:SAML:1.0:am:password" == piv)
}
CAS_LEVEL_3 = lambda loa, piv: {
   ("urn:max:am:secureplus:federated-saml2:assurancelevel3" == piv)
}
CAS_LEVEL_OF_ASSURANCE_PREDICATE = CAS_PASSWORD_OR_PIV
