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

We need help with this, even though it is premature to ask for it, because the code is so rough. 
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
* solrpy-0.9.5

I use Apache, mod_wsgi, and mod_ssl, but mod_ssl is optional.

You will also need some data.  I have provided an example data file in the "cookedData" directory in PricesPaidAPI, but it only contains a few transactions and is not interesting.  I am working with the government to get a proper file released, but have so far not been able to get around security and privacy concerns.  However, there is a documented process for building an adapter to your own Prices Paid data file which you can follow.

Although in general configuration files allow flexibility in how to organize the system, I'm currently using a single directory for the install of the MorrisDataDecorator, the PricesPaidAPI, and the PricesPaidGUI.

Here are some recommended steps:

* Install the MorrisDataDecorator following the instructions found there.  This project has automated unit tests. It implements a website, which you might wish to briefly bring up in bottle to be assured that it works, but really we are using it of the API definition and some back-end implementation.
* Create a "logs" directory parallel to MorrisDataDecorator, PricesPaidAPI, and PricesPaidGUI.
* Create an empty __init__.py file parallel to MorrisDataDecorator, PricesPaidAPI, and PricesPaidGUI.
* Install the PricesPaidAPI following the instructions found there.
* Install the PricesPaidGUI following the instructions found here.
* Copy the the file in PricesPaidGUI/docs/Example.ppGuiConfig.py into PricesPaidGUI/ppGuiConfig.py and edit it appropriately.
* Copy the file morris_config.py into 
* create your own "cookedData" directory with my example or your own.
* Carefully adjust ppGuiConfig.py to match your installation instructions.
* Install SOLR.
* In the PricesPaidAPI directory, execute "python SolrLodr.py" to load the data in your cookedData directory into SOLR.  Use the Solr administrative interface to make sure the documents are correctly inject.  SolrLodr produces a log file of errors.
* Start up Apache and try to get it working.

