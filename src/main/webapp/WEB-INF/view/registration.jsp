<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/css1/bootstrap.min.css" />
<script type="text/javascript" src="/js1/jquery.min.js"></script>
<script type="text/javascript" src="/js1/bootstrap.min.js"></script>
<title>ATM</title>
<style>

form {
	width: 60%;
	margin: 60px auto;
	background: #efefef;
	padding: 60px 120px 80px 120px;
	text-align: center;
	-webkit-box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.1);
	box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.1);
}

label {
	display: block;
	position: relative;
	margin: 40px 0px;
}

.label-txt {
	position: absolute;
	top: -1.6em;
	padding: 10px;
	font-family: sans-serif;
	font-size: .8em;
	letter-spacing: 1px;
	color: rgb(120, 120, 120);
	transition: ease .3s;
}

.input {
	width: 100%;
	padding: 10px;
	background: transparent;
	border: none;
	outline: none;
}

.line-box {
	position: relative;
	width: 100%;
	height: 2px;
	background: #BCBCBC;
}

.line {
	position: absolute;
	width: 0%;
	height: 2px;
	top: 0px;
	left: 50%;
	transform: translateX(-50%);
	background: #8BC34A;
	transition: ease .6s;
}

.input:focus+.line-box .line {
	width: 100%;
}

.label-active {
	top: -3em;
}
		body {
			font-family: Arial, sans-serif;
			margin: 0;
			padding: 0;
			background-image: url("https://cdn.pixabay.com/photo/2016/06/25/12/48/go-pro-1478810_1280.jpg");
        	background-size: cover;
        	background-repeat: no-repeat;
		}

		.container {
			max-width: 400px;
			margin-left:35vw;
			background-color:snow;
		}

		.form-group {
			margin-bottom: 20px;
		}

		label {
			display: block;
			font-size: 14px;
			font-weight: bold;
			margin-bottom: 5px;
		}

		input[type="text"],
		input[type="password"] {
			width: 100%;
			padding: 10px;
			font-size: 16px;
		}

		.button {
		  display: inline-block;
		  padding: 10px 20px;
		  background-color: #007bff;
		  color: #fff;
		  font-size: 16px;
		  border: none;
		  cursor: pointer;
		}


		.button:hover {
			background-color: #45a049;
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
	</style>
</head>
<body onload="document.form.username.focus()">
	<nav class="navbar">
    <a class="navbar-brand" href="/login">ATM</a>
</nav>
	
	<div class="container">
		
		<form name="form" action="/register" method="POST">
		<div><h2 align="center">REGISTER</h3></div>
			<div class="form-group">
				<label for="username">Enter Email</label>
				<input type="text" name="user.username" id="user.username" placeholder="username@gmail.com" required="required" />
			</div>
			<div class="form-group">
            	<label for="firstName">Enter First Name</label>
            	<input type="text" name="firstName" id="firstName" placeholder="First Name" required="required" />
            </div>
			<div class="form-group">
            	<label for="lastName">Enter Last Name</label>
            	<input type="text" name="lastName" id="lastName" placeholder="Last Name" required="required" />
            </div>
            <div class="form-group">
                <label for="age">Enter Age</label>
                <input type="text" name="age" id="age" placeholder="Age" required="required" />
            </div>
            <div class="form-group">
                <label for="phone">Enter Phone</label>
                <input type="text" name="phone" id="phone" placeholder="Phone" minlength="10" maxlength="10"required="required" />
            </div>
			<div class="form-group">
				<label for="password">Enter Password</label>
				<input type="password" name="user.password" id="user.password" placeholder="password" required="required" minlength="4" maxlength="4"/>
			</div>
			<input type="submit" value="Submit" class="button" onclick="return ValidateEmail(document.form.username);" />
		</form>
	</div>

	<script>
		function ValidateEmail(inputText) {
			var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
			if (inputText.value.match(mailformat)) {
				var user = document.getElementById("username").value;
				var user_domain = user.endsWith(".com");
				var dbuser = document.getElementById("dbuser").value;
				var checkuser = dbuser.includes(user);
				document.form.username.focus();
				if (checkuser) {
					alert("UserId Already Exists");
					return false;
				}
				if (user_domain) {
					return true;
				} else {
					alert("Email Id should end with .com");
					return false;
				}
			} else {
				alert("Invalid Email Address!");
				document.form.username.focus();
				return false;
			}
		}
	</script>
</body>
</html>

</html>
