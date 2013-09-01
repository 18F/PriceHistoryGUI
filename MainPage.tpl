<!DOCTYPE html> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PricesPaid</title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">
    <link href="theme/css/mainPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link rel="stylesheet" href="../SlickGrid-master/slick.grid.css" type="text/css">
    <link rel="stylesheet" href="../SlickGrid-master/css/smoothness/jquery-ui-1.8.16.custom.css" type="text/css">
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
		<span id="comDropdownWrapper">
        <!-- FACTOR OUT -->
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
                <input type="text" name="small_search_string" id="small_search_string" value="{{search_string}}">
		<input type="hidden" name="user" value="{{user}}">
		<input type="hidden" name="password" value="{{password}}">
                <input type="button" id="searchButton" value="Search" onclick="performSearch();">
        </span>

        <!-- FACTOR OUT -->
            <span id="gsa_logo">Powered by <img src="theme/img/gsa_logo.png" alt="GSA"></span>

        </div>

    </div>

    <!-- Content ... below the header -->
    <div id="content" class="inner">

<div id="loading">
<h1>    Searching, Please Wait... </h1>
</div>
   <div id="results-header">
  <span class="majorlabel">Your Search for: </span>
  <span class="majorlabel" id="search_string_render"></span> 
  <span class="majorlabel">Returned :  </span>
  <span class="majorlabel" id="placeForNumberReturned"></span> 
  <span class="majorlabel">Results </span>
  <span class="majorlabel">in </span>
  <span class="majorlabel" id="timeSpentRender">in </span>
  <span class="majorlabel"> seconds. </span>
</div>

<div class="hideShowToggle">
<button id="hideShowGraph" >Hide/Show Graph</button>  
</div>

<div id="chartContainer">
    <div id="chartdiv" ></div>
</div>
        <!-- Start results header -->
        <div>
<div class="hideShowToggle">
<button id="hideShowDetails">Hide/Show Details</button>
</div>

<div id="paginationHolder">
</div>
            <div id="results-sortby">
                <label>Sort by:</label>
		<div id="dropdownWrapper">
                <select id="sortColumn" >
                    <option value="score">Relevance</option>
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
		</div>
            </div>
            <div style="clear:both;"></div>
        </div>
<p></p>


 <div id="detailArea"></div>

<div class="hideShowToggle">
<button id="hideShowGrid">Hide/Show Grid</button>
</div>

  <div id="myGrid" style="height:500px;"></div> 
<p></p>

</div>

    <script src="../js/jquery-1.10.2.min.js"></script>

    <script src="../SlickGrid-master/lib/jquery-1.7.min.js"></script>
    <script src="../SlickGrid-master/lib/jquery.event.drag-2.2.js"></script>

    <script src="../SlickGrid-master/slick.core.js"></script>
    <script src="../SlickGrid-master/slick.editors.js"></script>
    <script src="../SlickGrid-master/slick.grid.js"></script>
    <!-- jqplot stuff -->
    
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="excanvas.js"></script><![endif]-->
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.jqplot.min.js"></script>
    

    
    <script type="text/javascript" src="../js/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script type="text/javascript" src="../js/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
    <script type="text/javascript" src="../js/plugins/jqplot.highlighter.min.js"></script>
    <script type="text/javascript" src="../js/plugins/jqplot.cursor.min.js"></script>
    <script type="text/javascript" src="../js/plugins/jqplot.bubbleRenderer.min.js"></script>
<script type="text/javascript" src="../js/plugins/jqplot.dateAxisRenderer.min.js"></script>

    <!-- Trying to get a bloody paginator to work! -->
    <script src="../js/jqPagination-master/js/jquery.jqpagination.js"></script>

    <!-- I use Stuart Banerman's hashcode to map award names to colors reliably: https://github.com/stuartbannerman/hashcode -->
    <script src="../js/hashcode-master/lib/hashcode.min.js"></script>
<script>

// WARNING!!! This is needed to make forEach work on IE8.
// This is from the Mozilla site.  I have no idea if this 
// is a better idea than replaces forEach'es everywhere or not.
if (!Array.prototype.forEach) {
    Array.prototype.forEach = function (fn, scope) {
        'use strict';
        var i, len;
        for (i = 0, len = this.length; i < len; ++i) {
            if (i in this) {
                fn.call(scope, this[i], i, this);
            }
        }
    };
}

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

// This should really be read via an AJAX call to all it to be independent of 
// Prices Paid...That is a step to getting open-source involvement.
var standardFieldDescriptor = [];
standardFieldDescriptor["score"] = "Relevance";
standardFieldDescriptor["unitPrice"] = "Unit Price";
standardFieldDescriptor["unitsOrdered"] = "Units Ordered";
standardFieldDescriptor["orderDate"] = "Date";
standardFieldDescriptor["vendor"] = "Vendor";
standardFieldDescriptor["productDescription"] = "Product Description";
standardFieldDescriptor["longDescription"] = "Long Description";
standardFieldDescriptor["contractingAgency"] = "Contracting Agency";
standardFieldDescriptor["awardIdIdv"] = "Award ID/IDV";
standardFieldDescriptor["commodityType"] = "Commodity Type";
standardFieldDescriptor["psc"] = "PSC";

var nonStandardFieldDescriptor = [];
nonStandardFieldDescriptor["dataSource"] = "Data Source";


// What I really want to do here is to cycle through a palette of 16 colors.
// There is no reason not to use whatever jqplot uses, although I don't 
// want to become dependent on it here.
var standardColors = [];
standardColors[0] =  'aqua';
standardColors[1] =   'black';
standardColors[2] =   'blue';
standardColors[3] =   'fuchsia';
standardColors[4] =   'gray';
standardColors[5] =   'green';
standardColors[6] =   'lime'; 
standardColors[7] =  'maroon';
standardColors[8] =   'navy';
standardColors[9] =   'olive'; 
standardColors[10] =  'orange';
standardColors[11] =   'purple';
standardColors[12] =   'red';
standardColors[13] =   'silver';
standardColors[14] =   'teal';
// standardColors[15] =   'white';
standardColors[15] =   'yellow';

var NUM_STANDARD_COLORS = 16;

// The current desire is that 

var data = [];
var transactionData = [];
var internalFieldLabel = [];
internalFieldLabel["starred"] = "Favorite";
internalFieldLabel["color"] = "Color";

$("#hideShowGrid").click(function() { 
    $("#myGrid").toggle();
});

$("#hideShowDetails").click(function() { 
    $("#detailArea").toggle();
});

$("#hideShowGraph").click(function() { 
    $("#chartContainer").toggle();
});

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

// Not sure the best way to do this, may want to check with Marty.
function renderCustomField(name,fieldSeparator,value) {
    var html = "";
    html +=      ' <div  class="customField">';
    html +=      ' <span  class="fieldName">';
    html +=  (name in nonStandardFieldDescriptor) ? nonStandardFieldDescriptor[name] : name;
//    html += name;

// This could be done with a .css after class, but I'm not sure
// it is browser compliant...
    html += fieldSeparator;

    html +=      ' </span>';
    html +=      ' <span  class="fieldValue">';
    html += value;
    html +=      ' </span>';
    html +=      '</div>';
    return html;
}

function renderDetailArea(dataRow,i) {
    var fieldseparator = " : ";
    var html = "";
    html +=      ' <div  class="itemDetailArea">';
    html += renderCustomField('Long Description',fieldseparator, dataRow.longDescription || "No Long Description.");

// Note this could be done more efficiently, and 
// we will someday want a list of custom fields for other purposes, but 
// this is good enough for now...
    for (var k in dataRow) {
        if (!((k in standardFieldDescriptor) || (k in internalFieldLabel))) {
	    var v = dataRow[k];
// This is just to see what will happen, I will have to add proper titles later.
            var label = (k in standardFieldDescriptor) ? standardFieldDescriptor[k] : k;
	    html += renderCustomField(label,fieldseparator,v);
	}
    }

    html +=      '</div>';
    return html;
}


function detailItemHandler(e) {
    var num = "itemDetails".length;
    var scratch = $(this).attr('id').substring(num);
    var id = itemDetailAssociation[scratch];
    var expandableSection = $("#expandArea"+scratch);
    if (expandableSection.html().length != 0) {
	expandableSection.empty();
    } else {
	expandableSection.append(renderDetailArea(transactionData[id],id));
    }
}

var grid;
var currentColumn = "score";

var standardCommodities = {
    // CPU seems to requie both 7020 and 7025!  This 
    // is why commoditype could end up being a problem for us!
    All: '*',
    CPU: '*702*',
    Software: '*7030*',
    // DANGER!  HACK!
    // Note: the FedBid data has IT supplies lists under 7045.
    // The reality is we need a separate icon for that.  I will 
    // have to deal with that later..for now, I want to reach
    // the OS2 data...
    Supplies: '*7510*',
    Punchcards: '*7040*',
    // Not sure this is correct for Configuration....
    Configuration: '*7010*',
    MiniMicro: '*7042*',
    Component: '*7050*'
};

var currentCommodityId = '{{commodity_id}}';

var com = $("#commodityChoice").val(currentCommodityId);

function performSearch() {
    $('#loading').show();
    $('#results-header').hide();
    timeSearchBegan = new Date();
    var standard = standardCommodities[currentCommodityId];

    var search = $('#small_search_string').val();
    $('#search_string_render').text(search);
    $.post("apisolr",
	   { search_string: search,
             user: '{{user}}',
             password: '{{password}}',
             psc_pattern: standard
	   },
	   processAjaxSearch
	  ).fail(function() { alert("The search failed in some way; please try something else."); });
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
	if (!isAsc) 
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
	if (!isAsc) 
	    return -1*ret;
	else 
	    return ret;
    }
    transactionData.sort(currentSortCol == "unitPrice" || 
			 currentSortCol == "unitsOrdered" ? numberSort : stringSort);
}

    function renderRow(label,content) {
	var row = "";
	row += "<tr>";
	row += "<td>";
	row += label;
	row += "</td>";
	row += "<td>";
	row += content;
	row += "</td>";
	row += "</tr>";
	return row;
    }
    // These strings really need to transferred to the server
    // In order for us to have proper abstraction and language translation    


    function renderStyledDetail(dataRow,scratchNumber) {
	var html = "";
	html +=      ' <div class="result">';
	html +=      '<img src="theme/img/placeholder120x120.png" class="result-image" >';
	html +=      '<p class="result-details"><strong> '+dataRow.productDescription.substring(0,40)+' </strong> '+dataRow.longDescription.substring(0,130)+' </p>';
	html +=      '<div class="result-meta">';
	html +=          '<p class="result-unitscost"><strong> $'+dataRow.unitPrice+'</strong> '+dataRow.unitsOrdered+' units</p>';
	html +=          '<p class="result-whenwho">'+dataRow.orderDate+'<strong>'+dataRow.contractingAgency.substring(0,30)+'</strong></p>';
	html +=      '</div>';
	html +=      '<div style="clear:both;"></div>';
	html +=      '<div class="result-smallprint">';
	html +=          '<span class="indicator red" style="background-color:'+dataRow.color+';" ></span>';
	html +=          '<p><strong>Vendor:</strong> '+dataRow.vendor.substring(0,35)+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Award ID/IDV:</strong> '+dataRow.awardIdIdv+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>PSC:</strong> '+dataRow.psc+ '</p>';
	var itemDetails = "itemDetails"+scratchNumber;
	var expandArea = "expandArea"+scratchNumber;
	html +=          '<span class="result-more">Display Item Details  <img id="'+itemDetails+'" src="theme/img/display-details.png" /></span>';
        html += '<span id="'+expandArea+'"></span>';
	html +=          '<div style="clear:both;"></div>';
	html +=      '</div>';
	return html;
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
    $('#loading').hide();
    $('#results-header').show();
    timeSearchEnded = new Date();
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
    $('#paginationHolder').html(html);
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
	    if (parseFloat(a["score"]) < parseFloat(b["score"])) {
		ret = 1;
	    } else if (parseFloat(a["score"]) > parseFloat(b["score"])) {
		ret = -1;
	    } else {
		ret = 0;
	    }
	    return ret;
	});

    var sumOfUnitPrice = 0.0;
    transactionData.forEach(function(d) { 
	var x = parseFloat(d["unitPrice"]);
	if (!isNaN(x))
	    sumOfUnitPrice += x 
    });

    function medianSortedValues(values) {
	var half = Math.floor(values.length/2);
	if(values.length % 2)
	    return parseFloat(values[half]["unitPrice"]);
	else
	    return (parseFloat(values[half-1]["unitPrice"]) + 
		    parseFloat(values[half]["unitPrice"])) / 2.0;
    }

    var medianUnitPrice = (transactionData.length > 0) ? medianSortedValues(transactionData)
	: 0.0;

// This should come from the server!!!
    var transactionColumns = [
        {id: "score", name: standardFieldDescriptor["score"], field: "score", width: 100},
        {id: "unitPrice", name: standardFieldDescriptor["unitPrice"], field: "unitPrice", width: 100},
        {id: "unitsOrdered", name: standardFieldDescriptor["unitsOrdered"], field: "unitsOrdered", width: 60},
        {id: "orderDate", name: standardFieldDescriptor["orderDate"], field: "orderDate", width: 60},
        {id: "vendor", name: standardFieldDescriptor["vendor"], field: "vendor", width: 200},
        {id: "productDescription", name: standardFieldDescriptor["productDescription"], field: "productDescription", width: 400},
        {id: "longDescription", name: standardFieldDescriptor["longDescription"], field: "longDescription", width: 400},
        {id: "contractingAgency", name: standardFieldDescriptor["contractingAgency"], field: "contractingAgency",
	 width: 200},
        {id: "awardIdIdv", name: standardFieldDescriptor["awardIdIdv"], field: "awardIdIdv", width: 100},
        {id: "commodityType", name: standardFieldDescriptor["commodityType"], field: "commodityType", width: 100},
        {id: "psc", name: standardFieldDescriptor["psc"], field: "psc", width: 80},
        {id: "dataSource", name: nonStandardFieldDescriptor["dataSource"], field: "dataSource", width: 150}
    ];
    var controlColumns = [ {id: "starred",name: "Starred", field: "starred",width: 40 } ];
    
    var columns = controlColumns.concat(transactionColumns);

    // Now I attempt to make every column sortable
    columns.forEach(function (c) {
        c.sortable = true;
    });    

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
    var clickcount = 0;
    var currentColumn = "score";
    var currentOrder = []; // 1 is ascending, -1 is descending
    $("#dropdownWrapper").click(function(){
	if ((clickcount % 2) == 1) {
	    var col = $("#sortColumn").val();
	    if (col == currentColumn) {
		if (col in currentOrder) {
                    currentOrder[col] = -1*currentOrder[col];
		} else {
                    currentOrder[col] = 1;
		}
	    }
	    currentColumn = col;
	    if (!(col in currentOrder)) {
		currentOrder[col] = 1;
	    }
	    sortByColumnAndRedraw(col,currentOrder[col] == 1);
	    grid.setData(transactionData);
	    grid.invalidateAllRows();
	    grid.render();
	    redrawDetailArea(currentPage);
	}
	clickcount++;
    });



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

	if ((data.length < 15) || (e.unitPrice < (medianUnitPrice * 4.0))) {
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

    if (isIE8orLower) {
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
		label: 'Date'
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

    // Legend is a simple table in the html.
    // Dynamically populate it with the labels from each data value.
/*    $('#legendtable').empty();
    $.each(plotData[0], function(index, val) {
	$('#legendtable').append('<tr><td>'+val[3].label+'</td><td>'+val[1]+'</td></tr>');
    }
	  );
*/  

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
