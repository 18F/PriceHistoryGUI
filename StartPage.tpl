<!DOCTYPE html> 
<html><head>
<!--
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PricesPaid v. 0.4 BETA Start</title>
    <meta name="robots" content="NOINDEX, NOFOLLOW">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="theme/css/startPage2.css" rel="stylesheet" type="text/css" media="screen, projection">

-->
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>PricesPaid v. 0.4 BETA Start</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="theme/css/baseline.css" rel="stylesheet">
    <link href="theme/css/startPage2.css" rel="stylesheet">
    {{!goog_anal_script}}
</head>

<body id="start">

<div id="header" role="menubar">
<div class="container">
	<h1><a href="" tabindex="1"><em>Prices</em>Paid</a></h1>
    <ul>
    	<li class="skip"> <a href="#content" title="Skip to content" tabindex="2">Skip to page content</a></li>
       <li class="profile"><a href="" title="User Profile" tabindex="3">{{username}}</a></li>
       <li class="logout" title="Logout"><span href="" tabindex="4">Logout</span></li>
    </ul>
</div>
</div>

<div id="content" role="main">
<div class="container">
	<div id="commodities">
		<h2>Step 1: Select a commodity type</h2>
        <h3>For more efficient and relevant results, select the 
commodity type that best represents the item your searching for from the list
 below, </h3>
        <ol class="clearfix" id="commoditylist">
            <li class="cpu" id="CPU"><span><h4>CPU</h4><p><strong>Ex:</strong> Computers, Laptops, Servers (PSC codes matching 702__).</p></span></li>
            <li class="supplies" id="Supplies"><span><h4>Supplies</h4><p><strong>Ex:</strong> 935,000 Office Supplies from GSA OS2  (PSC matching codes 7510_)</span></p></span></li>
	    <li class="component"  id="Component"><span><h4>Component</h4><p><strong>Ex:</strong> IT components (PSC matching codes 75050)</p></span></li>
            <li class="configuration" id="Configuration"><span><h4>Configuration</h4><p><strong>Ex:</strong> Miscellaneous (PSC matching codes 7010_)</p></span></li>
            <li class="minimicro"  id="MiniMicro"><span><h4>Mini-micro</h4><p><strong>Ex:</strong> Mini- and Micro- computer components (PSC matching codes 7042_)</p></span></li>
            <li class="punchcards" id="Punchcards"><span><h4>Punchcards</h4><p><strong>Ex:</strong> Yes, real punchcards, sometimes still used. (PSC matching codes 7040_)</p></span></li>
            <li class="software" id="Software"><span><h4>Software</h4><p><strong>Ex:</strong> Computer software (PSC matching codes 7030_)</p></span></li>
            <li class="all" id="All"><span><h4>All</h4><p><strong>Ex:</strong> Search all of our current data</p></span></li>
        </ol>


        	<h2>Step 2: Site Search</h2>

            <form id="searchform" method="post" action="PricesPaid">        

		<input type="hidden" name="antiCSRF" value="{{acsrf}}" />
		<input type="hidden" name="session_id" value="{{session_id}}" />
		<input type="hidden" name="commodity_id" id="commodity_id" />


        	<div><input name="search_string" id="search_string" placeholder="Search ..." maxlength="500" class="input_text" title="Search the database" type="text">

<input name="submit" value="Search" class="input_submit" title="Click here to search the database" type="submit"></div>
            </form>

	</div>
         
    <div id="footer">
    	<p>PricesPad is an official website of the U.S. Government, powered by GSA.</p>
    	<p><strong>Send Feedbak/Report Issues to:</strong> <a href="mailto:robert.read@gsa.gov">robert.read@gsa.gov</a></p>
    </div>   

</div>
</div>
</body>
    <script src="../js/jquery-1.10.2.min.js"></script>
<script>
var currentlySelectedCommodityElement;

// Possibly this can also be removed, but it is slightly different...
$('#commoditylist li').click(function () {
    if (typeof currentlySelectedCommodityElement != 'undefined') {
        $('#'+currentlySelectedCommodityElement.attr('id')).removeClass("selected");
    }
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

function Logout() {
      $.post("Logout",
	   { antiCSRF: '{{acsrf}}',
             session_id: '{{session_id}}'
	});
      alert("You are now securely logged out.");
}

$("#header ul li.logout").click(Logout);


</script>

</html>

