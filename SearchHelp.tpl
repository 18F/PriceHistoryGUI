<!DOCTYPE html> 
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
       <title>Prices Paid v. 0.5 BETA - Legal Notice</title>
       <meta name="robots" content="NOINDEX, NOFOLLOW">
    {{!goog_anal_script}}
    </head>
    <body>

<h2 class="boxed">Portfolios of Transactions</h2>
<div class="section">
<p>
Portfolios are shared among all users.  Anyone can create a new Portfolio. Transactions are added to a Portfolio by dragging the portfolio onto the Transaction. A drag is performed by clicking and holding down the mouse button, and the drop is performed by releasing the mouse button while the pointer is on the Transaction.  </p>
<p>
By clicking on the name of a portfolio, the prices researcher will be taken to a separate page which shows only the transaction which are in the portfolio.  From this page, the Portfolio can be exported in the form of very simple HTML which can be easily imported into a word processor, such as Microsoft Word (R).
</p>
<p>
A portfolio can be removed by clicking on the "x" at the right of the portfolio name.
</p>
</div>

<h3>
This text is a modification of the <a href="http://lucene.apache.org/core/4_1_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html">Lucene documentation</a> from the open-source Apache project, to which the Price Paid Portal is highly indebted.
</h3>

<a name="N10032"></a><a name="Terms"></a>
<h2 class="boxed">Terms</h2>
<div class="section">
<p>A query is broken up into terms and operators. There are two types of terms: Single Terms and Phrases.</p>
<p>A Single Term is a single word such as "test" or "hello".</p>
<p>A Phrase is a group of words surrounded by double quotes such as "hello dolly".</p>
<p>Multiple terms can be combined together with Boolean operators to form a more complex query (see below).</p>
<p>Note: The analyzer used to create the index will be used on the terms and phrases in the query string.
        So it is important to choose an analyzer that will not interfere with the terms used in the query string.</p>
</div>

        
<a name="N1006D"></a><a name="Term_Modifiers"></a>
<h2 class="boxed">Term Modifiers</h2>
<div class="section">
<p>Lucene supports modifying query terms to provide a wide range of searching options.</p>
<a name="N10076"></a><a name="Wildcard_Searches"></a>
<h3 class="boxed">Wildcard Searches</h3>
<p>Lucene supports single and multiple character wildcard searches within single terms
        (not within phrase queries).</p>
<p>To perform a single character wildcard search use the "?" symbol.</p>
<p>To perform a multiple character wildcard search use the "*" symbol.</p>
<p>The single character wildcard search looks for terms that match that with the single character replaced. For example, to search for "text" or "test" you can use the search:</p>
<pre class="code">te?t</pre>
<p>Multiple character wildcard searches looks for 0 or more characters. For example, to search for test, tests or tester, you can use the search: </p>
<pre class="code">test*</pre>
<p>You can also use the wildcard searches in the middle of a term.</p>
<pre class="code">te*t</pre>
<p>Note: You cannot use a * or ? symbol as the first character of a search.</p>
<a name="Regexp_Searches"></a>
<h3 class="boxed">Regular Expression Searches</h3>
<p>Lucene supports regular expression searches matching a pattern between forward slashes "/". The syntax may change across releases, but the current supported
syntax is documented in the <a href="../../../../../../core/org/apache/lucene/util/automaton/RegExp.html?is-external=true" title="class or interface in org.apache.lucene.util.automaton"><code>RegExp</code></a> class. For example to find documents containing "moat" or "boat":
</p>
<pre class="code">/[mb]oat/</pre>
<a name="N1009B"></a><a name="Fuzzy_Searches"></a>
<h3 class="boxed">Fuzzy Searches</h3>
<p>Lucene supports fuzzy searches based on Damerau-Levenshtein Distance. To do a fuzzy search use the tilde, "~", symbol at the end of a Single word Term. For example to search for a term similar in spelling to "roam" use the fuzzy search: </p>
<pre class="code">roam~</pre>
<p>This search will find terms like foam and roams.</p>
<p>An additional (optional) parameter can specify the maximum number of edits allowed. The value is between 0 and 2, For example:</p>
<pre class="code">roam~1</pre>
<p>The default that is used if the parameter is not given is 2 edit distances.</p>
<p>Previously, a floating point value was allowed here. This syntax is considered deprecated and will be removed in Lucene 5.0</p>
<a name="N100B4"></a><a name="Proximity_Searches"></a>
<h3 class="boxed">Proximity Searches</h3>
<p>Lucene supports finding words are a within a specific distance away. To do a proximity search use the tilde, "~", symbol at the end of a Phrase. For example to search for a "apache" and "jakarta" within 10 words of each other in a document use the search: </p>
<pre class="code">"jakarta apache"~10</pre>
<h3 class="boxed">Boosting a Term</h3>
<p>Lucene provides the relevance level of matching documents based on the terms found. To boost a term use the caret, "^", symbol with a boost factor (a number) at the end of the term you are searching. The higher the boost factor, the more relevant the term will be.</p>
<p>Boosting allows you to control the relevance of a document by boosting its term. For example, if you are searching for</p>
<pre class="code">jakarta apache</pre>
<p>and you want the term "jakarta" to be more relevant boost it using the ^ symbol along with the boost factor next to the term.
        You would type:</p>
<pre class="code">jakarta^4 apache</pre>
<p>This will make documents with the term jakarta appear more relevant. You can also boost Phrase Terms as in the example: </p>
<pre class="code">"jakarta apache"^4 "Apache Lucene"</pre>
<p>By default, the boost factor is 1. Although the boost factor must be positive, it can be less than 1 (e.g. 0.2)</p>
</div>


        
<a name="N100FA"></a><a name="Boolean_operators"></a>
<h2 class="boxed">Boolean Operators</h2>
<div class="section">
<h3>
Note: Searches may not begin with a "+" or "-".  This is a bug in Prices Paid.
</h3>
<p>Boolean operators allow terms to be combined through logic operators.
        Lucene supports AND, "+", OR, NOT and "-" as Boolean operators(Note: Boolean operators must be ALL CAPS).</p>
<a name="N10103"></a><a name="OR"></a>
<h3 class="boxed">OR</h3>
<p>The OR operator is the default conjunction operator. This means that if there is no Boolean operator between two terms, the OR operator is used.
        The OR operator links two terms and finds a matching document if either of the terms exist in a document. This is equivalent to a union using sets.
        The symbol || can be used in place of the word OR.</p>
<p>To search for documents that contain either "jakarta apache" or just "jakarta" use the query:</p>
<pre class="code">"jakarta apache" jakarta</pre>
<p>or</p>
<pre class="code">"jakarta apache" OR jakarta</pre>
<a name="N10116"></a><a name="AND"></a>
<h3 class="boxed">AND</h3>
<p>The AND operator matches documents where both terms exist anywhere in the text of a single document.
        This is equivalent to an intersection using sets. The symbol &amp;&amp; can be used in place of the word AND.</p>
<p>To search for documents that contain "jakarta apache" and "Apache Lucene" use the query: </p>
<pre class="code">"jakarta apache" AND "Apache Lucene"</pre>
<a name="N10126"></a><a name="+"></a>
<h3 class="boxed">+</h3>
<p>The "+" or required operator requires that the term after the "+" symbol exist somewhere in a the field of a single document.</p>
<p>To search for documents that must contain "jakarta" and may contain "lucene" use the query:</p>
<pre class="code">+jakarta lucene</pre>
<a name="N10136"></a><a name="NOT"></a>
<h3 class="boxed">NOT</h3>
<p>The NOT operator excludes documents that contain the term after NOT.
        This is equivalent to a difference using sets. The symbol ! can be used in place of the word NOT.</p>
<p>To search for documents that contain "jakarta apache" but not "Apache Lucene" use the query: </p>
<pre class="code">"jakarta apache" NOT "Apache Lucene"</pre>
<p>Note: The NOT operator cannot be used with just one term. For example, the following search will return no results:</p>
<pre class="code">NOT "jakarta apache"</pre>
<a name="N1014C"></a><a name="-"></a>
<h3 class="boxed">-</h3>
<p>The "-" or prohibit operator excludes documents that contain the term after the "-" symbol.</p>
<p>To search for documents that contain "jakarta apache" but not "Apache Lucene" use the query: </p>
<pre class="code">"jakarta apache" -"Apache Lucene"</pre>
</div>

        
<a name="N1015D"></a><a name="Grouping"></a>
<h2 class="boxed">Grouping</h2>
<div class="section">
<p>Lucene supports using parentheses to group clauses to form sub queries. This can be very useful if you want to control the boolean logic for a query.</p>
<p>To search for either "jakarta" or "apache" and "website" use the query:</p>
<pre class="code">(jakarta OR apache) AND website</pre>
<p>This eliminates any confusion and makes sure you that website must exist and either term jakarta or apache may exist.</p>
</div>

        
<a name="N10170"></a><a name="Field_Grouping"></a>
<h2 class="boxed">Field Grouping</h2>
<div class="section">
<p>Lucene supports using parentheses to group multiple clauses to a single field.</p>
<p>To search for a result that contains both the word "return" and the phrase "pink panther" use the query:</p>
<pre class="code">(+return +"pink panther")</pre>
</div>

        
<a name="N10180"></a><a name="Escaping_Special_Characters"></a>
<h2 class="boxed">Escaping Special Characters</h2>
<div class="section">
<p>Lucene supports escaping special characters that are part of the query syntax. The current list special characters are</p>
<p>+ - &amp;&amp; || ! ( ) { } [ ] ^ " ~ * ? : \ /</p>
<p>To escape these character use the \ before the character. For example to search for (1+1):2 use the query:</p>
<pre class="code">\(1\+1\)\:2</pre>
</div>
</body>
</html>
