<!DOCTYPE html> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Portfolio v. 0.5 BETA Search</title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">
    <link rel="stylesheet" type="text/css" 
	  href="./theme/css/decoration_gui.css" >
    <link href="./theme/css/shared.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link href="./theme/css/mainPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link rel="stylesheet" href="../SlickGrid-master/slick.grid.css" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

    <link rel="stylesheet" type="text/css" href="../js/jqPagination-master/css/jqpagination.css"> 

    <link rel="stylesheet" type="text/css" href="../js/jquery.jqplot.css" >

    {{!goog_anal_script}}
</head>
<body>
<img id="betastripe" src="theme/img/Beta0.5.png"  alt="Beta 0.5">

<div id="sidebar">
  <div id="sidebar_search">
    <div id="portfolio_title">
    {{portfolio}}
    </div>
  </div>

  <div id="sidebarpaginator">   <span id="paginationHolder2"> </div>
<div id="portfolios">
  <div>
     <p>Portfolios For This Record</p>
     <div>
          <ul id="current_portfolio_list"></ul>
     </div>
  </div>
  <div>
      <div> 
    	 <button type="button" class="btn btn-like" id="add_portfolio_button">Add Portfolio</button>
    	 <input type="text" id="new_portfolio_name" placeholder="New Portfolio Name...">
         <div  id="portfolios">
                 <div id="portfolio_list"></div>
</div>
      </div>
  </div>

</div>
</div>

    <!-- Start header -->
    <div id="header">
        <!-- Top part of header -->
        <!-- FACTOR OUT -->
            <span id="pricespaid_logo"><img src="theme/img/pp_logo_beta.png" alt="PricesPaid"></span>
<span id="logoutLink" href="./Logout">Logout</span>

    </div>

    <!-- Content ... below the header -->
    <div id="content" class="inner">

<div id="loading">
</div>

   <div id="results-header">
    <span class="majorlabel" id="placeForNumberReturned"></span> 
    <span class="majorlabel">&nbsp;Transactions </span>
    <span class="joininglabel">in portfolio</span>
    <span class="majorlabel" id="search_string_render"></span> 


</div>

        <!-- Start results header -->
        <div id="sortcontrols">

  <span id="results-sortby">
   <label>Sort by:</label>
   {{!column_dropdown}}
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

<span id="exportButton">
<a id="exportLink" href="./SimpleHTML?portfolio={{portfolio}}&antiCSRF={{acsrf}}&session_id={{session_id}}" target="_blank">Export</a>
<img src="theme/img/icn_export.svg" alt="PricesPaid" height="20px;">
</span>
         </div>

<div id="detail-header">
  <span id="paginationHolder1">
  </span>

</div>
   
<div style="clear:both;"></div>

<div id="detailArea"></div>

<div style="clear:both"></div>

<div class="hideShowToggle">
<button id="hideShowGraph" >Hide/Show Graph</button>  
</div>

<div id="chartContainer">
    <div id="chartdiv" ></div>
</div>

<div style="clear:both"></div>

<div class="hideShowToggle">
<button id="hideShowGrid">Hide/Show Grid</button>


</div>
<p>
Clicking on a column header will sort both the grid and the detail area by that column.  Clicking on the header again will reverse the order of the sort.
</p>
  <div id="myGrid" style="height:500px;"></div> 
<p></p>



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
</div>

<div id="dialog">
Transaction Added to Portfolio.
</div>

{{!footer_html}}

</body>

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

HANDLER_NAMESPACE_OBJECT.decoration_add_dialog_id = "#dialog";

$(HANDLER_NAMESPACE_OBJECT.decoration_add_dialog_id).dialog({
    autoOpen: false,
    modal: false,
    buttons: [],
    open: function(event, ui){
     setTimeout("$('#dialog').dialog('close')",1500);
    }
});


$(document).ready(function(){
    $("#logoutLink").click(Logout);

    $("#pricespaid_logo").click(function() { 
	$('#fakeReturnForm').submit();
    });


    $("#hideShowGraph").click(function() { 
 		    $("#chartContainer").toggle();
    });

});


// These should probably be parametrized
var portfolio_url = "/gui/portfolio?antiCSRF={{acsrf}}&session_id={{session_id}}";
var tag_url = "/gui/tag";

HANDLER_NAMESPACE_OBJECT.portfolio_url = portfolio_url;
HANDLER_NAMESPACE_OBJECT.tag_url = tag_url;

// BEGIN set up click handlers
$('#next_button').click(next_handler);
$('#prev_button').click(prev_handler);
$('#like_button').click(like_handler);
$('#dislike_button').click(dislike_handler);
$('#add_portfolio_button').click(add_portfolio_handler);
// $('#add_tag_button').click(add_tag_handler);
// END   set up click handlers

function Portfolio(click) {
      var portfolio = $(this).attr('id').substring("draggable-id-".length);
      $("#portfolioinput").val(portfolio);
      $("#fakeform").submit();
}

function refreshDroppablesPortfolios() {
      $(".droppableportfolio").click(Portfolio);
}

HANDLER_NAMESPACE_OBJECT.refresh_droppables = refreshDroppablesPortfolios;

get_portfolio_list();
// get_tag_list();


function performSearch() {
    $('#loading').show();
    $('#results-header').hide();
    timeSearchBegan = new Date();
      $('#search_string_render').html('&ldquo;{{portfolio}}&rdquo;');
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
    dataFromSearch = handleEmptyResults(dataFromSearch);
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
initialize_plot(data,medianUnitPrice);
}



performSearch()

</script>

</html>
