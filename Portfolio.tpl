<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Portfolio v. 2.0 BETA Search</title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">
    <link rel="stylesheet" type="text/css"
	  href="./theme/css/decoration_gui.css" >
    <link rel="stylesheet" type="text/css" href="theme/css/bootstrap.css">
    <link href="./theme/css/shared.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link href="./theme/css/mainPage.css" rel="stylesheet" type="text/css" media="screen, projection">


    <script src="../js/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="../js/jqPagination-master/css/jqpagination.css">

    {{!goog_anal_script}}
</head>
<body>
<img id="betastripe" src="theme/img/Beta2.0.png"  alt="Beta 2.0">

<div id="sidebar">
  <div id="sidebar_search">
    <div id="portfolio_title">
    {{portfolio}}
    </div>
  </div>

  <div id='sidebar-manage-results'>
    {{!portfolio_panel}}
  </div>

  </div>

    <!-- Start header -->
<div id="header">

    <div class="col-md-3 col-xs-5 logo">
      <span id="pricespaid_logo"><img src="theme/img/pp_logo_beta.png" alt="PricesPaid"></span>
  </div>
  <div class="col-md-9 col-xs-7">
      <nav class="navbar" role="navigation">

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div>
          <ul class="nav navbar-nav">
            <li id="return_to_search" class="active"><a href="#">Search</a></li>
            <li id="logoutLink"><a href="#">Logout</a></li>
            <li id="helplink" ><a href="./SearchHelp" >Help!</a></li>
        </ul>
    </div><!-- /.navbar-collapse -->
</nav>
</div>
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
<img src="theme/img/icn_export.png" alt="PricesPaid" height="20px;">
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
<form method="post" id="fakeReturnForm" action="./StartPageReturned">
    <input type="hidden" name="antiCSRF" value="{{acsrf}}" />
    <input type="hidden" name="session_id" value="{{session_id}}" />
</form>
</div>

<div id="added_dialog">
Transaction Added to Portfolio.
</div>

<div id="deleted_dialog">
Transaction Deleted From to Portfolio.
</div>

{{!footer_html}}

</body>
    <script  src="../js/excanvas/excanvas.js"></script>
     <script  src="../js/jquery.min.js"></script>

<!--
    <script src="../js/slickgrid.inclusions.js"></script>
-->

{{!slickgrid_includes}}

{{!jqplot_includes}}

    <!-- Trying to get a bloody paginator to work! -->
    <script src="../js/jqPagination-master/js/jquery.jqpagination.js"></script>

{{!mainjs_includes}}

<script>

HANDLER_NAMESPACE_OBJECT.decoration_add_dialog_id = "#added_dialog";
HANDLER_NAMESPACE_OBJECT.decoration_deleted_dialog_id = "#deleted_dialog";

HANDLER_NAMESPACE_OBJECT.decoration_deleted_function =
function () {
  $(HANDLER_NAMESPACE_OBJECT.decoration_deleted_dialog_id).dialog({
    autoOpen: false,
    modal: false,
    buttons: [],
    open: function(event, ui){
     setTimeout("$('#deleted_dialog').dialog('close')",1500);
    }
  });
  performSearch();
}

$(HANDLER_NAMESPACE_OBJECT.decoration_add_dialog_id).dialog({
    autoOpen: false,
    modal: false,
    buttons: [],
    open: function(event, ui){
     setTimeout("$('#added_dialog').dialog('close')",1500);
    }
});

$(HANDLER_NAMESPACE_OBJECT.decoration_deleted_dialog_id).dialog({
    autoOpen: false,
    modal: false,
    buttons: [],
    open: function(event, ui){
     setTimeout("$('#deleted_dialog').dialog('close')",1500);
    }
});


$(document).ready(function(){
    $("#logoutLink").click(Logout);

    $("#return_to_search").click(function() {
	$('#fakeReturnForm').submit();
    });

    $("#hideShowGraph").click(function() {
 		    $("#chartContainer").toggle();
    });

});


// These should probably be parametrized
var portfolio_url = "/gui/portfolio";
var portfolio_url_addendum = "?antiCSRF={{acsrf}}&session_id={{session_id}}";
var portfolio_post_data = {
             antiCSRF: '{{acsrf}}',
             session_id: '{{session_id}}',
};
var tag_url = "/gui/tag";

HANDLER_NAMESPACE_OBJECT.portfolio_url = portfolio_url;
HANDLER_NAMESPACE_OBJECT.portfolio_url_addendum = portfolio_url_addendum;
HANDLER_NAMESPACE_OBJECT.portfolio_post_data = portfolio_post_data;
HANDLER_NAMESPACE_OBJECT.tag_url = tag_url;

PAGE_CONTEXT = {};
PAGE_CONTEXT.portfolio_name = '{{portfolio}}';
PAGE_CONTEXT.render_transaction_delete = true;

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
      $('#search_string_render').html('&ldquo;'+htmlEscape('{{portfolio}}')+'&rdquo;');
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
