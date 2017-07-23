<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
    <head>
        <title>Flight Reservation System</title>
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<!-- script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js" type="text/javascript"></script-->
		<spring:url value="/resources/main.css" var="mainCSS" />
		<spring:url value="/resources/main.js" var="mainJS" />
		<link href="${mainCSS}" rel="stylesheet" />
		<script src="${mainJS}"></script>
    </head>
    <body>
    <h1>Flight Reservation System</h1>
    <div  class="ticket">
        <h4>Flight List: "${ name }"</h4>
        <form name="addItem" action="addBooking" method="POST" onSubmit="return confirmBooking()">
        <table>
            <tbody>
	            <c:forEach items="${flightList}" var="flight" varStatus="status">
	            <tr id="list_tr"><td class="left">Flight ${status.count} </td><td> </td></tr>
	            <tr id="list_tr">
                    <td class="left">
                    ${flight.planeName} <br/>
                    ${flight.company} <br/>  
                    From: ${flight.departure.name}(${flight.departure.code}) <br/>
                    To: ${flight.arrival.city}(${flight.arrival.code}) <br/>
                    Date: ${flight.departureDate}
                    <input type="hidden" name="flightid" value="${flight.id}"/>
                    </td>
                    <td class="right">Price: ${flight.price} CAD<br/> </td>

                </tr>
				</c:forEach>
            </tbody>
        </table>
        	<input class="button" type="button" value="Back" onClick="javasctipt: window.history.back()"/>
       	    <c:if test="${empty sessionScope.email }">
	        	Email: <input type="text" name="booker" id="booker" value="${booker}"/>
	       		Password: <input type="password" name="password" id="password" value="${password}"/>
	        </c:if>
        	<input class="button" type="submit" value="Confirm" />
        </form>
        <br />

	</div>
	
	<div id="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Info:</strong> Please fill the email and password.
	</div>

	
    </body>
</html>