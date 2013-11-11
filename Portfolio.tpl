<!DOCTYPE html> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Portfolio v. 0.4 BETA Search</title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">
    <link href="./theme/css/mainPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link rel="stylesheet" href="../SlickGrid-master/slick.grid.css" type="text/css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

    <link rel="stylesheet" type="text/css" href="../js/jqPagination-master/css/jqpagination.css"> 
    {{!goog_anal_script}}
</head>
<body>

    <!-- Start header -->
    <div id="header">
        <!-- Top part of header -->
        <div class="inner">
        <!-- FACTOR OUT -->
            <span id="pricespaid_logo"><img src="theme/img/pp_logo_beta.png" alt="PricesPaid"></span>
<span id="logoutLink" href="./Logout" style="color: white; cursor: pointer; text-decoration:underline">Logout</span>
<a id="exportLink" href="./SimpleHTML?portfolio={{portfolio}}&antiCSRF={{acsrf}}&session_id={{session_id}}" style="color: white; cursor: pointer; text-decoration:underline" target="_blank">Export</a>
        </div>

    </div>

    <!-- Content ... below the header -->
    <div id="content" class="inner">

<div id="loading">
<h1>Portfolio</h1>
</div>

<div class="hideShowToggle">
<button id="hideShowGraph" >Hide/Show Graph</button>  
</div>

<div id="chartContainer">
    <div id="chartdiv" ></div>
</div>

   <div id="results-header">
  <span class="majorlabel">Your Portfolio Contains: </span>
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

<div style="clear:both"></div>


<div class="hideShowToggle">
<button id="hideShowGrid">Hide/Show Grid</button>
</div>
<p>
Clicking on a column header will sort both the grid and the detail area by that column.  Clicking on the header again will reverse the order of the sort.
</p>
  <div id="myGrid" style="height:500px;"></div> 
<p></p>

    <div id="footer">
    	<p>PricesPaid (v. 0.4 BETA) is an official website of the U.S. Government, powered by GSA.</p>
    	<p><strong>Send Feedbak/Report Issues to:</strong> <a href="mailto:robert.read@gsa.gov">robert.read@gsa.gov</a></p>
    </div>   

<form method="get" id="fakeLogoutForm" action="./">
</form>
<form method="post" id="fakeReturnForm" action="./PricesPaid">
    <input type="hidden" name="antiCSRF" value="{{acsrf}}" />
    <input type="hidden" name="session_id" value="{{session_id}}" />
</form>
</div>

     <script  src="../js/jquery.min.js"></script>
    <script src="../SlickGrid-master/lib/jquery.event.drag-2.2.js"></script>

    <script src="../SlickGrid-master/slick.core.js"></script>
    <script src="../SlickGrid-master/slick.editors.js"></script>
    <script src="../SlickGrid-master/slick.grid.js"></script>
    <!-- jqplot stuff -->
    
    <!--[if lt IE 9]>
    <![endif]-->

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
	<script  src="./js/grid_rendering.js"></script>
	<script  src="./js/header.js"></script>
	<script  src="./js/GUISpecifics.js"></script>
	<script  src="./js/pagination.js"></script>
	<script  src="../gui/MorrisDataDecorator/js/handlers.js"></script>
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

// BEGIN set up click handlers
$('#next_button').click(next_handler);
$('#prev_button').click(prev_handler);
$('#like_button').click(like_handler);
$('#dislike_button').click(dislike_handler);
$('#add_portfolio_button').click(add_portfolio_handler);
$('#add_tag_button').click(add_tag_handler);
// END   set up click handlers

get_portfolio_list();
get_tag_list();


function performSearch() {
    $('#loading').show();
    $('#results-header').hide();
    timeSearchBegan = new Date();
      $('#search_string_render').text('{{portfolio}}');
      $.post("returnPortfolio",
	   { antiCSRF: '{{acsrf}}',
             session_id: '{{session_id}}',
	     portfolio: '{{portfolio}}'
	   },
	   processAjaxSearch
	  ).fail(function() { alert("The search failed in some way; please try something else."); });
};



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

$("#hideShowPortfolios").click(function() { 
    $("#portfolios").toggle();
});

$("#hideShowDetails").click(function() { 
    $("#detailArea").toggle();
});

$("#hideShowGrid").click(function() { 
		    $("#myGrid").toggle();
});


// Note: that search_string here is html-encoded by Bottle,
// So presumably this does not represent a XSS vulnerability...

// This is my basic page math...
var PAGESIZE = 5;
var currentPage = 0; 


var timeSearchBegan;

var grid;
var currentColumn = "score";






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

// This is currently global to grid_rendering...
    var medianUnitPrice = 0.0;

   grid_rendering();
}

performSearch()

</script>

</body>
</html>
