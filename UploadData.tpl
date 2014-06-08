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

  <div class="container">
    <div class='row'>
      <div class='col-12-xs'>
        <img id="betastripe" src="theme/img/Beta2.0.png"  alt="Beta 2.0">
      </div>
    </div>





    <!-- Content ... below the header -->
    <div id="content">

<div>
PriceHistory requires a particular format for dynamic CSV upload.  You may find it helpful to use a <a href="http://deepinthecode.github.io/mr-csv-transformer/?targets=UNITS,PRICE,AGENCY,VENDOR,PSC,DESCR,LONGDESCR,DATE,AWARDIDIDV,MANUFACTURER_NAME,MANUFACTURER_PART_NUMBER,BUREAU,CONTRACT_NUMBER,TO_ZIP_CODE,FROM_ZIP_CODE,UNIT_OF_ISSUE">tool</a> created by David Young, Drew Shefman and Robert Read from the "Mr. Data Converter" tool to put your CSV file into the PriceHistory format.

</div>

<div>
     <textarea name="csv" id="csv" rows="20" cols="60"></textarea>
</div>
<input id="add_data" name="submit" value="Add This CSV File" class="input_submit" title="Click to upload Data!" type="submit" onclick="performAddData();">

<!-- end of "content" -->
</div>



<form method="get" id="fakeLogoutForm" action="./">
</form>
<form method="post" id="fakeReturnForm" action="./StartPageReturned">
    <input type="hidden" name="antiCSRF" value="{{acsrf}}" />
    <input type="hidden" name="session_id" value="{{session_id}}" />
</form>


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

    <!-- I use Stuart Banerman's hashcode to map award names to colors reliably: https://github.com/stuartbannerman/hashcode -->
    <script src="../js/hashcode-master/lib/hashcode.min.js"></script>

  <link href="../js/feedback_me/css/jquery.feedback_me.css" rel="stylesheet" type="text/css" />
  <script  src="../js/jquery-ui.min.js"></script>
  <script  src="../js/feedback_me/js/jquery.feedback_me.js"></script>
  <script  src="./js/StandardFunctions.js"></script>
  <script  src="./js/Utility.js"></script>
  <script  src="./js/header.js"></script>

 <script>

function performAddData() {
	 var csv = $("#csv").val();

      $.post("UploadCSVFile",
     { csv_file: csv
     },
     processAddResults
    ).fail(function() { alert("The data add failed in some way; please try something else."); });
    };

function processAddResults(data) {
}

$(document).ready(function(){
    $("#logoutLink").click(Logout);

    $("#return_to_search").click(function() {
     $('#fakeReturnForm').submit();
    });
});

</script>


</html>

