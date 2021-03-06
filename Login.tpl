<!DOCTYPE html> 
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
       <title>Prices Paid - Login</title>
       <meta name="robots" content="NOINDEX, NOFOLLOW">
       <link href="/gui/theme/css/loginPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    <link href="./theme/css/shared.css" rel="stylesheet" type="text/css" media="screen, projection">
    <script src="../js/jquery.min.js"></script>
    {{!goog_anal_script}}
<style>
ul.button-list {
    margin: 1em 0;
    padding: .5em 0
}

ul.button-list a {
    display: block;
    background: #F8F7F7;
    background: rgba(255, 255, 255, 0.8);
    padding: .5em;
    text-align: center;
    color: #5A4A42;
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.9);
    border: 1px solid #ADAEAE;
    border: 1px solid rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2) inset;
    font-weight: normal
}
</style>
    </head>
    <body>
<img id="betastripe" src="theme/img/Beta2.0.png" alt="Beta 2.0">

<div id="instructions">
<p id="message">{{message}}</p>

<h2>
Welcome to an instance of PricesPaid
</h2>

<p>
This is Beta software.  Please help us improve it by using the Feedback widget on the left side of the main search page.
</p>

<p>
If you have longer feedback, a technical question, or need technical support, please email  &lt;{{feedback_email}}v&gt;.
</p>

</div>

{{!extra_login_methods}}

  <form id="fakeLoginViaMaxForm" action="/gui/LoginViaMax" method="get">
  </form>

{{!footer_html}}

<script>
% import ppGuiConfig

if ('{{ppGuiConfig.BASIC_DISPLAY_VALUE}}' == 'T') {
  $("#basic").show();
} else {
  $("#basic").hide();
}
if ('{{ppGuiConfig.GITHUB_DISPLAY_VALUE}}' == 'T') {
  $("#github").show();
} else {
  $("#github").hide();
}
if ('{{ppGuiConfig.MYUSA_DISPLAY_VALUE}}' == 'T') {
  $("#myUSA").show();
} else {
  $("#myUSA").hide();
}
if ('{{ppGuiConfig.MAX_DISPLAY_VALUE}}' == 'T') {
  $("#max").show();
} else {
  $("#max").hide();
}

$("#github").click(function () {


// NOTE: This is a valuable example of how to use OAuth.  However, 
// it is not currently used by P3.
// var res = OAuth.initialize('{{!ppGuiConfig.GITHUB_APPLICATION__PUBLIC_KEY}}');

// OAuth.popup('github', 
//   function(err, result) {
//    if (err) {
//       alert("Sorry, authentication failed: "+err);
//    } else {
// // Here we could actually use the access_token to the get the user name, which is 
// // whhat we really need to do.
//    var obj = result.get(result.access_token); 
//    alert("result.access_token ="+ result.access_token);
//   }
//  });


});


$("#max").click(function () {
  $('#fakeLoginViaMaxForm').submit();
});
</script>

</body>
</html>
