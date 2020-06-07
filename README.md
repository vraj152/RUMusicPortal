# RUMusicPortal
Web Portal for the [RUMusic](https://github.com/vraj152/RUMusic)

* This web application is developed in Spring framework. It follows MVC pattern.
* You can find all java files under _ru_ package. 
* Database : MySQL.
* Template borrowed from [Colorlib](https://colorlib.com/wp/template/equip-ui-kit/)
* This web-app has sevetral pages, which are as following:
  * [index.jsp](https://github.com/vraj152/RUMusicPortal/blob/master/WebContent/index.jsp): Welcome file of application, renders login page and also can navigate to signup page.
  * [signup.jsp](https://github.com/vraj152/RUMusicPortal/blob/master/WebContent/signup.jsp): It contains sign up form for the new users.
  * [landingPage.jsp](https://github.com/vraj152/RUMusicPortal/blob/master/WebContent/landingPage.jsp): Once user gets logged in successflly, this page will br rendered.
    * User can either search song via song name or artist name or album name.
    * (Not implemented yet) Also user can browse all the songs by clicking "browse all songs".
    * And user can use core functionality of application that is recommendation. He/she can fill the form (which contains sliders) to let us know which sort of songs they want to listen. <br>
    System will build item profile based on the preference given, and will recommend songs accordingly. <br>
    P.S.: It searches through ~340K songs, so it takes 15-20 seconds to generate output.
     
<p>
  <img src="output/searchDemo"> </img>
</p>

  * [questionForm.jsp](https://github.com/vraj152/RUMusicPortal/blob/master/WebContent/questionForm.jsp): It will render the page which contains form with several fields (sliders) and will recommend 50 songs to the user.
  P.S.: Slider code is borrowed from -> [Here](https://refreshless.com/nouislider/)
  * [songPlayer.jsp](https://github.com/vraj152/RUMusicPortal/blob/master/WebContent/songPlayer.jsp): When user searches any song, he/she can play that song as well. <br>
  This page renders the music player and also below it system will recommend 15 songs based on the current song. (Demo can be found in README file of [RUMusic](https://github.com/vraj152/RUMusic)).
  
* Let me know if you have got any question/suggestion on this. :punch:
  
  
