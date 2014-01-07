# These configuration are necessary if you are using Bottle as your webserver
BottlePortNumber = 8080
BottleHostname = 'localhost'
PathToDataFiles = "../cookedData"
# URLToPPSearchApi = "https://shdsapi.org/api"
# URLToPPSearchApiSolr = "https://localhost/apisolr"
URLToPPSearchApiSolr = "http://127.0.0.1/apisolr"
URLToSolr = 'http://localhost:8983/solr'
# WsgiAbsolutePath = '/Users/RobertRead/PricesPaid/PricesPaidGUI'

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


P3APISALT = "crippledmule"
PricesPaidAPIUsername = 'p3tester1'
PricesPaidAPIPassword = '***REMOVED***'
PricesPaidAPIBasicAuthUsername = 'pricespaid'
PricesPaidAPIBasicAuthPassword = '***REMOVED***'

GITHUB_APPLICATION__PUBLIC_KEY = 'R8uvWsUFvbGR6dKowJMHo4ozcnM'

# it would be better to use boolean, but these are interpreted
# directly in templates, and so it easier to use strings
GITHUB_DISPLAY_VALUE = 'F'
MYUSA_DISPLAY_VALUE = 'F'
MAX_DISPLAY_VALUE = 'F'
