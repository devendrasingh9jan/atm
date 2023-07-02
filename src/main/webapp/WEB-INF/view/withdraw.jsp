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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#withdrawForm').submit(function(event) {
                    event.preventDefault();
                    var amount = $('#amount').val();
                    withdrawCash(amount);
                });

                $('.fast-withdraw-button').click(function() {
                    var selectedAmountIndex = $(this).data('amount-index');
                    fastCashWithdraw(selectedAmountIndex);
                });
            });

            function showResponse(response) {
                alert(response);
            }

            function withdrawCash(amount) {
                $.ajax({
                    type: 'GET',
                    url: '/atm/withdraw',
                    data: {
                        amount: amount
                    },
                    success: function(response) {
                        showResponse(response);
                    },
                    error: function() {
                        showResponse('An error occurred. Please try again.');
                    }
                });
            }

            function fastCashWithdraw(selectedAmountIndex) {
                $.ajax({
                    type: 'GET',
                    url: '/atm/fast-withdraw',
                    data: {
                        selectedAmountIndex: selectedAmountIndex
                    },
                    success: function(response) {
                        showResponse(response);
                    },
                    error: function() {
                        showResponse('An error occurred. Please try again.');
                    }
                });
            }
        </script>
        <style>
                .container {
                    margin-top: 50px;
                }
              	body{
              		background-image: url("https://images.newindianexpress.com/uploads/user/imagelibrary/2021/6/11/w1200X800/ATM_cash_.jpg");
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

    <style>

        body{
          		background-image: url("https://images.squarespace-cdn.com/content/v1/603a992bcf34a07d765e1085/1f51c872-40a9-4dfe-8d3e-c8868e05f2d7/16247556_9729.jpg");
            	background-size: cover;
            	background-repeat: no-repeat;
          	}

        </style>
    <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h1>Withdraw Cash</h1>

                    <form id="withdrawForm">
                        <label for="amount">Amount:</label>
                        <input type="number" name="amount" id="amount" required>
                        <button type="submit" class="btn btn-primary">Withdraw</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <h1>Fast Cash Withdrawal</h1>

                    <div class="row">
                        <div class="col-md-6">
                            <h3>Select Amount:</h3>
                            <button class="fast-withdraw-button btn btn-primary" data-amount-index="0">500</button>
                            <button class="fast-withdraw-button btn btn-primary" data-amount-index="1">1000</button>
                            <button class="fast-withdraw-button btn btn-primary" data-amount-index="2">2000</button>
                        </div>
                        <div class="col-md-6">
                            <button class="fast-withdraw-button btn btn-primary" data-amount-index="3">5000</button>
                            <button class="fast-withdraw-button btn btn-primary" data-amount-index="4">10000</button>
                            <button class="fast-withdraw-button btn btn-primary" data-amount-index="5">20000</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.min.js"></script>

</body>
</html>
