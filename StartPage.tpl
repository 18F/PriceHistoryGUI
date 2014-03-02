<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>PricesPaid v. 2.0 BETA Start</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="theme/css/bootstrap.css">
    <link href="./theme/css/shared.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link href="./theme/css/mainPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    {{!goog_anal_script}}
</head>

<body id="start">
<img id="betastripe" src="theme/img/Beta2.0.png"  alt="Beta 2.0">

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
      </div>
    </nav>
  </div>
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

</div>

{{!footer_html}}
</body>
    <script src="../js/jquery.min.js"></script>
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

