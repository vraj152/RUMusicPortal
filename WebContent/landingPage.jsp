<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <script type="text/javascript">
  	function fetchDataPy(){
		var SERVER_URL="http://localhost:5000/"
		var END_POINT = SERVER_URL + "search?"
				
		var song_name = document.getElementById("song_name").value;
		var artist_name = document.getElementById("artist_name").value;
		var album_name = document.getElementById("album_name").value;
		
		if(song_name=='' && artist_name=='' && album_name==''){
			alert("Enter valid input first!");
		}else{
		
		    var REST_CALL = END_POINT + "song_name=" + song_name + "&artist_name=" + artist_name + "&album_name=" + album_name;
			
		    var xhttp = new XMLHttpRequest();
	        xhttp.open("GET", REST_CALL, true);
	        xhttp.onload = function (e)
	        {
	          if (xhttp.readyState === 4)
	          {
	            if (xhttp.status === 200)
	            {
	              var myobj = JSON.parse(xhttp.responseText);
	              renderTable(myobj);
	            }
	            else
	            {
	            	alert("error");
				 	console.error("Server error: ", xhttp.statusText);
	            }
	          }
	        };
	        xhttp.onerror = function (e)
	        {
			  console.error("Error connecting to: ", SERVER_URL);
	        };
	        
	        xhttp.send();
		}
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
    			if(interestedKeys[k]=='albumart'){
    				var imgTag = document.createElement("img");
    				imgTag.src = children[child][interestedKeys[k]];
    				
    				eachCell.append(imgTag);
    			}else if(interestedKeys[k]=='song'){
    				var anchorTag = document.createElement("a");
    				anchorTag.text = children[child][interestedKeys[k]];
    				anchorTag.href = "getplayer.htm?songName="+children[child][interestedKeys[k]] + "&artist=" + children[child]['artist'] + "&songid=" + child;
    				
    				eachCell.append(anchorTag);
    			}
    			else{
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
	<link rel="stylesheet" href="css/online.css">
  </head>
  <body>
	<f:set var="sessionUser" value="${userinfo}" scope="session"></f:set>
	<div class="main-section">

		<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
			<div class="container">
				<a class="navbar-brand" href="index.html">Welcome, <f:out value="${userinfo.fname}"></f:out>.</a>
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
				<div class="row">
					<div class="col-md-12">
						<h2 class="heading-section mb-4">Search by</h2>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group has-default">
							<input type="text" class="form-control" placeholder="Song name" name="song_name" id="song_name">
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group has-default">
							<input type="text" class="form-control" placeholder="Artist name" name="artist_name" id="artist_name">
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group has-default">
							<input type="text" class="form-control" placeholder="Album name" name="album_name" id="album_name">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-sm-offset-5 text-center">
						<button type="button" class="btn btn-outline-light" onclick="fetchDataPy()">Search</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-sm-offset-5 text-center">
						<button type="button" class="btn btn-outline-light" onclick="">Browse all songs</button>
						<button type="button" class="btn btn-outline-light" onclick="location.href='questionset.htm'">Recommend songs</button>
					</div>
				</div>
			</div>
		</section>
		<section class="ftco-section ftco-section-2">
			<div class="table-users" id="song_result">
				<div class="header">Song Result</div>
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