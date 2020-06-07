<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <script type="text/javascript">
  	window.onload = function(){
  		var SERVER_URL = "http://localhost:5000/"
		var END_POINT = SERVER_URL + "recommendByTrack?"
		var REST_CALL = END_POINT +  "input=" + '${fetchedData[7]}';
		
	    var xhttp = new XMLHttpRequest();
        xhttp.open("GET", REST_CALL, true);
        xhttp.onload = function (e)
        {
          if (xhttp.readyState === 4)
          {
            if (xhttp.status === 200)
            {
              var myobj = JSON.parse(xhttp.responseText);
              renderDivs(myobj);
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

	function renderDivs(children){
		console.log(children);
		parent = document.getElementById("parentdiv");
		for (var i = 0; i < Object.keys(children).length; i++){
			var child = Object.keys(children)[i];
			
			var outerdiv = document.createElement("div");
			var innerdiv1 = document.createElement("div");
			var innerdiv2 = document.createElement("div");
			var innerdiv3 = document.createElement("div");
			var play = document.createElement("div");

			play.classList.add("play-icon");
			innerdiv3.classList.add("album-info");
			innerdiv2.classList.add("album-thumb");
			
			innerdiv1.classList.add("single-album-area");
			innerdiv1.classList.add("wow");
			innerdiv1.classList.add("fadeInUp");
			
			outerdiv.classList.add("col-12");
			outerdiv.classList.add("col-sm-6");
			outerdiv.classList.add("col-md-4");
			outerdiv.classList.add("col-lg-2");
			
			var anchorTag1 = document.createElement("a");
			anchorTag1.href = "getplayer.htm?artist=" + children[child]['artist'] + "&songName=" + children[child]['song'] + "&songid=" + child;
			anchorTag1.classList.add("video--play--btn");
			
			var spanTag = document.createElement("span");
			spanTag.classList.add("icon-play-button");
			anchorTag1.appendChild(spanTag);
			
			play.appendChild(anchorTag1);
			
			var imgTag = document.createElement("img");
			imgTag.src = children[child]['albumart'];
			
			var anchorTag = document.createElement("a");
			var h5Tag = document.createElement("h5");
			h5Tag.innerHTML = children[child]['song'];
			
			var pTag = document.createElement("p");
			pTag.innerHTML = children[child]['artist']; 
			
			anchorTag.href = "getplayer.htm?artist=" + children[child]['artist'] + "&songName=" + children[child]['song'] + "&songid=" + child;
			anchorTag.appendChild(h5Tag);
			
			innerdiv2.appendChild(imgTag);
			innerdiv2.appendChild(play);
			
			innerdiv3.appendChild(anchorTag);
			innerdiv3.appendChild(pTag);
			
			innerdiv1.appendChild(innerdiv2);
			innerdiv1.appendChild(innerdiv3);
			
			outerdiv.appendChild(innerdiv1);
			
			parent.appendChild(outerdiv);
		}
	}  	
  </script>
  <title>RU Music - Get Recommendations</title>
  	<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    
	<link rel="stylesheet" href="css/oneMusicStyle.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel="stylesheet" href="build/mediaelementplayer.css">

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
	<style>

        html, body {
            overflow-x: hidden;
        }

        #container {
            padding: 0 20px 50px;
        }
        .error {
            color: red;
        }
        a {
            word-wrap: break-word;
        }

        code {
            font-size: 0.8em;
        }

        #player2-container .mejs__time-buffering, #player2-container .mejs__time-current, #player2-container .mejs__time-handle,
        #player2-container .mejs__time-loaded, #player2-container .mejs__time-hovered, #player2-container .mejs__time-marker, #player2-container .mejs__time-total {
            height: 2px;
        }

        #player2-container .mejs__time-total {
            margin-top: 9px;
        }
        #player2-container .mejs__time-handle {
            left: -5px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #ffffff;
            top: -5px;
            cursor: pointer;
            display: block;
            position: absolute;
            z-index: 2;
            border: none;
        }
        #player2-container .mejs__time-handle-content {
            top: 0;
            left: 0;
            width: 12px;
            height: 12px;
        }
    </style>
  </head>
  <body>
  	<f:set var="userInput" value="vraj"></f:set>
	<div class="main-section">
		<section class="contact-area section-padding-100 bg-img bg-overlay bg-fixed has-bg-img" style="background-image: url(<f:out value="${fetchedData[6] }"></f:out>);">
			<div class="container">
				<div class="row align-items-end">
                <div class="col-12 col-md-5 col-lg-4">
                    <div class="featured-artist-thumb">
                        <img src=<f:out value="${fetchedData[4] }"></f:out> alt="">
                    </div>
                </div>
                <div class="col-12 col-md-7 col-lg-8">
                    <div class="featured-artist-content">
                        <!-- Section Heading -->
                        <div class="section-heading white text-left mb-30">
                            <p>Currently Playing...</p>
                            <h2><f:out value="${fetchedData[1] }"></f:out></h2>
                        </div>
                        <div class="section-heading white text-left mb-30">
	                        <span id="artist_name">Artist: <f:out value="${fetchedData[3] }"></f:out></span><br> 
	                        <span id="album_name">Album: <f:out value="${fetchedData[5] }"></f:out></span><br>
	                        <span id="release_date">Release Date: <f:out value="${fetchedData[2] }"></f:out></span><br> 
                        </div>
                        <div class="song-play-area" id="musicdiv">
                            <div class="song-name">
                                <p><f:out value="${fetchedData[1] }"></f:out></p>
                            </div>
							<audio preload="auto" controls>
                                <source src="<f:out value="${fetchedData[0] }"></f:out>" type="audio/mpeg">
                            </audio>
                        </div>
                    </div>
                </div>
            </div>
			</div>
		</section>
		
		<section class="oneMusic-buy-now-area has-fluid section-padding-100">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading style-2">
                        <p>You may also like these songs</p>
                        <h2>Because you like <f:out value="${fetchedData[1] }"></f:out></h2>
                    </div>
                </div>
            </div>

            <div class="row" id="parentdiv">

               
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
  <script src="build/mediaelement-and-player.js"></script>
  <script src="js/demo.js"></script>
  </body>
</html>