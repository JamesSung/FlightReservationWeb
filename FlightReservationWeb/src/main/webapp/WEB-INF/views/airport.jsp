<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Airport List</title>
        <script type="text/javascript">
	        function deleteItem(id) {
	            document.forms["deleteItem"]["id"].value = id;
	            document.forms["deleteItem"].submit();
	        }

        </script>
        <style>
			table {
			    border-collapse: collapse;
			    width: 50%;
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
        <h2>Search for airports</h2>
        <form action="airport" method="GET">
            <input type="text" name="city" id="city" value="${city}" />
            <input type="submit" value="Search" />
        </form>
        <br/>
        <h2>Airport List</h2><br />
        <table>
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Name</th>
                    <th>City</th>
                    <th>Country</th>
                    <th> </th>
                </tr>
            </thead>
            <tbody>
	            <c:forEach items="${airportList}" var="airport">
	            <tr id="list_tr">
                    <td>${airport.code}</td>
                    <td>${airport.name}</td>
                    <td>${airport.city}</td>
                    <td>${airport.country}</td>
                    <td><a href="javascript:deleteItem('${airport.id}')">Delete</a></td>
                </tr>
				</c:forEach>
            </tbody>
        </table>
        <form name="deleteItem" action="deleteAirport" method="POST">
        	<input type="hidden" name="id" value=""/>
        	<input type="hidden" name="city" value="${city}"/>
        </form>
        <br />

        <h2>Add Airport</h2>
        <form action="addAirport" method="POST">

            <table>
            	<tr>
            		<td>Code: </td><td><input type="text" name="code" /></td>
            	</tr>
            	<tr>
            		<td>Name: </td><td><input type="text" name="name" /></td>
            	</tr>
            	<tr>
            		<td>City: </td><td><input type="text" name="city" /></td>
            	</tr>
            	<tr>
            		<td>Country: </td><td><input type="text" name="country" /></td>
            	</tr>
            	<tr>
            		<td> </td><td><input type="submit" value="Submit"/></td>
            	</tr>
            </table>
        </form>

    </body>
</html>