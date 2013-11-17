<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>PricesPaid v. 0.5 BETA Start</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="./theme/css/shared.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link href="./theme/css/mainPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    {{!goog_anal_script}}
</head>

<body id="start">

<div id="header">
        <!-- Top part of header -->
        <!-- FACTOR OUT -->
            <span id="pricespaid_logo"><img src="theme/img/pp_logo_beta.png" alt="PricesPaid"></span>
<div id="logoutLink" href="./Logout">Logout</div>
</div>

<form method="get" id="fakeLogoutForm" action="./">
</form>
<form method="post" id="fakeReturnForm" action="./PricesPaid">
    <input type="hidden" name="antiCSRF" value="{{acsrf}}" />
    <input type="hidden" name="session_id" value="{{session_id}}" />
</form>

<div id="content" class="inner">

<div id="introtextblock">
	  <h3>Welcome to the Prices Paid (P3) website!</h3>
	  <h3>The database currently contains these datasets:</h3>
	  <h3>Begin by entering the term you want to search for.</h3>
    <ul>
    	<li>OS2 -- Office Supply data from the Strategic Sourcing Initiative (FSSI).</li>
       <li>GSA Advantage -- One calendar quarter of data.</li>
       <li>Reverse Auction -- IT equipment purchased via reverse auction.</li>
       <li></li>
    </ul>
</div>
            <form id="bigsearchform" method="post" action="PricesPaid">        
		<input type="hidden" name="antiCSRF" value="{{acsrf}}" />
		<input type="hidden" name="session_id" value="{{session_id}}" />
		<input type="hidden" name="commodity_id" id="commodity_id" />
        	<div><input name="search_string" id="search_string" 
			    placeholder="Search ..." maxlength="500" 
			    class="input_text" title="Search the database" type="text">

<input id="bigsearchbutton" name="submit" value="Search" class="input_submit" title="Click here to search the database" type="submit"></div>
            </form>

{{!footer_html}}

</div>
</body>
    <script src="../js/jquery-1.10.2.min.js"></script>
	<script  src="./js/header.js"></script>
<script>

$(document).ready(function(){
    $("#logoutLink").click(Logout);

    $("#pricespaid_logo").click(function() { 
	$('#fakeReturnForm').submit();
    });
});

function formSubmit()
{ 
    if ($("#search_string").val().length != 0) {
        $("#bigsearchform").submit();
   } else {
        alert("Please enter a search term!");
   }
}

$('#bigsearchbutton').click(formSubmit);


$("#header ul li.logout").click(Logout);


</script>

</html>

