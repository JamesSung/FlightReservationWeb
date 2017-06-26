	        $(function () {
	            $("#datepicker").datepicker();
	            $("#datepicker2").datepicker();
	        });
	        
	        function checkItems() {

		        if ( $('input[name="id"]').is(':checked') ) {
		        	//alert("Good!!");
		        	return true;
		        } else {
		        	//alert("Please select flights on the list!!");
		        	$('#alert').css('visibility','visible');
		        	$( '#alert' ).show();
		        	
			    }


		        return false;
	        }

	        function confirmBooking() {

		        if ( $("#booker").val() == "" || $("#password").val() == "" ) {
		        	$('#alert').css('visibility','visible');
		        	$( '#alert' ).show();
		        	return false;
		        } 

		        return true;
	        }

	        function searchBooking() {

		        if ( $("#booker").val() == "" || $("#password").val() == "" ) {
		        	$('#alert').css('visibility','visible');
		        	$( "#alert" ).show();
		        	return false;
		        } 

		        return true;
	        }
	        