<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
    <head>
        <title>Flight Reservation System</title>
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
    <div  class="center">
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
        <h4>Hi ${ name }, Search for Flights! </h4>
        <form action="searchFlight" method="GET">
            Fr: 
            <select name="departure">
			    <option value="all" ${'all' == departure ? 'selected="selected"' : ''}>All</option>
			    <c:forEach items="${airportList}" var="airport" >
			        <option value="${airport.code}" ${airport.code == departure ? 'selected="selected"' : ''}>${airport.name}</option>
			    </c:forEach>
			</select>
            To: 
            <select name="arrival">
			    <option value="all" ${'all' == departure ? 'selected="selected"' : ''}>All</option>
			    <c:forEach items="${airportList}" var="airport" >
			        <option value="${airport.code}" ${airport.code == arrival ? 'selected="selected"' : ''}>${airport.name}</option>
			    </c:forEach>
			</select>
			Dep: <input type="text" name="departureDate" id="datepicker" value="<fmt:formatDate value="${departureDate}" pattern="MM/dd/yyyy"/>">
			Rtn: <input type="text" name="returnDate" id="datepicker2" value="<fmt:formatDate value="${returnDate}" pattern="MM/dd/yyyy"/>">
            <input class="button" type="submit" value="Search" />
        </form>
        <!--h3>Flight List: </h3-->
        <form name="addItem" action="confirmBooking" method="POST" onSubmit="return checkItems()">
        <table>
            <thead>
                <tr>
                    <th> </th>
                    <th>Plane</th>
                    <th>Company</th>
                    <th>Price(CAD)</th>
                    <th>Departure</th>
                    <th>Arrival</th>
                    <th>Departure Date</th>
                </tr>
            </thead>
            <tbody>
	            <c:forEach items="${flightList}" var="flight">
	            <tr id="list_tr">
                    <td><input type="checkbox" name="id" value="${flight.id}"/></td>
                    <td>${flight.planeName}</td>
                    <td>${flight.company}</td>
                    <td>${flight.price}</td>
                    <td>${flight.departure.name}(${flight.departure.code})</td>
                    <td>${flight.arrival.name}(${flight.arrival.code})</td>
                    <td>${flight.departureDate}</td>
                </tr>
				</c:forEach>
            </tbody>
        </table>
        	<input type="hidden" name="departure" value="${departure}"/>
        	<input type="hidden" name="arrival" value="${arrival}"/>
        	<input type="hidden" name="departureDate" value="${departureDate}"/>
        	<input type="hidden" name="returnDate" value="${returnDate}"/>
        	<input class="button" type="submit" value="Booking" />
        </form>
		<p> Note: Because there are not many flights in my company, <br/>
    	we are displaying all the flights departing between departure and return date. Thank you!!
		</p>
	</div>
	
	<div id="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Info:</strong> Please select flights on the list.
	</div>
	
	<div id="site">
	  <strong>powered by JQuery, Spring, Hibernate OGM, and MongoDB</strong> <a href="https://github.com/JamesSung">.</a>
	</div>
 	
    </body>
</html>