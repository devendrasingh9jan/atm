<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css" />
    <script type="text/javascript" src="/js1/font.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <style>
        body {
            background-image: url("https://cdn.pixabay.com/photo/2021/09/18/02/00/lighthouse-6634029_1280.jpg");
            background-size: cover;
            background-repeat: no-repeat;
        }

        .error-template {padding: 40px 15px;text-align: center;}
        .error-actions {margin-top:15px;margin-bottom:15px;}
        .error-actions .btn { margin-right:10px; }
        .navbar {
            background-color: black;
            height: 50px;
        }

        .navbar-brand {
            color: #ffffff;
            font-size: 24px;
            padding: 10px;
        }
    </style>
</head>
<body onload="document.form.username.focus()">
    <nav class="navbar">
        <a class="navbar-brand" href="/logout">OBS</a>
    </nav>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="error-template">
                    <h2>
                        <c:if test="${not empty error}">
                            <div align="center" style="color: white">${error}</div>
                        </c:if>
                    </h2>
                    <div class="error-details">
                        Sorry, an error has occurred. Unable to find the requested page!
                    </div>
                    <div class="error-actions">
                        <a href="/account" class="btn btn-primary btn-success">
                            <span class="fa fa-road bg-dark" aria-hidden="true"></span>
                            Return to View Vehicles
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
