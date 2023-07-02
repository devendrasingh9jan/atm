<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://use.fontawesome.com/171b742c08.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-0QrgmqUclLu71y4nKTzL5/oyUJlSqPzzAfPjhbFfVNT9H5YsXeZ0fSGdUTNwlqf9UCVd1yq3orATG0cNjY1FlQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Create Deposit</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

    <style>

        body{
          		background-image: url("https://images.squarespace-cdn.com/content/v1/603a992bcf34a07d765e1085/1f51c872-40a9-4dfe-8d3e-c8868e05f2d7/16247556_9729.jpg");
            	background-size: cover;
            	background-repeat: no-repeat;
          	}

        </style>
    <div class="container">
        <jsp:include page="headerUser.jsp"></jsp:include>
        <br><br><br>
        <h3 class="text-center">Deposits</h3>
        <div id="depositTable"></div>
    </div>
    <h3 class="text-center">Create Deposit</h3>
    <form id="createDepositForm">
        <div class="form-group col-sm-4">
            <label for="depositType">Deposit Type:</label>
            <select class="form-control" id="depositType" name="depositType">
                <option value="nothing">Select</option>
                <option value="fixed">Fixed Deposit</option>
                <option value="recurring">Recurring Deposit</option>
            </select>
        </div>
        <div id="fixedDepositSection" style="display: none;">
            <h5>Fixed Deposit:</h5>
            <div class="form-group">
                <label for="fixedDepositPrincipal">Principal:</label>
                <input type="text" class="form-control" id="fixedDepositPrincipal" name="fixedDepositPrincipal" placeholder="Enter Principal">
            </div>
            <div class="form-group">
                <label for="fixedDepositYears">Years:</label>
                <input type="text" class="form-control" id="fixedDepositYears" name="fixedDepositYears" placeholder="Enter Years">
            </div>
        </div>
        <div id="recurringDepositSection" style="display: none;">
            <h5>Recurring Deposit:</h5>
            <div class="form-group">
                <label for="recurringDepositPrincipal">Principal:</label>
                <input type="text" class="form-control" id="recurringDepositPrincipal" name="recurringDepositPrincipal" placeholder="Enter Principal">
            </div>
            <div class="form-group">
                <label for="recurringDepositMonths">Months:</label>
                <input type="text" class="form-control" id="recurringDepositMonths" name="recurringDepositMonths" placeholder="Enter Months">
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Create</button>

    </form>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#depositType').change(function() {
                var depositType = $(this).val();
                if (depositType === 'fixed') {
                    $('#fixedDepositSection').show();
                    $('#recurringDepositSection').hide();
                } else if (depositType === 'recurring') {
                    $('#fixedDepositSection').hide();
                    $('#recurringDepositSection').show();
                } else {
                    $('#fixedDepositSection').hide();
                    $('#recurringDepositSection').hide();
                }
            });

            $('#createDepositForm').submit(function(event) {
                event.preventDefault();

                var depositType = $('#depositType').val();
                var principal = null;
                var years = null;
                var months = null;

                if (depositType === 'fixed') {
                    principal = $('#fixedDepositPrincipal').val();
                    years = $('#fixedDepositYears').val();
                } else if (depositType === 'recurring') {
                    principal = $('#recurringDepositPrincipal').val();
                    months = $('#recurringDepositMonths').val();
                }

                var depositRequest = {
                    depositType: depositType,
                    principal: principal,
                    years: years,
                    months: months
                };

                $.ajax({
                    type: 'POST',
                    url: '/deposit/create',
                    contentType: 'application/json',
                    data: JSON.stringify(depositRequest),
                    success: function(response) {
                        alert('Deposit created successfully.');
                        $('#createDepositForm')[0].reset(); // Clear the form fields
                        fetchDeposits(); // Update the table with the new deposit
                    },
                    error: function(xhr, status, error) {
                        alert('Error creating deposit: ' + error);
                    }
                });
            });

            fetchDeposits(); // Fetch deposits on page load

            function fetchDeposits() {
                        $.ajax({
                            url: '/deposit/view',
                            type: 'GET',
                            dataType: 'json',
                            success: function(deposits) {
                                console.log("Deposits:", deposits); // Log the received data
                                if ($.isArray(deposits)) {
                                    var tableHtml = "<table class='table table-bordered'>";
                                    tableHtml += "<thead><tr><th>ID</th><th>Type</th><th>Rate</th><th>Principal</th><th>Years/Months</th><th>Status</th><th>Close</th></tr></thead>";
                                    tableHtml += "<tbody>";
                                    $.each(deposits, function(index, deposit) {
                                        var row = "<tr>" +
                                            "<td class='text-center'>" + deposit.id + "</td>" +
                                            "<td class='text-center'>" + deposit.depositType + "</td>" +
                                            "<td class='text-center'>" + deposit.rate + "</td>" +
                                            "<td class='text-center'>" + deposit.principal + "</td>" +
                                            "<td class='text-center'>" + (deposit.years != null ? deposit.years : deposit.months) + "</td>" +
                                            "<td class='text-center'>" + (deposit.isActive == true ? "Active" : "Closed") + "</td>" +
                                            "<td class='text-center'><a href='#' onclick=\"closeDeposit('" + deposit.depositType + "', " + deposit.id + ")\" class='activate-link'><i class='fa fa-times-circle' aria-hidden='true'></i></a></td>" +
                                            "</tr>";
                                        tableHtml += row;
                                    });
                                    tableHtml += "</tbody></table>";

                                    // Display the table in a specific div
                                    $("#depositTable").html(tableHtml);
                                } else {
                                    console.error("Invalid data format for deposits");
                                }
                            },
                            error: function(xhr, status, error) {
                                console.error("Error fetching deposits:", error);
                            }
                        });
                    }


        });

        function closeDeposit(depositType, depositId) {
            $.ajax({
                url: '/deposit/close',
                type: 'GET',
                data: {
                    depositType: depositType,
                    depositId: depositId
                },
                success: function(response) {
                    console.log("Close Deposit Response:", response);
                    alert(response);
                    location.reload(); // Refresh the page
                    // Process the response as needed
                },
                error: function(xhr, status, error) {
                    console.error("Error closing deposit:", error);
                }
            });
        }



    </script>
</body>
</html>
