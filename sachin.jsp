<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="Resources.jsp"%>
<style type="text/css">
.bs-example {
	margin: 20px;
}
</style>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		var userNameMessage = "${message.getMessage('enter.username')}";
		var passwordMessage = "${message.getMessage('enter.password')}";
		jQuery.validator.setDefaults({
			highlight : function(element) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight : function(element) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			errorElement : 'span',
			errorClass : 'help-block',
			errorPlacement : function(error, element) {
				if (element.parent('.input-group').length) {
					error.insertAfter(element.parent());
				} else {
					error.insertAfter(element);
				}
			}
		});

		$("#loginForm").validate({
			rules : {
				userName : "required",
				password : "required",
			},

			//custom error messages
			messages : {
				userName : {
					required : userNameMessage
				},
				password : {
					required : passwordMessage
				}
			},

			// on page submit 
			submitHandler : function() {
				document.loginForm.submit();
			}
                               
		});

	});
</script>
<body>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*" %>
<%
String userid=request.getParameter("user");
session.putValue("userid",userid);
String pwd=request.getParameter("pwd");
Class.forName("org.postgresql.Driver");
java.sql.Connection con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres","postgres",
		"admin");

Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from  where user='"+userid+"'");
if(rs.next())
{
if(rs.getString(2).equals(pwd))
{
 	out.println("welcome"+ userid);
}
else
{
	out.println("invalid password try again");
}
}
else
%>
	<a href="index.html">Home</a>
	<h3 class="h3" align="center">Login Form</h3>
	
	<div class="col-sm-6 col-sm-offset-3 well well-lg">
		<form class="form-horizontal" action="<c:url value="/authenticate/login.htm?qc=Aniket"></c:url>" method="post"
			id="loginForm" name="loginForm">
			<div class="form-group">
				<label for="inputEmail"
					class="control-label col-sm-2 col-sm-offset-2">Email</label>

				<div class="col-sm-6 ">
					<input type="text" class="form-control" id="userName"
						placeholder="Email" name="userName">
					<div class="myErrors"></div>
				</div>

			</div>
			<div class="form-group">
				<label for="inputPassword"
					class="control-label col-sm-2 col-sm-offset-2">Password</label>
				<div class="col-sm-6">

					<input type="password" class="form-control" id="password"
						placeholder="Password" name="password">
				</div>
			</div>

			<div class="form-group">
				<button type="submit" class="btn btn-success col-sm-offset-4">Login</button>
			</div>
		</form>
	</div>
</body>
</html>
