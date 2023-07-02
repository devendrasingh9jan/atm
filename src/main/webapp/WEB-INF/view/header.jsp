<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="sat, 01 Dec 2001 00:00:00 GMT">
    <title>Terminals</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css" />

    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css" />
    <script type="text/javascript" src="/js1/jquery.min.js"></script>
    <script type="text/javascript" src="/js1/bootstrap.min.js"></script>
</head>
<body>
<form >
    <nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">


        <a href="" class="navbar-brand text-light" >ATM</a>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">

                <li class="nav-item">
                    <a href="/account/" class="nav-link text-light" >Account</a>
                </li>

                <li class="nav-item">
                    <a href="/atm/"
                       class="nav-link text-light">Withdraw</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-light " href="/profile">${firstname}</a>
                </li>


                <li class="nav-item">
                    <a href="/logout" class="nav-link text-light" >Logout</a>
                </li>

            </ul>


        </div>
    </nav>


</form>
</body>
</html>