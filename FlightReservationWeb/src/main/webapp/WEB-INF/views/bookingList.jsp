<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
    <head>
        <title>Flight Reservation System</title>
        <link rel="stylesheet" type="text/css" href="/WEB-INF/css/style.css"/>
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
	    <div  id="menu">
		 	<a href="searchFlight"> HOME </a> 
		 | 	<a href="bookingList"> MY BOOKINGS </a>
			<c:choose>
			    <c:when test="${empty sessionScope.name}">
			 	| 	<a href="login"> LOGIN </a>
			    </c:when>    
			    <c:otherwise>
			 	| 	<a href="logout"> LOGOUT </a>
			    </c:otherwise>
			</c:choose>
		 | 	<a href="signup"> SIGN UP </a>
		</div> 
        <h3>Booking List: </h3>
		<c:choose>
		    <c:when test="${empty sessionScope.email}">
		        <form name="addItem" action="bookingList" method="POST" onSubmit="return searchBooking()">
		            Email: <input type="text" name="booker" id="booker" value="${booker}"/>
		       		Password: <input type="password" name="password" id="password" value="${password}"/>
		        	<input class="button" type="submit" value="Search" />
		        </form>
		    </c:when>    
		    <c:otherwise>
        		<h4>${ name }, ${ email }</h4>
		    </c:otherwise>
		</c:choose>        
        <table>
            <tbody>
	            <c:forEach items="${bookingList}" var="booking" varStatus="statusB">
	            <tr class="booking"><td class="left">Booking ${statusB.count} </td>
	            				 <td class="right"> ${booking.booker}, ${booking.bookDate} </td></tr>

	            <c:forEach items="${booking.flights}" var="flight" varStatus="statusF">
	            <tr id="list_tr"><td class="left">Flight ${statusF.count} </td><td> </td></tr>
	            <tr id="list_tr">
                    <td class="left">
                    ${flight.planeName} <br/>
                    ${flight.company} <br/>  
                    From: ${flight.departure.name}(${flight.departure.code}) <br/>
                    To: ${flight.arrival.city}(${flight.arrival.code}) <br/>
                    Date: ${flight.departureDate}
                    <input type="hidden" name="id" value="${flight.id}"/>
                    </td>
                    <td class="right">Price: ${flight.price} CAD<br/> </td>

                </tr>
				</c:forEach>
				<tr class="blank"><td></td><td> </td></tr>
				
				</c:forEach>
            </tbody>
        </table>
        <form name="addItem" action="searchFlight" method="GET" >
        	<input class="button" type="submit" value="Home" />
        </form>

	</div>
	<div id="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Info:</strong> Please fill the email and password.
	</div>
	
    </body>
</html>