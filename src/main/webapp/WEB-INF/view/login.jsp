<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>ATM</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
</head>
<style>
    body {
        content: '';
        position: fixed;
        width: 100vw;
        height: 100vh;
        background-position: center center;
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-size: cover;
        background-color: #f8f8f8; /* Changed background color */
        font-family: Arial, sans-serif; /* Added font-family */
        background-image: url("https://content.pymnts.com/wp-content/uploads/2016/10/global-atm-market-to-surge-.jpg");
        background-size: cover;
        background-repeat: no-repeat;
    }

    .container {
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    input {
        font-size: 1.05em;
        font-weight: 300;
        margin-top: 18px;
        padding: 8px 8px;
        width: 288px;
        margin-left: 70px;
    }

    .input-group-text {
        padding: 10px 10px;
        margin-top: 19px;
        margin-left: 35px;
        position: absolute;
    }

    .card-footer {
        font-size: 1.05em;
        font-weight: 300;
        margin-top: 18px;
        padding: 5px 5px;
        width: 288px;
        margin-left: 100px;
    }

    .login_btn {
        color: white;
        background-color: #007bff;
        width: 100px;
        margin-left: 270px;
    }

    .login_btn:hover {
        color: black;
        background-color: white;
    }

    .card {
        height: auto;
        width: 400px;
        background-color: #ffffff; /* Changed box background color */
        border-radius: 8px; /* Added border radius */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* Added box shadow */
        padding: 20px; /* Added padding */
    }

    .card-header h1 {
        color: #333333; /* Changed heading color */
        margin-left: auto; /* Updated margin-left */
        margin-right: auto; /* Added margin-right */
        margin-bottom: 18px;
        position: relative;
        text-align: center; /* Added text-align */
    }

    .card-body {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    input:focus {
        outline: none;
        box-shadow: 0 0 0 0 !important;
    }

    .remember {
        color: white;
        margin-left: 25px;
    }

    .remember input {
        width: 20px;
        height: 20px;
        margin-left: 15px;
        margin-right: 5px;
    }

    :focus {
        outline: none;
    }

    .errorblock {
        color: #ff0000;
        margin-left: 100px;
    }

   .navbar {
            background-color: black;
            height: 50px;
        
    }

    .error-message {
                color: red;
                margin-top: 5px;
            }

    .navbar-brand {
        color: #ffffff;
        font-size: 24px;
        padding: 10px;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-center h-100">
            <div class="card">
                <div class="card-header">
                    <h1>SIGN IN</h1>
                </div>
                <div class="card-body">
                    <%-- Display error message if present --%>
                                <c:if test="${not empty error}">
                                    <div class="form-group error-message">${error}</div>
                                </c:if>

                    <form name='loginForm' action="/login" method='POST' modelAttribute="user">
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-user"></i></span>
                            </div>
                            <input type="text" name='username' class="form-control" placeholder="Email">

                        </div>
                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fa fa-key"></i></span>
                            </div>
                            <input type="password" name='password'class="form-control" placeholder="Password" minlength="4" maxlength="4">
                        </div>
                        <div class="form-group">
                            <input type="submit" value="Log In" name="submit" class="btn float-right login_btn" />
                        </div>
                        <div class="form-group">
                            <div class="links">
                                <a href="/registration" style="text-decoration:none"><b>Sign Up</b></a>
                            </div>
                            <div class="links">
                                <a href="/forgetPassword" style="text-decoration:none"><b>Change your password?</b></a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
