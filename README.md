PricesPaidGUI
=============

DESCRIPTION

PricesPaidGUI, in conjunction with its sister project also available at githup, PricesPaidAPI,
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

We need help with tis, even though it is premature to ask for it, because the code is so rough. 
Here is a preliminary TODO list:

*) Factor out the PricesPaid specific GUI elements and fields in order to make the project both
cleaner and potentially applicable to other forms of data.
*) Clean up my not very good javascript, primarily by factoring it spearate files that can be loaded.
*) Help make the GUI much better than it is today.  We are activley working on this, so there is
of course the danger of some duplication of effort---but so be it.
*) help us implement "portfolios" of selected transactions.
*) We need an export mechanism of portfolios (or the page) into Word, Excel, and PDF.

Our goal is to save the government $1,000,000,000 in 2014.  Although ambitious, if we need 
only make government buyers a few perecentage points more efficient to accomplish this.
Your help may make all the difference in the world---and may easily exceed our own efforts.

Please direct questions to Robert L. Read at <read.robert@gmail.com>.