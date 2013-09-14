<!DOCTYPE html> 
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
       <title>Prices Paid v. 0.2 BETA - Login</title>
       <meta name="robots" content="NOINDEX, NOFOLLOW">
       <link href="/gui/theme/css/loginPage.css" rel="stylesheet" type="text/css" media="screen, projection">
    {{!goog_anal_script}}
    </head>
    <body>


<div id="loginLayout">
 <div id="loginLogo">
</div>
<div id="instructions">
<p id="message">{{message}}</p>

<span id="loginText">
This is a secure and limited Beta prototype.  Only invitees are allowed to use this prototype at present.  To get access, email Robert L. Read &lt;robert.read@gsa.gov&gt;.
 </span>
</div>
<div id="credentials">
<form action="/gui/StartPage" method="post">
<div class="blockyLabelBox">
  <span>Username:</span>
  <input type="text" name="username"/>
</div>
<div  class="blockyLabelBox">
  <span>Password:</span>
  <input type="text" name="password"/>
</div>
  <input class="loginButton" type="submit" value="LOGIN" />
</form>
</div>
</div>

</body>
</html>
