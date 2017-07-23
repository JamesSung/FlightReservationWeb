<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
		<spring:url value="/resources/main.css" var="mainCSS" />
		<link href="${mainCSS}" rel="stylesheet" />
</head>
<body>
	<div class="warning">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Info:</strong> ${msg}<br/><br/>
	  <a href="searchFlight">Move to Home</a>
	</div>
</body>
</html>