<!DOCTYPE html> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PricesPaid</title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">
    <link href="theme/css/startPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    {{!goog_anal_script}}
</head>
<body>
    <!-- Start header -->
    <div id="header">
        <!-- Top part of header -->
        <div class="inner">
            <p id="pricespaid_logo"><img src="theme/img/logo_pricespaid.png" alt="PricesPaid" ></p>
            <span id="gsa_logo">Powered by <img src="theme/img/gsa_logo.png" alt="GSA" ></span>


        <!-- Nav of commodities -->
        <div id="nav">
                <ul id="commodities">
                    <li class="commodity" id="All"><a href="#"><img src="theme/img/icn_all.png" alt="All commodity types."><strong>All</strong></a></li>
                    <li class="commodity" id="CPU"><a href="#"><img src="theme/img/icon-cpu.png" alt="Computers, laptops, CPUs."><strong>CPU</strong></a></li>
                    <li class="commodity" id="Software"><a href="#"><img src="theme/img/icon-software.png" alt="Computer software."><strong>Software</strong></a></li>
                    <li class="commodity" id="Supplies"><a href="#"><img src="theme/img/icon-supplies.png" alt="Office supplies of all kinds."><strong>Supplies</strong></a></li>
                    <li class="commodity" id="Punchcards"><a href="#"><img src="theme/img/icon-punchcards.png" alt="Punchcards and equipment."><strong>Punchcards</strong></a></li>
                    <li class="commodity" id="Configuration"><a href="#"><img src="theme/img/icon-configuration.png" alt="Configuration machinery."><strong>Configuration</strong></a></li>
                    <li class="commodity" id="MiniMicro"><a href="#"><img src="theme/img/icon-minimicro.png" alt="Mini-Micro classed computers."><strong>Mini-Micro</strong></a></li>
                    <li class="commodity" id="Component"><a href="#"><img src="theme/img/icon-component.png" alt="Compute components."><strong>Component</strong></a></li>
                </ul>  
            </div>
        </div>
    </div>
<div style="clear:both"></div>
    <!-- Content ... below the header -->
    <div id="content" class="inner">
        <!-- Start search -->
        <div id="startpagesearch">
            <form id="searchform" method="post" action="PricesPaid">
                <input type="text" name="search_string" id="search_string" />
		<input type="hidden" name="antiCSRF" value="{{acsrf}}" />
		<input type="hidden" name="session_id" value="{{session_id}}" />
		<input type="hidden" name="commodity_id" id="commodity_id" />
                <img id="search_icon" src="theme/img/icn_search.png" alt="Execute the search."/>
            </form>
        </div>
    </div>

    <script src="../js/jquery-1.10.2.min.js"></script>
<script>
$('#commodities li').first().addClass("selected");
var currentlySelectedCommodityElement  = $('#All');

// Possibly this can also be removed, but it is slightly different...
$('#commodities li').click(function () {
    $('#'+currentlySelectedCommodityElement.attr('id')).removeClass("selected");
    currentlySelectedCommodityElement = $('#'+this.id);
    currentCommodityId = this.id;
    $('#'+this.id).addClass("selected");

    $('#commodity_id').val(currentlySelectedCommodityElement.attr('id'));
});

function formSubmit()
{ 
   if ($("#search_string").val().length != 0) {
        $("#searchform").submit();
   } else {
        alert("Please enter a search term!");
   }
}

$('#search_icon').click(formSubmit);

</script>
</body>
</html>
