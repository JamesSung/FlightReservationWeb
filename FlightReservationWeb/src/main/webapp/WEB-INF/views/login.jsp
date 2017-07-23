<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title> Login </title>
<meta charset="UTF-8">
		<spring:url value="/resources/main.css" var="mainCSS" />
		<link href="${mainCSS}" rel="stylesheet" />
</head>
<body>
<script>

  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);

    if (response.status === 'connected') {

      success();
    } else {

      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    }
  }

  function checkLoginState() {
	console.log('checkLoginState');
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
	  FB.init({
	    appId      : '314840615628328',
	    cookie     : true,  // enable cookies to allow the server to access 
	                        // the session
	    xfbml      : true,  // parse social plugins on this page
	    version    : 'v2.8' // use graph api version 2.8
	  });

	  FB.getLoginStatus(function(response) {
	    statusChangeCallback(response);
	  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  function success() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me?fields=id,name,email,permissions', function(response) {
      console.log('Successful login for: ' + response.name);
  
      var script = document.createElement('script');
      script[(script.innerText===undefined?"textContent":"innerText")] =
          'document.getElementById("email").value = escape(\"'+ response.email + '\")' +
          '; document.getElementById(\"name\").value = \"'+ response.name + 
          '\"; document.getElementById(\"login\").submit();';
      document.documentElement.appendChild(script);

      document.getElementById('status').innerHTML = 
        'Thanks for logging in, ' + response.name + ', ' + response.email + ' !';
    });
    
  }

  function login(){
	  FB.login(function(response) {
		  if (response.status === 'connected') {
			  success();
		  } else {
		      document.getElementById('status').innerHTML = 'Login has fialed ' +
		        'please try again. ';
		  }
		}, {scope: 'email'});
  }
</script>

<div  class="login">
	<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
	</fb:login-button>
	<div id="status">
	</div>
	<br/><br/>
	<form name="loginD" action=loginConfirm method="post">
		Email: <input name="email" type="text" />
		Password: <input name="password" type="password" />
		<input class="button" type="submit" value="Login" />
	</form>	
</div>

<form id="login" action="greeting" method="post">
	<input id="email" name="email" type="hidden" />
	<input id="name" name="name" type="hidden" />
</form>

</body>
</html>