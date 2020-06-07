<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <script type="text/javascript">
  	function validateInfo() {
		fn = document.getElementById("fn").value;
		ln = document.getElementById("ln").value;
		un = document.getElementById("un").value;
		pwd = document.getElementById("pwd").value;
		email = document.getElementById("email").value;
		cnt = document.getElementById("cnt").value;
		
		if(fn=="" |ln=="" | un=="" |pwd=="" |email=="" |cnt==""){
			alert("All fields are mandatory, fill them!");
			return false;
		}
		return true;
	}
  
  </script>
  
  
    <title>RU Music - Get Recommendations</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
	<link rel="stylesheet" href="css/aos.css">
	<link rel="stylesheet" href="css/ionicons.min.css">
	<link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" href="css/nouislider.css">
	<link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/style.css">
  </head>
  <body>
		
  <div class="main-section">
		<section class="ftco-section goto-here pb-0">
			<div class="container">
				<div class="row">
					<div class="col-md-12 heading-title">
						<h1>Sign Up - RUM.</h1>
					</div>
				</div>
			</div>
		</section>
		<section class="hero-wrap" style="background-image: url(images/bg_1.jpg);" data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
			<div class="row justify-content-center">
				<div class="col-lg-4 col-md-6 mb-4 mb-md-0">
					<div class="card card-login py-4">
						<form class="form-login" method="post" action="savedata.htm" onsubmit="return validateInfo()">
							<div class="card-body pb-4 pt-2">
								<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">
											</span>
										</div>
										<input type="text" id="fn" name="fn" class="form-control" placeholder="First name">
								</div>
								<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">
											</span>
										</div>
										<input type="text" id="ln" name="ln" class="form-control" placeholder="Last name">
								</div>
								<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">
											</span>
										</div>
										<input type="text" id="un" name="un" class="form-control" placeholder="Username">
								</div>
								<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">
											</span>
										</div>
										<input type="password" id="pwd" name="pwd" class="form-control" placeholder="Password..">
								</div>
								<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">
											</span>
										</div>
										<input type="text" id="cnt" name="cnt" class="form-control" placeholder="Country">
								</div>
								<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">
											</span>
										</div>
										<input type="text" id="email" name="email" class="form-control" placeholder="EmailID..">
								</div>
							</div>
							<div class="footer text-center mb-2">
								<button type="submit" class="btn btn-outline-light">Sign Up</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>	
  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/aos.js"></script>

  <script src="js/nouislider.min.js"></script>
  <script src="js/moment-with-locales.min.js"></script>
  <script src="js/bootstrap-datetimepicker.min.js"></script>
  <script src="js/main.js"></script>
    
  </body>
</html>