<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Flight List</title>
        <script type="text/javascript">
	        function deleteItem(id) {
	            document.forms["deleteItem"]["id"].value = id;
	            document.forms["deleteItem"].submit();
	        }

        </script>
        <style>
			#list {
			    border-collapse: collapse;
			    width: 70%;
			}
			
			th, td {
			    text-align: left;
			    padding: 8px;
			}
			
			#list_tr:nth-child(even){background-color: #f2f2f2}
			
			th {
			    background-color: grey;
			    color: white;
			}
            input[type=text] {
                width: 200px;
                padding: 5px 10px;
                margin: 2px 0;
                box-sizing: border-box;
                border: none;
                background-color: lightgrey;
                color: white;
            }
            input[type=submit]:hover {
                color: hotpink;
            }              
            a {
    			text-decoration: none;
                color: darkblue;
			}
            a:hover {
    			color: hotpink;
			}		
        </style>
    </head>
    <body>
        <h2>Search for Flights</h2>
        <form action="flight" method="GET">
            <input type="text" name="departure" value="${departure}" />
            <input type="text" name="arrival" value="${arrival}" />
            <input type="text" name="departureDate" value="${departureDate}" />
            <input type="submit" value="Search" />
        </form>
        <br/>
        <h2>Flight List</h2><br />
        <table id="list">
            <thead>
                <tr>
                    <th>Plane</th>
                    <th>Company</th>
                    <th>Departure</th>
                    <th>Arrival</th>
                    <th>departure Date</th>
                    <th>Price</th>
                    <th> </th>
                </tr>
            </thead>
            <tbody>
	            <c:forEach items="${flightList}" var="flight">
	            <tr id="list_tr">
                    <td>${flight.planeName}</td>
                    <td>${flight.company}</td>
                    <td>${flight.departure.name}(${flight.departure.code})</td>
                    <td>${flight.arrival.city}(${flight.arrival.code})</td>
                    <td>${flight.departureDate}</td>
                    <td>${flight.price}</td>
                    <td><a href="javascript:deleteItem('${flight.id}')">Delete</a></td>
                </tr>
				</c:forEach>
            </tbody>
        </table>
        <form name="deleteItem" action="deleteFlight" method="POST">
        	<input type="hidden" name="id" value=""/>
        	<input type="hidden" name="departure.code" value="${departure}"/>
        	<input type="hidden" name="arrival.code" value="${arrival}"/>
        	<input type="hidden" name="departureDate" value="${departureDate}"/>
        </form>
        <br />

        <h2>Add Flight</h2>
        <form action="addFlight" method="POST">

            <table>
            	<tr>
            		<td>Plane Name: </td><td><input type="text" name="planeName" /></td>
            	</tr>
            	<tr>
            		<td>Company: </td><td><input type="text" name="company" /></td>
            	</tr>
            	<tr>
            		<td>Departure: </td><td><input type="text" name="departureCode" /></td>
            	</tr>
            	<tr>
            		<td>Arrival: </td><td><input type="text" name="arrivalCode" /></td>
            	</tr>
            	<tr>
            		<td>Departure Date: </td><td><input type="text" name="departureDate" /></td>
            	</tr>
            	<tr>
            		<td>Price: </td><td><input type="text" name="price" /></td>
            	</tr>
            	<tr>
            		<td> </td><td><input type="submit" value="Submit"/></td>
            	</tr>
            </table>
        </form>

    </body>
</html>