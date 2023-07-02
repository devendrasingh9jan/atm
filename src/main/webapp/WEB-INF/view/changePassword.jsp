<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	body {
		
		background-image: url("https://cdn.pixabay.com/photo/2017/08/01/00/01/map-2562138_1280.jpg");
        background-size: cover;
        background-repeat: no-repeat;
	}

	.navbar {
		margin-left:auto;
		height: 60px;
		background-color: black;
	}

	.navbar-brand {
		height: 60px;
		padding: 15px;
		
	}

	.form-gap {
		padding-top: 70px;
	}

	input {
		padding: 8px 8px;
		width: 288px;
		margin-left: 10px;
	}
	
	.container{
		margin-top:200px;
	}
</style>

	<title>ATM</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light">
	<div class="container-fluid">
		<a class="navbar-brand text-light" href="/login">ATM</a>
	</div>
</nav>
<div align="center" class="container">
  <div class="">
    <div class="col-sm-4 col-md-offset-4">
      <div class="card">
        <div class="card-body">
          <form:form name="form" method="POST" action="/changePassword" modelAttribute="user">
            <input type="hidden" id="username" name="username" value="${user.username}" />
            <div class="form-group">
              <label for="password1"><b>Old Password</b></label>
              <input type="password" value="" class="form-control" required="required" name="password_old" id="password_old"
               minlength="4" maxlength="4" placeholder="Old Password">
            </div>
            <div class="form-group">
              <label for="password1"><b>New Password</b></label>
              <input type="password" value="" class="form-control" required="required" name="password_new" id="password_new"
              minlength="4" maxlength="4"  placeholder="New Password">
            </div>
            <br>
            <div class="form-group">
              <label for="confirm_password"><b>Confirm Password</b></label>
              <input type="password" value="" class="form-control" required="required" name="confirm_new_password"
              minlength="4" maxlength="4" id="confirm_new_password" placeholder="Confirm Password">
            </div>
            <br>
            <div class="form-group">
              <input name="recover-submit" class="btn btn-lg btn-primary btn-block" value="Reset Password"
                onclick="checkPassword()" type="button">
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript">
	function checkPassword() {
		var username = document.getElementById("username").value;
		var password_old = document.getElementById("password_old").value;
		var password_new = document.getElementById("password_new").value;
		var confirm_new_password = document.getElementById("confirm_new_password").value;

		// If password not entered
		if (password_new == '')
			alert("Please enter Password");

		// If confirm password not entered
		else if (confirm_new_password == '')
			alert("Please enter confirm password");

		// If passwords do not match
		else if (password_new != confirm_new_password) {
			alert("Password did not match: Please try again...");
		}

		// If passwords match, send the form
		else {

			var formData = new FormData();
			formData.append("username", username);
			formData.append("password", password_new);
			formData.append("oldPassword", password_old);

			fetch("/changePassword", {
				method: "POST",
				body: formData
			})
					.then(response => {
						if (response.ok) {
							alert("Password updated successfully");
							// Handle the response or redirect to a new page
							window.location.href = "/login";
						} else {
							alert("Failed to update password.");
							// Handle the error
						}
					})
					.catch(error => {
						console.error("Error:", error);
						// Handle the error
					});
		}
	}
</script>

</body>
</html>
