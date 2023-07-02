<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payee</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://use.fontawesome.com/171b742c08.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-0QrgmqUclLu71y4nKTzL5/oyUJlSqPzzAfPjhbFfVNT9H5YsXeZ0fSGdUTNwlqf9UCVd1yq3orATG0cNjY1FlQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script type="text/javascript" src="/js1/font.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    
    <style>
    
    body{
      		background-image: url("https://emea.exelatech.com/sites/default/files/exela-blogs/LP%20Image.png");
        	background-size: cover;
        	width: 100vw;
            height: 100vh;
        	background-repeat: no-repeat;
      	}
    
    </style>
</head>
<body>
        <%
        // Clear browser cache
   		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
   		response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
   		response.setHeader("Expires", "0"); // Proxies.

   		if (session.getAttribute("user")  == null ){
   		%>
   		<c:redirect url = "/login"/>
   		<%
   		}
   		%>
<div class="container">
    <jsp:include page="headerUser.jsp"></jsp:include>
    <br><br><br>
    <h3 class="text-center text-white" style="font-family: Arial;">Payee List</h3>
    <table class="table table-striped table-bordered text-white">
        <thead>
        <tr>
            <th>Id</th>
            <th>Firstname</th>
            <th>LastName</th>
            <th>Age</th>
            <th>Phone</th>
            <th>Activate</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="payee" items="${payeeList}">
            <tr>
                <td>${payee.id}</td>
                <td>${payee.firstName}</td>
                <td>${payee.lastName}</td>
                <td>${payee.age}</td>
                <td>${payee.phone}</td>
                <td style="color: green" class="text-center"><a
                        href="/payee/activate?payeeId=${payee.id}" class="activate-link" data-payeeid="${payee.id}">
                    <i class="fa fa-check" aria-hidden="true"></i></a></td>
                <td style="color: green" class="text-center"><a
                        href="/payee/delete?payeeId=${payee.id}" class="activate-link" data-payeeid="${payee.id}">
                    <i class="fa fa-times-circle" aria-hidden="true"></i></a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <h3 class="text-center text-white" style="font-family: Arial;">Add Payee</h3>
    <form id="payeeForm">
          <div class="form-group col-sm-4">
            <label for="payeeId" class="text-white">Payee Account ID:</label>
            <input type="text" class="form-control" id="accountId" name="accountId" placeholder="Enter Payee Account ID" required>
          </div>
          <button type="submit" class="btn btn-primary">Add</button>
    </form>

</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
            $('.activate-link').click(function(event) {
                event.preventDefault();
                var url = $(this).attr('href');
                var payeeId = $(this).data('payeeid');
                $.get(url, function(response) {
                    alert(response);
                    location.reload(); // Refresh the page
                }).fail(function(error) {
                    console.error("Error:", error);
                });
            });
        });

        $(document).ready(function() {
                $('#payeeForm').submit(function(event) {
                    event.preventDefault();
                    var accountId = $('#accountId').val();
                    $.get('/payee/accountId', { accountId: accountId }, function(response) {
                        alert(response);
                        location.reload(); // Refresh the page
                    }).fail(function(error) {
                    //alert(error);
                        console.error("Error:", error);
                    });
                });
            });
</script>
</body>
</html>

