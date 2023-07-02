<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Account</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script type="text/javascript" src="/js1/font.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <style>
        .container {
            margin-top: 50px;
        }
      	body{
      		background-image: url("https://media.istockphoto.com/id/1165467954/photo/unrecognizable-african-man-using-touch-screen-on-atm-outdoor.jpg?s=612x612&w=0&k=20&c=TfYRnpobNfoGUtMgwE-WyWjcCPrSW8KbZgCGjtSmNdQ=");
        	background-size: cover;
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
<div class="container text-white">
    <jsp:include page="header.jsp"></jsp:include>
    <br>
    <form>
      <div class="form-row">
        <div class="col-md-2 mb-3">
          <label>&nbsp;</label>
          <button class="form-control btn btn-primary btn-block" type="button" onclick="getAccountSummary()">Summary</button>
        </div>
        <div id="accountSummary"></div>
      </div>
      <div class="form-row">
        <div class="col-md-2 mb-3">
          <label>&nbsp;</label>
          <button class="form-control btn btn-primary btn-block" type="button" onclick="getAccountStatement()">Mini Statement</button>
        </div>
        <div id="accountStatement"></div>
      </div>

      <div class="form-row">
              <div class="col-md-2 mb-3">
                <label>&nbsp;</label>
                <button class="form-control btn btn-primary btn-block" type="button" onclick="showTransferForm()">Deposit By Cheque</button>
              </div>
            </div>
    </form>

    <form id="chequeForm" style="display: none;">
      <div class="form-group">
        <label for="accountId">Payee ID:</label>
        <input type="text" class="form-control" id="accountId" name="accountId" placeholder="Account Number/ID" required>
      </div>
      <div class="form-group">
        <label for="amount">Amount:</label>
        <input type="text" class="form-control" id="amount" name="amount" placeholder="Enter Amount" required>
      </div>
      <button type="submit" class="btn btn-primary">Deposit</button>
    </form>


</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function getAccountSummary() {
      $.ajax({
        url: "/account/summary",
        type: "GET",
        dataType: "text",
        success: function(response) {
          console.log("Account Summary:", response);
          $("#accountSummary").text("Balance Summary: " + response); // Set the value in the element
        },
        error: function(error) {
          console.error("Error:", error);
        }
      });
    }

    function getAccountStatement() {
        $.ajax({
          url: "/account/statement",
          type: "GET",
          dataType: "json",
          success: function(response) {
            console.log("Account Statement:", response);
            // Process the response and create an HTML table
            var tableHtml = "<table class='table table-bordered text-white'>";
            tableHtml += "<thead><tr><th>Transaction Id</th><th>Type</th><th>Date</th><th>Amount</th></tr></thead>";
            tableHtml += "<tbody>";
            response.forEach(function(transaction) {
              tableHtml +=
                "<tr><td>" +
                transaction.id +
                "</td><td>" +
                transaction.transactionType +
                "</td><td>" +
                transaction.date +
                "</td><td>" +
                transaction.amount +
                "</td></tr>";
            });
            tableHtml += "</tbody></table>";

            // Display the table in the accountStatement div
            $("#accountStatement").html(tableHtml);
          },
          error: function(error) {
            console.error("Error:", error);
          }
        });
      }

    function showTransferForm() {
        $("#chequeForm").show();
      }

      $(document).ready(function() {
        $("#chequeForm").submit(function(event) {
          event.preventDefault();

          var chequeData = {
            accountId: $("#accountId").val(),
            checkAmount: $("#amount").val()
          };

          $.ajax({
            url: "/cheque/deposit",
            type: "POST",
            contentType: "application/json",
            dataType: "text",
            data: JSON.stringify(chequeData),
            success: function(response) {
              console.log("Cheque deposited successfully");
              alert("Cheque deposited successfully");
              // Handle success response
            },
            error: function(error) {
                alert("Cheque Rejected");
              console.error("Cheque Rejected:", error);
              // Handle error response
            }
          });
        });
      });

</script>
</body>
</html>
