PricesPaidGUI
=============

This is part of the PricesPaid (P3) Project
--------------------------------------

The PricesPaid (P3) project is market research tool to allow search of purchase transactions.  It is modularized into 4 github repositories:

1. [PricesPaidGUI](https://github.com/XGov/PricesPaidGUI), 
2. [PricesPaidAPI](https://github.com/presidential-innovation-fellows), 
3. [MorrisDataDecorator](https://github.com/presidential-innovation-fellows/MorrisDataDecorator), 
4. [P3Auth](https://github.com/XGov/P3Auth).  

To learn how to install the system, please refer to the documentation in the PricesPaidGUI project.

The name "PricesPaid" is descriptive: this project shows you prices that have been paid for things.  However, the name is applied to many projects, so "P3" is the specific name of this project.

# DESCRIPTION

PricesPaidGUI, in conjunction with its sister project also available at github, PricesPaidAPI,
is a system to allow government buyers to research actual prices paid in order to lower the 
price the Federal Government pays for goods and services. It was initiated by a team of 
Presidential Innovation Fellows (Round 2), consisting of Robert L. Read, Martin Ringlein, 
Gregory Godbout, and Aaron Snow. 

It is intended in part to address a mandate of Congress, Title 41 U.S. CODE § 3312 - 
DATABASE ON PRICE TRENDS OF ITEMS AND SERVICES UNDER FEDERAL CONTRACTS.

The main purpose of this code is for a buyer to perform market research of the specific transactions
that are related to what you are buying.  Individual transactions can be selected by "drag 'n drop" 
into portfolios which can then be exported to very simple HTML which can imported into a text editor
to document market research.

Within the Federal government, this software uses data which is consider sensitive and not 
available for public usage.  However, the code is in the public domain.

This code could be reused by a State or municipality that had transactional pricing data that 
it wanted to present in a searchable form.  It provides a very simple method (documented in PricesPaidAPI) for importing CSV
files in any format and mapping fields to standard, semi-standard and completely customized fields,
all of which are automatically searchable once they have been imported into SOLR.

# THE SHAPE OF THE CODE

This repo is a Python/Javascript/CSS front-end that ties together 3 other repos : https://github.com/presidential-innovation-fellows/PricesPaidAPI
and https://github.com/presidential-innovation-fellows/MorrisDataDecorator.git and https://github.com/XGov/P3Auth.
Fundamentally API is a a simple Python interface to the SOLR full-text search engine.  The MorrisDataDecorator is a system for
making assocations between records in SOLR.  In this case, it implements a "Portfolio" concept.  The PricesPaid system does not 
use a relational database, and has no notion of user identitiy---all portfolios are shared at present.

I've been told I should try to make this PIP installable, but I am too much of a python neophyte to really understand how to do that, so I have opened it as an issue.

At present, this is a WSGI app, and I have only run it with Apahce, although I'm sure some other webserver would work.

The Directory structure that I use is:

1. All for projects (PricesPaidGUI, PricesPaidAPI, MorrisDataDecorator, and P3Auth) are parallel beneath a single directory (In my case, PricesPaid.)
2. I have to add by hand an empty __init__.py file to that directory (parallel to the others.)

The PricesPaidGUI module use all of the other three.  PricesPaidAPI uses P3Auth, but does not rely on any of the others. One could easily use PricesPaidAPI only as a loading tool to load SOLR with data, and then use SOLR directly, or write your own GUI, for example in Ruby.


# BASIC PRINCIPLES

This is really a visualization tool for .csv files.  However, right now, it is tied specifically
to the idea of "Prices Paid" for the government and it is logoed for that.  We hope to evenutally 
separate that out, not only so that the code will become more valuable to the open-source community,
but also because even within government we have need of separating out the specific style and fields.

The code at present calls the PricesPaidAPI to search a SOLR database with what we hope will be a 
"google like" search.  The results are then presented to the user to be visualized and understood.
We are aiming for transparency and relying on the intelligence of contracting officers to deal 
with the fact that the data returned is likely highly imperfect.

# HOW YOU CAN HELP

We desperately need a data set which can be made publicly available in order to stand up a demo instance of this site.  If you have real, actual transactional data where some organization actual bought specific quantities of specific things at a specific date in time that you don't mind the whole world seeing, then please contact me: <read.robert@gmail.com> and I will owe you deep gratitude.

Secondarily, we would like coding and design volunteers, not so much because we need the labor, but because I want this to become a living project outside of the Federal government that the government can draw upon for code, inspiration, and know-how.

Here is a preliminary TODO list:

*  Factor out the PricesPaid specific GUI elements and fields in order to make the project both  
cleaner and potentially applicable to other forms of data.
*  Factor out the GSA branding so that a different entity could comfortably use this project for its own purposes.
*  Clean up my not very good javascript, primarily by factoring it into separate files that can be loaded.
*  Help make the GUI much better than it is today.  We are activley working on this, so there is
of course the danger of some duplication of effort---but so be it.
*  We need an export mechanism of portfolios (or the page) into Word, Excel, and PDF.  Today there is an export tool that products very simple HTML suitable to recording a portforlio for research purposes.  However, our uses have also asked for direct Excel and Word export.

Our goal is to save the government a lot of money in 2014.  Although ambitious, if we need 
only make government buyers a few perecentage points more efficient to accomplish this.
Your help may make all the difference in the world---and may easily exceed our own efforts.

Please direct questions to Robert L. Read at <read.robert@gmail.com>.

# INSTALLATION

Thanks to John Hardy for attempting to work through some of this.  

These instructions are probably insufficient for a clean install right now.  I will improve them as soon as I can.

The PricesPaidGUI project is separated from its sister, PricesPaidAPI, to keep a nice clean distinction between the GUI and Middle (Business Logic) Layer.  In practice, a user probably wants to install the PricesPaidAPI first. Additionally, it is dependent on a third project of mine, the MorrisDataDecorator.

I've been told I should be able to get all of this working with PyPi, but until I do, here is an attempt at installation instructions.

You will need to have installed:
* Python
* easy_install
* bottle
* requests
* SOLR
* solrpy-0.9.5 [Note: this does not insall with PIP.  I found "sudo python setup.py install" worked.]

I use Apache, mod_wsgi, and mod_ssl, but mod_ssl is optional.

You will also need some data.  I have provided an example data file in the "cookedData" directory in PricesPaidAPI, but it only contains a few transactions and is not interesting.  I am working with the government to get a proper file released, but have so far not been able to get around security and privacy concerns.  However, there is a documented process for building an adapter to your own Prices Paid data file which you can follow.

Additionally, this project takes advantage of the excellent javascript projects gifted to the world:
* jquery
* jquery-ui
* [jqplot](http://www.jqplot.com)
* [SlickGrid](https://github.com/mleibman/SlickGrid) (Huge thanks to Michael Leibman!)
* [feedback_me](https://github.com/vedmack/feedback_me) (Thanks, Daniel!)
* [jqPagination](https://github.com/beneverard/jqPagination) (Thanks, Ben Everard!)


Although in general configuration files allow flexibility in how to organize the system, I'm currently using a single directory for the install of the MorrisDataDecorator, the PricesPaidAPI, and the PricesPaidGUI.

Here are the recommended steps:

* Install the MorrisDataDecorator following the instructions found there.  This project has automated unit tests. It implements a website, which you might wish to briefly bring up in bottle to be assured that it works, but really we are using it of the API definition and some back-end implementation.
* Create a "logs" directory parallel to MorrisDataDecorator, PricesPaidAPI, and PricesPaidGUI.
* Create an empty __init__.py file parallel to MorrisDataDecorator, PricesPaidAPI, and PricesPaidGUI.
* Install the PricesPaidAPI following the instructions found there.
* Install the PricesPaidGUI following the instructions found here.
* Install P3Auth.
* Create a "configuration" directory parallel to P3Auth.
* In P3Auth, edit "AuthBuilder"  to set your own salt in P3APISALT. This will be a secret that you keep private and will also set in your apache environment variables.  Then edit this line : "        username = "changeme"+str(i) " in order to set your own username (possibly you will want to complete change this mechanism.)
Then execute authbuilder to generate randome passwords and the hashes for them in the configuration directory.  You will need to use at least one of these for accessing the API.
* Install the MorridDataDecorator in a directory parallel to PricesPaidGUI and PricesPaidAPI.
* Running the tests in the MorrisDataDecorator might be enlightening.
* Create a directory called "logs" parallel to all of those.
* In the logs directory, execute the "bash ../P3Auth/CreateLogFiles.bash"
* Create a directory called "js" which will be parallel to all of these
previous directories.  Configure Apache to allow files to be read from this directory freely---nothing secure will go here.
* In js, install jquery, jquery-ui, feedback-me, excanvas.js, jqplot, and jqPaginate.  These are all third-party projects that I have been unwilling to duplicate into these repositories.  I know this makes it very difficult to install---I am seeking a solution to this problem.
* Now, parallel to "js" install the project "SlickGrid-master" from SlickGrid.  Also make this freely readable by anone hitting your site.  The SlickGrid project is truly excellent.
* Copy the the file in PricesPaidGUI/docs/Example.ppGuiConfig.py into PricesPaidGUI/ppGuiConfig.py and edit it appropriately.
* Copy the file morris_config.py into 
* Create your own "cookedData" directory with my example or your own with your own adapter.  Before you create your own data, you may wish to use the file FY14TX-pppifver-USASpending-5-0-0-0-1.csv.  This file 
is simply a renamed (and unchanged) export from the site USASpending.gov, in this case for 
fiscal year 2014 and the state of Texas. You will find it in the PricesPaidAPI project in the example cookedData directory there.
* Carefully adjust ppGuiConfig.py to match your installation instructions.
* 
* Install SOLR.
* In the PricesPaidAPI directory, execute "python SolrLodr.py" to load the data in your cookedData directory into SOLR.  Use the Solr administrative interface to make sure the documents are correctly inject.  SolrLodr produces a log file of errors.
* Start up Apache and try to get it working.
** Start by using the exampe_apache.config in PricesPaidAPI/docs.  This is an example httpd.conf that should be really useful because it is based on real example.
** You will of course have to change many things in this file.  In particular note that the the python-path variable sent to WSGI is very important.
* Set Environment variables similar to the following, possible in the profile for the user that runs apache or in the apache httpd.conf:
** SetEnv P3APISALT CHANGEME (use the salt you used above!)
** SetEnv PricesPaidAPIUsername  CHANGEME (use a username/password generated with authbuilder.)
** SetEnv PricesPaidAPIPassword  CHANGEME (use a username/password generated with authbuilder.)
** SetEnv PYCAS_SECRET PutANiceLongSecretHere
* 
* In the MorrisDataDecorator, execute "run_all.bash" to start up Botlle processes listening on certain ports,
* Restart Apache and browse to the website.
* Use one of the username/password pairs generated by Authbuilder.py


At this point, probably after some configuration troubleshooting described below, you will have an empty site.  To load data into the site,  you need to load the SOLR index.  This requires three steps:

* Copying the exampe scehma.xml into the correct position, and 
* Creating a directory, by default called "cookedData" that is parallel to your other directoris, which contain comma-separated value files obeying the documented file naming convention, and 
* Execute in PricesPaidAPI "python SolrLodr.py", which inserts the transactions in the "cookedData" directory into the SOLR index.  It runs in chunks of a 1000 at a rate of about one million transactions per hour.

In PricesPaidAPI you will find a directory called "cookedData" which contains a file containing exactly 2 fake records.  We hope to get some better data soon, but that is enough for you to exercise the system.  This entire directory needs to be copied up to be parallel to PricesPaidGUI.

We use a fresh, out-of-the-box instal of SOLR.  In recent releases, the location of the schema.xml file is:

solr-4.4.0/solr/example/solr/collection1/conf/schema.xml

Copy the file "schema.xml.example" in PricesPaidAPI into this location and restart SOLR.

When you have done that and set up your cookedData directory, you are ready to execute "python SolrLodr.py".

# TROUBLESHOOTING

A lot can go wrong in the installation of P3.  The best thing to do is to email me (<read.robert@gmail.com>) immediately.  I will guide you through using the log files to figure out what is wrong.  There are three basic log files that will be invaluable to you:
* The apache error and access log files,
* The SOLR output logs, which you will be responsible for, depending on how you start solr (I just pipe the out put of "java -jar start.jar" into a known location and tail that), and
* The P3 application log file which is by default in the logs directory and named Activity.log.

Generally you will use those files in that order.

In practice to do some debugging I have had to:

* Replace app.wsgi with a "hello world" version,
* Print out enviornment variables in app.wsgi,
* Generally do all the things you have to do to get Apache to correctly render a wsgi app,
* Look for coding mistakes that show up in the Apache error log,
* Look for misconfiguration that show up in the Apache error log,
* Look at the SOLR log to tryin to understand what is going on,
* Use the Activity.log file, sometimes with additional debugging statements, to understand what is going wrong there, and 
* Use the "*.out" files in the MorrisDataDecorator directory on occation.





