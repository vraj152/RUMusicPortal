<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jstl/core_rt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript">
	
	function getRecommendations() {
		var SERVER_URL = "http://localhost:5000/"
		var END_POINT = SERVER_URL + "recommend?"

		var queryString = [];

		queryString.push(0.5);
		queryString.push(document.getElementById("acousticnessVal").textContent);
		queryString.push(document.getElementById("danceabilityVal").textContent);
		queryString.push(document.getElementById("energyVal").textContent);
		queryString.push(document.getElementById("instrumentalnessVal").textContent);
		queryString.push(document.getElementById("livenessVal").textContent);
		queryString.push(document.getElementById("loudnessVal").textContent);
		queryString.push(document.getElementById("melodityVal").textContent);
		queryString.push(document.getElementById("speechinessVal").textContent);
		queryString.push(document.getElementById("tempoVal").textContent);
		queryString.push(document.getElementById("valenceVal").textContent);

		console.log(queryString);
		
		var res = {"featureVector" : queryString}
		var REST_CALL = END_POINT +  "query=" + JSON.stringify(res);
		
		var xhttp = new XMLHttpRequest();
		xhttp.open("GET", REST_CALL, true);
		
		xhttp.onload = function(e) {
			if (xhttp.readyState === 4) {
				if (xhttp.status === 200) {
					var myobj = JSON.parse(xhttp.responseText);
					renderTable(myobj);
				} else {
					alert("error");
					console.error("Server error: ", xhttp.statusText);
				}
			}
		};
		xhttp.onerror = function(e) {
			console.error("Error connecting to: ", SERVER_URL);
		};

		xhttp.send();
	}
	
	function renderTable(children){
  		var songTableDiv = document.getElementById("song_result");
  		
  		var table = document.createElement('table');
  		table.cellspacing = "0";
  		
  		var columnSize = {
				"albumart":"100px",
				"song":"200px",
				"artist":"150px",
				"album":"200px",
				"duration_ms":"80px"
		}
  		for (var i = 0; i < Object.keys(children).length; i++) {
			
  			var interestedKeys = ['albumart','song','artist','album','duration_ms']
			
			var child = Object.keys(children)[i]; //current key
			var tr = document.createElement('tr');
			var allKeys = Object.keys(children[child]); // all keys of current object
	    	
			if(i==0){
	    		var headerRow = document.createElement('tr');
				
	    		for(var k=0;k<interestedKeys.length;k++){
	    			var eachHeader = document.createElement("th");
	    			eachHeader.innerHTML = interestedKeys[k];
	    			eachHeader.style.width = columnSize[interestedKeys[k]];
	    			if(interestedKeys[k]!='albumart'){
	    				eachHeader.style.textAlign="center";
	    			}
	    			headerRow.appendChild(eachHeader);
	    		}
	    		table.appendChild(headerRow);	    		
	    	}
			
			for(var k=0;k<interestedKeys.length;k++){
    			var eachCell = document.createElement("td");
    			if(k==0){
    				var imgTag = document.createElement("img");
    				imgTag.src = children[child][interestedKeys[k]];
    				
    				eachCell.append(imgTag);
    			}else{
    				if(interestedKeys[k]=='duration_ms'){
    					var seconds = ((children[child][interestedKeys[k]] % 60000) / 1000).toFixed(0);
    					var mins = Math.floor(children[child][interestedKeys[k]] / 60000);
    					
    					eachCell.innerHTML = mins + ":" + seconds + "min";
    				}else{
    					eachCell.innerHTML = children[child][interestedKeys[k]];    					
    				}
    			}
    			tr.appendChild(eachCell);
    		}
			
			table.appendChild(tr);	
		}
  		songTableDiv.appendChild(table);
  	}
</script>
	<title>RU Music - Get Recommendations</title>
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
	<link rel="stylesheet" href="css/online.css">
  </head>
  <body>
	<f:set var="sessionUser" value="${loggedInUser}" scope="session"></f:set>
	<div class="main-section">

		<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
			<div class="container">
				<a class="navbar-brand" href="index.html">Let's know your mood, <f:out value="${loggedInUser.fname}"></f:out>.</a>
			</div>
		</nav>
		
		<section class="ftco-section goto-here pb-0">
			<div class="container">
				<div class="row">
	  			</div>
			</div>
		</section>
		
		<!-- Need to keep till this -->

		<section class="ftco-section" id="inputs">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-6">
						
						<!-- First Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="Indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0. Higher the melodity, more chances of track being melodious.">
									  Melodity</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="melodityVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-1" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Second Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="Indicates a confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.">
									  Acousticness</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="acousticnessVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-2" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Third Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.">
									  Danceability</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="danceabilityVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-3" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Fourth Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="	Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale.">
									  Energy</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="energyVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-4" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Fifth Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content=" Sounds like “Ooh” and “aah” are treated as instrumental in this context. Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.">
									  Instrumentalness</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="instrumentalnessVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-5" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Sixth Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.">
									  Liveness</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="livenessVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-6" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Seventh Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typical range between -60 and 0 db.">
									  Loudness</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="loudnessVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-7" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Eighth Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks.">
									  Speechiness</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="speechinessVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-8" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Nineth Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).">
									  Valence</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="valenceVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-9" class="no-uicustom mb-4"></div>
						
						<div class="customDivider"></div>
						
						<!-- Tenth Slider -->
						<center>
							<button type="button" class="btn btn-primary" data-container="body" data-toggle="popover" data-placement="top" data-content="The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.">
									  Tempo</button>
							<span class="badge badge-pill badge-rose p-2 px-3" id="tempoVal">0.5</span> 
							
						</center>
						<div class="customDivider"></div>
						<div id="slider-10" class="no-uicustom mb-4"></div>
						<center>
							<button type="button" class="btn btn-outline-light" onclick="getRecommendations()">Get Recommendations</button>
						</center>
					</div>
				</div>
			</div>
		</section>
		<section class="ftco-section ftco-section-2">
			<div class="table-users" id="song_result">
				<div class="header">Recommendations</div>
			</div>
		</section>
	</div>
	  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

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
  <script type="text/javascript">
		
		document.getElementById("slider-1").noUiSlider.on("slide",function(){
			document.getElementById("melodityVal").innerHTML = document.getElementById("slider-1").noUiSlider.get();
		});
		document.getElementById("slider-2").noUiSlider.on("slide",function(){
			document.getElementById("acousticnessVal").innerHTML = document.getElementById("slider-2").noUiSlider.get();
		});
		document.getElementById("slider-3").noUiSlider.on("slide",function(){
			document.getElementById("danceabilityVal").innerHTML = document.getElementById("slider-3").noUiSlider.get();
		});
		document.getElementById("slider-4").noUiSlider.on("slide",function(){
			document.getElementById("energyVal").innerHTML = document.getElementById("slider-4").noUiSlider.get();
		});
		document.getElementById("slider-5").noUiSlider.on("slide",function(){
			document.getElementById("instrumentalnessVal").innerHTML = document.getElementById("slider-5").noUiSlider.get();
		});
		document.getElementById("slider-6").noUiSlider.on("slide",function(){
			document.getElementById("livenessVal").innerHTML = document.getElementById("slider-6").noUiSlider.get();
		});
		document.getElementById("slider-7").noUiSlider.on("slide",function(){
			document.getElementById("loudnessVal").innerHTML = document.getElementById("slider-7").noUiSlider.get();
		});
		document.getElementById("slider-8").noUiSlider.on("slide",function(){
			document.getElementById("speechinessVal").innerHTML = document.getElementById("slider-8").noUiSlider.get();
		});
		document.getElementById("slider-9").noUiSlider.on("slide",function(){
			document.getElementById("valenceVal").innerHTML = document.getElementById("slider-9").noUiSlider.get();
		});
		document.getElementById("slider-10").noUiSlider.on("slide",function(){
			document.getElementById("tempoVal").innerHTML = document.getElementById("slider-10").noUiSlider.get();
		});
	</script>
  </body>
</html>