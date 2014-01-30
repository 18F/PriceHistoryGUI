<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PricesPaid v. 2.0 BETA </title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">

    <link rel="stylesheet" type="text/css" href="theme/css/bootstrap.css">
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
          </ul>
        </div><!-- /.navbar-collapse -->
      </nav>
    </div>


    <div id="sidebar" class="col-xs-3">
      <div id="sidebar_search">
        <span id="smallSearch">
          <input type="text" name="small_search_string" id="small_search_string" placeholder="Search ..." value="{{search_string}}" title=
          "
          Enter any number of search terms to get a list of results ranked by relevance to those terms. To limit a search to those only containing a certain terms, separate terms by the upper case AND, like &quot;laptop AND rugged&quot;.  To exclude results containing a term, put upper case NOT or - in front of it, like &quot;laptop AND NOT rugged&quot;



          To get more detailed help on searching, click the &quot;Help!&quot; link in the upper right of this page.
          "
          >

          <input id="searchButton" name="submit" value="Search" class="input_submit" title="Click here to search the database" type="submit" onclick="performSearch();">

        </span>
      </div>

      <div id='sidebar-manage-results'>
        <span>Limit results to: </span>
        <input type="text" id="num_results_to_return" placeholder="100" title="Change number of results returned here. More results will slow your response time. If you find yourself paging through too many results, try adding terms to your search to increase the relevancy of your results, excluding terms by putting a minus sign (-) in front of a term you want to exclude.">


        <div id="sidebarpaginator">   <span id="paginationHolder2"></span> </div>
        {{!portfolio_panel}}


        <a href="./theme/movies/PortfolioTutorial.mp4" target="_blank">Watch a tutorial on portfolios</a>

      </div>
    </div>
  </div>


  <div class="container">
    <div class='row'>
      <div class='col-12-xs'>
        <img id="betastripe" src="theme/img/Beta2.0.png"  alt="Beta 2.0">
      </div>
    </div>



    <!-- Content ... below the header -->
    <div id="content">

      <div id="loading">
        <h1>    Searching, Please Wait... </h1>
      </div>


   <div id="results-header">
    <span class="majorlabel" id="optionalPrefix">First &nbsp;</span>
    <span class="majorlabel" id="placeForNumberReturned"></span>
    <span class="majorlabel">&nbsp;Results </span>
    <span class="joininglabel">for </span>
    <span class="majorlabel" id="search_string_render"></span>

</div>


        <!-- Start results header -->
        <div id="sortcontrols">

  <span id="results-sortby">
   <label>Sort:</label>
   {{!column_dropdown}}
  </span>

  <span id="results-sortdir">
   <label>Order:</label>
   <span id="orderDropdownWrapper">
      <select id="sortOrder" >
          <option value="dsc">Descending</option>
          <option value="asc">Ascending</option>
     </select>
   </span>
  </span>
         </div>

<div id="detail-header">
  <span id="paginationHolder1">
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

<div style="clear:both"></div>

<div class="hideShowToggle">
<button id="hideShowGraph" >Hide/Show Graph</button>
</div>

<div id="chartContainer">
    <div id="chartdiv" ></div>
</div>

</div>

<!-- end of "content" -->
</div>



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

<div id="dialog">
Transaction Added to Portfolio.
</div>

{{!footer_html}}

</div>
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

// TODO: Update tooltip styles
$(function() {
   $( document ).tooltip({
       position: {
       my: "center bottom-20",
       at: "center top",
       tooltipClass: "p3-tooltip",
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

$(document).ready(function(){
    $("#logoutLink").click(Logout);

    $("#return_to_search").click(function() {
  $('#fakeReturnForm').submit();
    });

    $("#pricespaid_logo").click(function() {
  $('#fakeReturnForm').submit();
    });

   $( document ).tooltip({
       position: {
       my: "center bottom-20",
       at: "center top",
       tooltipClass: "p3-tooltip",
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
HANDLER_NAMESPACE_OBJECT.decoration_add_dialog_id = "#dialog";

PAGE_CONTEXT = {};
PAGE_CONTEXT.render_transaction_delete = false;

DEFAULT_NUM_RESULTS = 100;

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

$(document).ready(function(){
        get_portfolio_list();
//        get_tag_list(refreshDroppablesPortfolios);
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
                position: 'right-bottom',
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
$('#search_string_render').html('&ldquo;'+htmlEscape('{{search_string}}')+'&rdquo;');

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

function get_max_results() {
    var max_results = $('#num_results_to_return').val();
    var max_results_num = parseFloat(max_results);
    if (!isNumber(max_results_num)) {
       max_results_num = DEFAULT_NUM_RESULTS;
    }
     return max_results_num;
}

function performSearch() {
    $('#loading').show();
    $('#results-header').hide();
    timeSearchBegan = new Date();
    var standard = standardCommodities[currentCommodityId];

    var search = $('#small_search_string').val();
    var max_results_num = get_max_results();
    if (search.length == 0) {
      processAjaxSearch([]);
     } else {
      $('#search_string_render').html('&ldquo;'+htmlEscape(search)+'&rdquo;');
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
    var max_results_num = get_max_results();
    if (totalNumber >= max_results_num) {
       $('#optionalPrefix').show();
    } else {
       $('#optionalPrefix').hide();
    }


recreatePagination();

// Note: This counts the Page from 1, not zero!
// $(document).ready(function() {
  $('.pagination').jqPagination({
//    link_string : '/?page={page_number}',
    link_string : '',
    max_page  :  Math.ceil(totalNumber/PAGESIZE),
                currentPage     : 1,
    paged   : function(page) {
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


</html>
