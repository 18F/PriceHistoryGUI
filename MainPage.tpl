<!DOCTYPE html> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PricesPaid v. 0.4 BETA </title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">
    <link href="./theme/css/mainPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link rel="stylesheet" href="../SlickGrid-master/slick.grid.css" type="text/css">
<!--    <link rel="stylesheet" href="../SlickGrid-master/css/smoothness/jquery-ui-1.8.16.custom.css" type="text/css">
-->

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

    <link rel="stylesheet" type="text/css" href="../js/jquery.jqplot.css" >
    <link rel="stylesheet" type="text/css" href="../js/jqPagination-master/css/jqpagination.css"> 
    {{!goog_anal_script}}

</head>
<body>

<div id="sidebar">
<h2>Column 2</h2>
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit...</p>
<ul>
<li><a href="#">Link 1</a></li>
<li><a href="#">Link 2</a></li>
</ul>
</div>

    <!-- Start header -->
    <div id="header">
        <!-- Top part of header -->
        <div>
        <!-- FACTOR OUT -->
            <span id="pricespaid_logo"><img src="theme/img/pp_logo_beta.png" alt="PricesPaid"></span>
		<span id="comDropdownWrapper" title="Choose a commodity type to search, based on (imperfect) PSC codes.">
        <!-- FACTOR OUT -->
                Commodity:
                <select id="commodityChoice" >
                    <option value="All">All</option>
                    <option value="CPU">CPU</option>
                    <option value="Software">Software</option>
                    <option value="Supplies">Supplies</option>
                    <option value="Punchcards">Punchcards</option>
                    <option value="Configuration">Configuration</option>
                    <option value="Mini-Micro">Mini-Micro</option>
                    <option value="Component">Component</option>
                </select>
		</span>

        <!-- Start search -->
        <span id="smallSearch">
                <input type="text" name="small_search_string" id="small_search_string" value="{{search_string}}" title=
"
Enter any number of search terms to get a list of results ranked by relevance to those terms. To limit a search to those only containing a certain terms, separate terms by the upper case AND, like &quot;laptop AND rugged&quot;.  To exclude results containing a term, put upper case NOT or - in front of it, like &quot;laptop AND NOT rugged&quot;

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

To get more detailed help on searching, click the &quot;Help!&quot; link in the upper right of this page.
"
>
                <input type="button" id="searchButton" value="Search" onclick="performSearch();">
        </span>
<a href="./SearchHelp" style="color: white">Help!</a>
<span id="logoutLink" href="./Logout" style="color: white; cursor: pointer; text-decoration:underline">Logout</span>
        </div>

    </div>

    <!-- Content ... below the header -->
    <div id="content">

<div id="loading">
<h1>    Searching, Please Wait... </h1>
</div>

<div class="hideShowToggle">
<button id="hideShowGraph" >Hide/Show Graph</button>  
</div>

<div id="chartContainer">
    <div id="chartdiv" ></div>
</div>

   <div id="results-header">
  <span class="majorlabel">Results to return: </span>
  <input type="text" id="num_results_to_return" placeholder="100" title="Change number of results returned here. More results will slow your response time. If you find yourself paging through too many results, try adding terms to your search to increase the relevancy of your results, excluding terms by putting a minus sign (-) in front of a term you want to exclude.">
  <span class="majorlabel">Your Search for: </span>
  <span class="majorlabel" id="search_string_render"></span> 
  <span class="majorlabel">Returned :  </span>
  <span class="majorlabel" id="placeForNumberReturned"></span> 
  <span class="majorlabel">Results </span>
  <span class="majorlabel">in </span>
  <span class="majorlabel" id="timeSpentRender">in </span>
  <span class="majorlabel"> seconds. </span>
</div>

<!-- Start experiperiments -->
<div class="hideShowToggle">
<button id="hideShowPortfolios">Hide/Show Portfolios</button>
</div>

<div class="row">
     <div class="col-md-4" id="current_decorations">
          <p>Tags For This Record</p>
          <ul id="current_tag_list"></ul>
     </div>
     <div class="col-md-4">
          <p>Portfolios For This Record</p>
          <ul id="current_portfolio_list"></ul>
     </div>
</div>
<div class="row" id="portfolios">
      <div class="col-md-8"> 
    	 <button type="button" class="btn btn-like" id="add_portfolio_button">Add Portfolio</button>
    	 <input type="text" id="new_portfolio_name" placeholder="New Portfolio Name...">
         <div>All Portfolios</div>
                 <ul id="portfolio_list"></ul>
      </div>
</div>
<div class="col-md-4" id="tags">
      <button type="button" class="btn btn-like" id="add_tag_button">Add Tag</button>
      <input type="text" id="new_tag_name" placeholder="New Tag...">
      <p>All Tags</p>
      <ul id="tag_list"></ul>
</div>





        <!-- Start results header -->
        <div>
<div class="hideShowToggle">
<button id="hideShowDetails">Hide/Show Details</button>
</div>

<div id="detail-header">
  <span id="paginationHolder1">
  </span>

  <span id="results-sortby">
   <label>Sort by:</label>
   <span id="columnDropdownWrapper">
      <select id="sortColumn" >
          <option value="score">Query Relevance</option>
          <option value="unitPrice">Unit Price</option>
          <option value="unitsOrdered">Units</option>
          <option value="orderDate">Date</option>
          <option value="vendor">Vendor</option>
          <option value="productDescription">Product Description</option>
          <option value="longDescription">Long Description</option>
          <option value="contractingAgency">Contracting Agency</option>
          <option value="awardIdIdv">Award ID/IDV</option>
          <option value="commodityType">Commodity Type</option>
          <option value="psc">PSC</option>
     </select>
   </span>
  </span>

  <span id="results-sortdir">
   <label>Sort order:</label>
   <span id="orderDropdownWrapper">
      <select id="sortOrder" >
          <option value="dsc">Descending</option>
          <option value="asc">Ascending</option>
     </select>
   </span>
  </span>
</div>
   
<div style="clear:both;"></div>

<div id="detailArea"></div>

<!-- This should not be turned on until I can tie everything together better
with javascript
  <span id="paginationHolder2">
</span>
-->


<div style="clear:both"></div>


<div class="hideShowToggle">
<button id="hideShowGrid">Hide/Show Grid</button>
</div>
<p>
Clicking on a column header will sort both the grid and the detail area by that column.  Clicking on the header again will reverse the order of the sort.
</p>
  <div id="myGrid" style="height:500px;"></div> 
<p></p>

</div>

<!-- end of "content" -->
</div> 
    <div id="footer">
    	<p>PricesPaid (v. 0.4 BETA) is an official website of the U.S. Government, powered by GSA.</p>
    	<p><strong>Send Feedbak/Report Issues to:</strong> <a href="mailto:robert.read@gsa.gov">robert.read@gsa.gov</a></p>
    </div>   


<form id="fakeform" method="post" action="PortfolioPage">        
    <input type="hidden" name="antiCSRF" value="{{acsrf}}" />
    <input type="hidden" name="session_id" value="{{session_id}}" />
    <input id="portfolioinput" type="hidden" name="portfolio" value="" />
</form>

<form method="get" id="fakeLogoutForm" action="./">
</form>
<form method="post" id="fakeReturnForm" action="./PricesPaid">
    <input type="hidden" name="antiCSRF" value="{{acsrf}}" />
    <input type="hidden" name="session_id" value="{{session_id}}" />
</form>


     <script  src="../js/jquery.min.js"></script>


    <script src="../SlickGrid-master/lib/jquery.event.drag-2.2.js"></script>

    <script src="../SlickGrid-master/slick.core.js"></script>
    <script src="../SlickGrid-master/slick.editors.js"></script>
    <script src="../SlickGrid-master/slick.grid.js"></script>
    <!-- jqplot stuff -->
    
    <!--[if lt IE 9]>
    <![endif]-->
    <script  src="../js/excanvas/excanvas.js"></script>
    <script  src="../js/jquery.jqplot.min.js"></script>
    
    <script  src="../js/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script  src="../js/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
    <script  src="../js/plugins/jqplot.highlighter.min.js"></script>
    <script  src="../js/plugins/jqplot.cursor.min.js"></script>
    <script  src="../js/plugins/jqplot.bubbleRenderer.min.js"></script>
   <script  src="../js/plugins/jqplot.dateAxisRenderer.min.js"></script>

    <!-- Trying to get a bloody paginator to work! -->
    <script src="../js/jqPagination-master/js/jquery.jqpagination.js"></script>

    <!-- I use Stuart Banerman's hashcode to map award names to colors reliably: https://github.com/stuartbannerman/hashcode -->
    <script src="../js/hashcode-master/lib/hashcode.min.js"></script>

	<link href="../js/feedback_me/css/jquery.feedback_me.css" rel="stylesheet" type="text/css" />
	<script  src="../js/jquery-ui.min.js"></script>
	<script  src="../js/feedback_me/js/jquery.feedback_me.js"></script>
	<script  src="./js/StandardFunctions.js"></script>
	<script  src="./js/Utility.js"></script>
	<script  src="./js/result_rendering.js"></script>
	<script  src="./js/plot_rendering.js"></script>
	<script  src="./js/grid_rendering.js"></script>
	<script  src="./js/header.js"></script>
	<script  src="./js/GUISpecifics.js"></script>
	<script  src="./js/pagination.js"></script>
	<script  src="../gui/MorrisDataDecorator/js/handlers.js"></script>

 <script>
$(function() {
   $( document ).tooltip({
       position: {
       my: "center bottom-20",
       at: "center top",
       using: function( position, feedback ) {
       $( this ).css( position );
       $( "<div>" )
           .addClass( "arrow" )
           .addClass( feedback.vertical )
           .addClass( feedback.horizontal )
         .appendTo( this );
     }
    }
});
});
</script>

<style>
.ui-tooltip, .arrow:after {
   background: black;
   border: 2px solid white;
   width: 50%;
}
.ui-tooltip {
   padding: 10px 20px;
   color: white;
   border-radius: 20px;
   font: bold 14px "Helvetica Neue", Sans-Serif;
#   text-transform: uppercase;
   box-shadow: 0 0 7px black;
}
.arrow {
   width: 70px;
   height: 16px;
   overflow: hidden;
   position: absolute;
   left: 50%;
   margin-left: -35px;
   bottom: -16px;
}
.arrow.top {
   top: -16px;
   bottom: auto;
}
.arrow.left {
   left: 20%;
}
.arrow:after {
  content: "";
  position: absolute;
  left: 20px;
  top: -20px;
  width: 25px;
  height: 25px;
  box-shadow: 6px 5px 9px -9px black;
  -webkit-transform: rotate(45deg);
  -moz-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  -o-transform: rotate(45deg);
  transform: rotate(45deg);
}
.arrow.top:after {
  bottom: -20px;
  top: auto;
}
</style>
<script>

$(document).ready(function(){
    $("#logoutLink").click(Logout);

    $("#pricespaid_logo").click(function() { 
	$('#fakeReturnForm').submit();
    });
});


// These should probably be parametrized
var portfolio_url = "/gui/portfolio";
var tag_url = "/gui/tag";

HANDLER_NAMESPACE_OBJECT.portfolio_url = portfolio_url;
HANDLER_NAMESPACE_OBJECT.tag_url = tag_url;
DEFAULT_NUM_RESULTS = 100;

// BEGIN set up click handlers
$('#next_button').click(next_handler);
$('#prev_button').click(prev_handler);
$('#like_button').click(like_handler);
$('#dislike_button').click(dislike_handler);
$('#add_portfolio_button').click(add_portfolio_handler);
$('#add_tag_button').click(add_tag_handler);
// END   set up click handlers

function Portfolio() {
      var portfolio = $(this).text();
      $("#portfolioinput").val(portfolio);
      $("#fakeform").submit();
}

function refreshDroppablesPortfolios() {
      $(".droppableportfolio").click(Portfolio);
}

$(document).ready(function(){
        get_portfolio_list(refreshDroppablesPortfolios);
        get_tag_list(refreshDroppablesPortfolios);
	//set up some minimal options for the feedback_me plugin
	fm_options = {
                custom_params: {
                   session_id: '{{session_id}}',
                   antiCSRF: '{{acsrf}}'
                },
		name_required : false,
                name_label : "(Optional) tell us who you are",
                message_label : "How can we do better?",
		message_placeholder:"Go ahead, type your feedback here ...",
		message_required : false,
		show_asterisk_for_required : true,
                close_on_click_outside: false,
		feedback_url : '{{feedback_url}}',
                show_radio_button_list : true,
                radio_button_list_required : false,
                radio_button_list_title: "How likely are you to recommend Prices Paid to a colleague (1 means not likely, 5 means very likely)?"
        };

	//init feedback_me plugin
	fm.init(fm_options);
        $("#hideShowGrid").click(function() { 
		    $("#myGrid").toggle();
		 });

         $("#hideShowPortfolios").click(function() { 
		    $("#portfolios").toggle();
		 });

	 $("#hideShowDetails").click(function() { 
		    $("#detailArea").toggle();
		 });

	 $("#hideShowGraph").click(function() { 
		    $("#chartContainer").toggle();
	 });
    }
);




// This is an ugly global variable hack that seems to be 
// needed to events properly bound to dynamically created elements!
var SCRATCH_NUMBER = 0;
var itemDetailAssociation = [];

// The current desire is that 

var data = [];
var transactionData = [];
var internalFieldLabel = [];
internalFieldLabel["starred"] = "Favorite";
internalFieldLabel["color"] = "Color";



// Note: that search_string here is html-encoded by Bottle,
// So presumably this does not represent a XSS vulnerability...
$('#search_string_render').text('{{search_string}}');

$('#commodities li').first().addClass("selected");
var currentlySelectedCommodityElement  = '{{commodity_id}}';
$('input[id=small_search_string]').on('keyup', function(e) {
    if (e.which == 13) {
        performSearch();
    }
});

// This is my basic page math...
var PAGESIZE = 5;
var currentPage = 0; 


var timeSearchBegan;

var grid;
var currentColumn = "score";

var currentCommodityId = '{{commodity_id}}';

var com = $("#commodityChoice").val(currentCommodityId);

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

function performSearch() {
    $('#loading').show();
    $('#results-header').hide();
    timeSearchBegan = new Date();
    var standard = standardCommodities[currentCommodityId];

    var search = $('#small_search_string').val();
    var max_results = $('#num_results_to_return').val();
    var max_results_num = parseFloat(max_results);
    if (!isNumber(max_results_num)) {
       max_results_num = DEFAULT_NUM_RESULTS;
    }
    if (search.length == 0) {
      alert("Please enter a search term.");
      $('#loading').hide();
    } else {
      $('#search_string_render').text(search);
      $.post("search",
	   { search_string: search,
             antiCSRF: '{{acsrf}}',
             session_id: '{{session_id}}',
             psc_pattern: standard,
             numRows: max_results_num
	   },
	   processAjaxSearch
	  ).fail(function() { alert("The search failed in some way; please try something else."); });
    }
};




    var comclickcount = 0;
    $("#comDropdownWrapper").click(function(){
	if ((comclickcount % 2) == 1) {
	    var com = $("#commodityChoice").val();
	    currentCommodityId = com;
            performSearch();
	}
	comclickcount++;
    });


function processAjaxSearch(dataFromSearch) {
// If we timed out or failed to authenticate, we need to alert the user.
    if (!(dataFromSearch != null && typeof dataFromSearch === 'object')) {
		 alert("No results returned.");
		 return;
    }
    if ((typeof dataFromSearch) == 'undefined') {
		 alert("No results returned.");
		 return;
    }
    if (dataFromSearch[0] === undefined) {
		 alert("No results returned.");
		 return;
    }


		 
    if (dataFromSearch[0]["status"] && (dataFromSearch[0]["status"] == "BadAuthentication")) {
        alert("Unable to Authenticate. Probably your session timed-out. Please log in again.");	 
    }
    $('#loading').hide();
    $('#results-header').show();
    var timeSearchEnded = new Date();
    transactionData = [];
    data = [];
    var totalNumber = 0;
    for (var key in dataFromSearch) {
        transactionData[totalNumber++] = dataFromSearch[key];
    }

    var numberDiv = document.getElementById('placeForNumberReturned');
    numberDiv.innerHTML = totalNumber;


recreatePagination();

// Note: This counts the Page from 1, not zero!
// $(document).ready(function() {
	$('.pagination').jqPagination({
//		link_string	: '/?page={page_number}',
		link_string	: '',
		max_page	:  Math.ceil(totalNumber/PAGESIZE),
                currentPage     : 1,
		paged		: function(page) {
                currentPage = page - 1;
                redrawDetailArea(transactionData,currentPage);
		}
	});

// });

    var secondsSpent = (timeSearchEnded-timeSearchBegan)/1000.0;
    $('#timeSpentRender').text(secondsSpent.toFixed(2));

    var medianUnitPrice = 0.0;

    grid_rendering();
  initialize_plot(data,medianUnitPrice);
  }

  performSearch();

</script>

</body>
</html>
