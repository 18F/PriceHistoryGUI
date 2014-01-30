# These configuration are necessary if you are using Bottle as your webserver
BottlePortNumber = 8080
BottleHostname = 'localhost'
PathToDataFiles = "../cookedData"
# URLToPPSearchApi = "https://shdsapi.org/api"
URLToPPSearchApiSolr = "https://localhost/apisolr"
URLToSolr = 'http://localhost:8983/solr'
WsgiAbsolutePath = '/home/robert/PricesPaid/PricesPaidGUI'

LocalURLToRecordFeedback = '/gui/record_feedback'

# If you want google analytics, put it here, if not, use an empty script
GoogleAnalyticsInclusionScript = """   <script>
   </script>"""

RelativePathToHashesFile = "../configuration/p3api.hashes.txt"

# I'm going to use a 10-minute timeout
TokenTimeout = 600

LIMIT_NUMBER_BAD_LOGINS = 5

# We'll make them wait one hour if they have 5 bad logins.
LIMIT_TIME_TO_RETRY = 60*60


P3APISALT = "defaultSalt"
PricesPaidAPIUsername = 'defaultUser'
PricesPaidAPIPassword = 'defaultPassword'
PricesPaidAPIBasicAuthUsername = 'defaultBasicAuthUser'
PricesPaidAPIBasicAuthPassword = 'defaultBasicAuthPassword'
