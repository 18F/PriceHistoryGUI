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

    <!-- Start header -->
    <div id="header">
        <!-- Top part of header -->
        <div class="inner">
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
    <div id="content" class="inner">

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


<form id="fakeform" method="post" action="PortfolioPage">        
    <input type="hidden" name="antiCSRF" value="{{acsrf}}" />
    <input type="hidden" name="session_id" value="{{session_id}}" />
    <input id="portfolioinput" type="hidden" name="portfolio" value="" />
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
	<script  src="./js/GUISpecifics.js"></script>
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
  tranform: rotate(45deg);
}
.arrow.top:after {
  bottom: -20px;
  top: auto;
}
</style>
<script>

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



function Logout() {
      $.post("Logout",
	   { antiCSRF: '{{acsrf}}',
             session_id: '{{session_id}}'
	});
      alert("You are now securely logged out.");
}

$("#logoutLink").click(Logout);





// WARNING!!! My understanding is we can't use jqPlot if 
// we have IE8.  They may want to switch to a simple mode,
// but I will just add a message in the chartdiv!
var isIE8orLower = false;
if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ //test for MSIE x.x;
 var ieversion=new Number(RegExp.$1); // capture x.x portion and store as a number
 if (ieversion<9)
    isIE8orLower = true;
}
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

function sortByColumnAndRedraw(col,asc) {
  sortByColumn(col,asc);
// I would rather reset the current page, but it is buggy...
// This is the best that I can do on short notice.
//  currentPage = 0;
  redrawDetailArea(currentPage);
}
function sortByColumn(col,asc) {
// We need to reset the currentPage when we sort
    var currentSortCol = col;
    var isAsc = asc;
    var stringSort = function(a,b) {
	var ret;
	if (a[currentSortCol] < b[currentSortCol]) {
	    ret = 1;
	} else if (a[currentSortCol] > b[currentSortCol]) {
            ret = -1;
	} else {
            ret = 0;
	}
	if (isAsc) 
	    return -1*ret;
	else 
	    return ret;
    }
    var numberSort = function(a,b) {
	var ret;
	if (parseFloat(a[currentSortCol]) < parseFloat(b[currentSortCol])) {
	    ret = 1;
	} else if (parseFloat(a[currentSortCol]) > parseFloat(b[currentSortCol])) {
            ret = -1;
	} else {
            ret = 0;
	}
	if (isAsc) 
	    return -1*ret;
	else 
	    return ret;
    }
    transactionData.sort(currentSortCol == "unitPrice" || 
			 currentSortCol == "unitsOrdered" ? numberSort : stringSort);
}


// WARNING!!!
// This seems to do nothing on IE8.  Fixing this problem for IE8 is probably the most important thing 
// we can do.  It was always pretty unattractive anyway---I must find a way to simplify.
// It may or may not be "on(click", stuff, it just deosn't render anytrhing!.
// The first thing to try is probably switching out of JQuery and doing a "getelementById" and innerHTML solution.
    function redrawDetailArea(page) {
	var detailAreaDiv = $("#"+'detailArea');
	detailAreaDiv.empty();
	var smallSlice = transactionData.slice(page*PAGESIZE,
Math.min((page+1)*PAGESIZE,transactionData.length));
	smallSlice.forEach(function (e,i,a) {
            detailAreaDiv.append(renderStyledDetail(e,SCRATCH_NUMBER));
	    $(document).on( "click", "#itemDetails"+SCRATCH_NUMBER, detailItemHandler );

// Ugly....
	    itemDetailAssociation[SCRATCH_NUMBER] = i+page*PAGESIZE;
	    SCRATCH_NUMBER++;
	});

// Now we must make the drag/drop work.
       $( ".droppablerecord" ).droppable({
           tolerance: "touch",
           drop: function(event, ui) {
                 var text = ui.draggable.text();
                 var portfolio = isPortfolio(text);
		 alert("this hello = "+ $(this).attr('p3id'));
		 var key = $(this).attr('p3id');
                 var deco = (portfolio) ? HANDLER_NAMESPACE_OBJECT.portfolio_url
		                        : HANDLER_NAMESPACE_OBJECT.tag_url;
                 $.post(deco+"/add_record/"+text+"/"+key,
//			function () { process_record_request(key);}
		        function () {}
                     ).fail(function() { alert("The addition of that record to the content_area portfolio failed."); });
            }
	});

       $( ".droppablerecord" ).draggable({ revert: true });

    }



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

// destroy pagination  if it exists and recreate...
// This is needed to keep jqPaginate from getting confused, 
// I don't know why.  I should send them email about it.
function recreatePagination() {
    var html = "";
    html += '<div class="large pagination">';
    html += '<a href="#" class="first" data-action="first">&laquo;</a>';
    html += '<a href="#" class="previous" data-action="previous">&lsaquo;</a>';
    html += '<input type="text" readonly="readonly" data-max-page="40" />';
    html += '<a href="#" class="next" data-action="next">&rsaquo;</a>';
    html += '<a href="#" class="last" data-action="last">&raquo;</a>';
    html += '</div>';
    $('#paginationHolder1').html(html);

// I can't use the second paginator until I tie everything together with
// javascript --- this will take too much time.
//    var wrappedHtml = '<p>'+html+'</p>';
//    $('#paginationHolder2').html(wrappedHtml);
}

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
                redrawDetailArea(currentPage);
		}
	});

// });

    var secondsSpent = (timeSearchEnded-timeSearchBegan)/1000.0;
    $('#timeSpentRender').text(secondsSpent.toFixed(2));

    // Now I'm going to try something weird, which seems justified by the nature
    // of our data--I'm only going to plot the lowest-prices 80%.  The upper
    // 20% is often something not really in the data set you are looking at
    // and it messes up the plot.  This should really be under the control
    // of the user, but that will have to wait.
    // In order to do this we will sort on unitPrice, which is probably
    // a good way to present the data anyway.
    transactionData.sort(
        function (a,b) {
            var ret;
            if (parseFloat(a["unitPrice"]) < parseFloat(b["unitPrice"])) {
                ret = 1;
            } else if (parseFloat(a["unitPrice"]) > parseFloat(b["unitPrice"])) {
                ret = -1;
            } else {
                ret = 0;
            }
            return ret;
        });
    function medianSortedValues(values) { 
        if (values.length != 0) {
	 var half = Math.floor(values.length/2);
	 if(values.length % 2) {
              return parseFloat(values[half]["unitPrice"]);
	 } else {
	      return (parseFloat(values[half-1]["unitPrice"]) +
              parseFloat(values[half]["unitPrice"])) / 2.0;
	 }
	} else {
	    return 0.0;
	}
    }
    var medianValue = medianSortedValues(transactionData);
    var medianUnitPrice = (transactionData.length > 0) ? medianValue
        : 0.0;

    var sumOfUnitPrice = 0.0;
    transactionData.forEach(function(d) {
        var x = parseFloat(d["unitPrice"]);
        if (!isNaN(x))
            sumOfUnitPrice += x
        else {
            d["unitPrice"] = "0.0";
        }
    });

   var currentColumn = "score";
   var currentOrderIsAscending = false; 
   sortByColumn(currentColumn,currentOrderIsAscending);

    var options = {
        editable: true,
        asyncEditorLoading: false,
        enableCellNavigation: true,
        enableColumnReorder: false
    };


    transactionData.forEach(function (e,i,a) {
        var obj = e;
        e["starred"] = "";
// This randomizes color but keeps the same colors associated with the same 
// field...
        e.color = standardColors[Math.abs(Hashcode.value(e["awardIdIdv"])) % NUM_STANDARD_COLORS];
        data[i] = obj;
    });

    redrawDetailArea(0);

    function renderStarredTransactionsInDetailArea() {
	var div = document.getElementById('detailArea');
	div.innerHTML = "";
	data.forEach(function (e) {
            if (e.starred == "Starred") {
		div.innerHTML += renderStyledDetail(e);
	    }
	});
    }

    // Define function used to get the data and sort it.
    function getItem(index) {
	return transactionData[index];
    }
    function getLength() {
	return transactionData.length;
    }
    var colclickcount = 0;


    $("#columnDropdownWrapper").click(function(){
	if ((colclickcount % 2) == 1) {
	    var col = $("#sortColumn").val();
	    currentColumn = col;
	    refreshSort(currentColumn,currentOrderIsAscending);
	}
	colclickcount++;
    });

    var ordclickcount = 0;
    $("#orderDropdownWrapper").click(function(){
	if ((ordclickcount % 2) == 1) {
	    var ord = $("#sortOrder").val();
            currentOrderIsAscending =  (ord == "asc");
	    refreshSort(currentColumn,currentOrderIsAscending);
	}
	ordclickcount++;
    });

    function refreshSort(col,ord) {
        sortByColumnAndRedraw(col,ord);
        grid.setData(transactionData);
        grid.invalidateAllRows();
        grid.render();
        redrawDetailArea(currentPage);
    }

    $(function () {
	$('#myGrid').innerHTML = "";
	grid = new Slick.Grid("#myGrid", transactionData, columns, options);

	// There's got to be a way to make this more compact!!!
	grid.onSort.subscribe(function (e, args) {

	    var currentSortCol;
	    var isAsc = args.sortAsc;
	    currentSortCol = args.sortCol.field;
	    sortByColumnAndRedraw(currentSortCol,isAsc);

	    grid.setData(transactionData);
	    grid.invalidateAllRows();
	    grid.render();
	    redrawDetailArea(currentPage);
	});
    });

    grid.onClick.subscribe(function (e) {
	var cell = grid.getCellFromEvent(e);
	if (grid.getColumns()[cell.cell].id == "starred") {
            if (!grid.getEditorLock().commitCurrentEdit()) {
		return;
            }
            var states = { "": "Starred", "Starred": ""};
            data[cell.row].starred = states[data[cell.row].starred];
            grid.updateRow(cell.row);
            e.stopPropagation();
	}
    });

    var plotData = [[]];
    var i = 0;
    var thingToPlot = data.forEach(function (e) {
	// we don't want to plot it if it is more than 4 times the median price, 
	// as it is probably erroneous

	if ((data.length < 15) || (medianUnitPrice <= 100.0) || (e.unitPrice < (medianUnitPrice * 4.0))) {
	    var newArray = [];

	    newArray[0] = e.orderDate;
	    newArray[1] = Math.ceil(e.unitPrice * 100) / 100;
	    newArray[2] = Math.sqrt(Math.abs(e.unitsOrdered));
	    newArray[3] = {
		label: e.vendor,
		color:  e.color
	    };
	    plotData[0].push(newArray);
	}
    });

    $('#chartdiv').empty();

// It seems we no longer need this!
//    if (isIE8orLower) {
    if (false) {
      $('#chartdiv').append("<div style='width: 700px; color: red; margin: 20px'>The graph not supported on Internet Explorer less than Version 9.  You appear to be using version "+ieversion+", or your browser is using that as its rendering mode for some reason. If you need the graph, upgrade, or use a different browser, or change the document mode.<\div>");
    } else {
    var plot1b = $.jqplot('chartdiv', plotData, {
	title: 'Unit Prices',
	seriesDefaults:{
            renderer: $.jqplot.BubbleRenderer,
            rendererOptions: {
		bubbleAlpha: 0.6,
		highlightAlpha: 0.8,
		showLabels: false
            },
            shadow: true,
            shadowAlpha: 0.05
        },
	axes:{
            xaxis:{
		renderer:$.jqplot.DateAxisRenderer,
		label: '<span color: black;>Color denotes Vehicle.</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span>Bubble size denotes number of units.</span>'
            },
            yaxis:{
		label: 'Dollars',
		tickOptions:{
		    formatString:'$%.2f'
		}
            }
	},
	highlighter: {
            show: true,
            sizeAdjust: 7.5
	},
	cursor: {
            show: true,
            tooltipLocation:'sw'
	}
    }
			 );
    }


    // Now bind function to the highlight event to show the tooltip
    // and highlight the row in the legend.
    $('#chartdiv').bind('jqplotDataHighlight',
			function (ev, seriesIndex, pointIndex, data, radius) {   
			    var chart_left = $('#chartdiv').offset().left,
			    chart_top = $('#chartdiv').offset().top,
			    x = plot1b.axes.xaxis.u2p(data[0]),  // convert x axis unita to pixels
			    y = plot1b.axes.yaxis.u2p(data[1]);  // convert y axis units to pixels
			    var color = 'rgb(50%,50%,100%)';
			    $('#tooltip1b').css({left:chart_left+x+radius+5, top:chart_top+y});
			    
			    $('#tooltip1b').html('<span style="font-size:14px;font-weight:bold;color: ' + color + ';">' + data[3] + '</span><br />' + 'x: ' + data[0] +
						 '<br />' + 'y: ' + data[1] + '<br />' + 'r: ' + data[2]);
			    
			    $('#tooltip1b').show();
			});
    // Bind a function to the unhighlight event to clean up after highlighting.
    $('#chartdiv').bind('jqplotDataUnhighlight',
			function (ev, seriesIndex, pointIndex, data) {
			    $('#tooltip1b').empty();
			    $('#tooltip1b').hide();
			});
}



  performSearch();

</script>

</body>
</html>
