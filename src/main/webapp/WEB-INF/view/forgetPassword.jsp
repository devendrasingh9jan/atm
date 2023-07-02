<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <title>Forgot Password</title>
    <style>
        /* Add your custom styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            background-image: url("https://cdn.pixabay.com/photo/2016/01/09/18/27/journey-1130732_1280.jpg");
        	background-size: cover;
        	background-repeat: no-repeat;
        }

        .navbar {
            background-color: black;
            height: 50px;
        }

        .navbar-brand {
            color: #ffffff; 
            font-size: 24px;
            padding: 10px;
        }

        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }

        h2 {
            text-align: center;
        }

        p {
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a class="navbar-brand" href="/login">ATM</a>
</nav>

<div class="container">
    <h2>Change Password?</h2>
    <p><b>You can change your password here.</b></p>
    <div class="panel-body">
        <form id="forget-form" role="form" autocomplete="off" class="form" method="post" action="forgetPassword/user"
              modelAttribute="user">

            <div class="form-group">
                <label for="username">Email Address:</label>
                <input id="username" type="email" name="username" value="" placeholder="email address" required="required" type="email">
            </div>
         <div class="form-group">
    <input name="recover-submit" value="Verify Email" type="submit" style="background-color: #007bff; color: white;">
</div>

            <input type="hidden" name="token" id="token" value="">
        </form>
    </div>
</div>

</body>
</html>
