PricesPaidGUI
=============

# DESCRIPTION

PricesPaidGUI, in conjunction with its sister project also available at github, PricesPaidAPI,
is a system to allow government buyers to research actual prices paid in order to lower the 
price the Federal Government pays for goods and services. It was initiated by a team of 
Presidentail Innovation Fellows (Round 2), consisting of Robert L. Read, Martin Ringlein, 
Gregory Godbout, and Aaron Snow.

THE SHAPE OF THE CODE

This project is a website with just a few pages that uses the sister project PricesPaidAPI
to search a database of transactions of actual prices paid.  Most of the code is messy
javascript to present a page that renders transactions in three forms: graphically, as a 
list of visual paragraphs not unlike Amazon, and as a grid. The purpose is to allow government
buyers to get the best possible prices by being armed with good market research.


STATUS

This code was initially checked in on August 25th, and is quite rough and hard to install.
The dependencies are not clear yet and there are no installation instructions.

BASIC PRINCIPLES

This is really a visualization tool for .csv files.  However, right now, it is tied specifically
to the idea of "Prices Paid" for the government and it is logoed for that.  We hope to evenutally 
separate that out, not only so that the code will become more valuable to the open-source community,
but also because even within government we have need of separating out the specific style and fields.

The code at present calls the PricesPaidAPI to search a SOLR database with what we hope will be a 
"google like" search.  The results are then presented to the user to be visualized and understood.
We are aiming for transparency and relying on the intelligence of contracting officers to deal 
with the fact that the data returned is likely highly imperfect.

HOW YOU CAN HELP

We need help with this, even though it is premature to ask for it, because the code is so rough. 
Here is a preliminary TODO list:

* ) Factor out the PricesPaid specific GUI elements and fields in order to make the project both  
cleaner and potentially applicable to other forms of data.
* ) Clean up my not very good javascript, primarily by factoring it into separate files that can be loaded.
* ) Help make the GUI much better than it is today.  We are activley working on this, so there is
of course the danger of some duplication of effort---but so be it.
* ) help us implement "portfolios" of selected transactions.
* ) We need an export mechanism of portfolios (or the page) into Word, Excel, and PDF.

Our goal is to save the government a lot of money in 2014.  Although ambitious, if we need 
only make government buyers a few perecentage points more efficient to accomplish this.
Your help may make all the difference in the world---and may easily exceed our own efforts.

Please direct questions to Robert L. Read at <read.robert@gmail.com>.

INSTALLATION

Thanks to John Hardy for attempting to work through some of this.  

These instructions are probably insufficient for a clean install right now.  I will improve them as soon as I can.

The PricesPaidGUI project is separated from its sister, PricesPaidAPI, to keep a nice clean distinction between the GUI and Middle (Business Logic) Layer.  In practice, a user probably wants to install the PricesPaidAPI first. Additionally, it is dependent on a third project of mine, the MorrisDataDecorator.

I've been told I should be able to get all of this working with PyPi, but until I do, here is an attempt at installation instructions.

You will need to have installed:
*) Python
*) easy_install
*) bottle
*) requests
*) SOLR
*) solrpy-0.9.5

I use Apache, mod_wsgi, and mod_ssl, but technically those things are not necessary.  Bottle can cat as a webserver quite nicely for a demonstration project.

You will also need some data.  I have provided an example data file in the "cookedData" directory in PricesPaidAPI, but it only contains a few transactions and is not interesting.  I am working with the government to get a proper file released, but have so far not been able to get around security and privacy concerns.  However, there is a documented process for building an adapter to your own Prices Paid data file which you can follow.

Although in general configuration files allow flexibility in how to organize the system, I'm currently using a single directory for the install of the MorrisDataDecorator, the PricesPaidAPI, and the PricesPaidGUI.

Here are some recommended steps:

*) Install the MorrisDataDecorator following the instructions found there.  This project has automated unit tests. It implements a website, which you might wish to briefly bring up in bottle to be assured that it works, but really we are using it of the API definition and some back-end implementation.
*) Create a "logs" directory parallel to MorrisDataDecorator, PricesPaidAPI, and PricesPaidGUI.
*) Install the PricesPaidAPI following the instructions found there.
*) Install the PricesPaidGUI following the instructions found here.
*) Copy the the file in PricesPaidGUI/docs/Example.ppGuiConfig.py into PricesPaidGUI/ppGuiConfig.py and edit it appropriately.
*) Copy the file morris_config.py into 
*) create your own "cookedData" directory with my example or your own.
*) Carefully adjust ppGuiConfig.py to match your installation instructions.
*) Install SOLR.
*) In the PricesPaidAPI directory, execute "python SolrLodr.py" to load the data in your cookedData directory into SOLR.  Use the Solr administrative interface to make sure the documents are correctly inject.  SolrLodr produces a log file of errors.
*) Start up Apache (or bottle) and try to get it working.

