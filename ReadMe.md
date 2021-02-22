# Ovia Health Project by Ishaan Gupta

#### Q1 At high level, how does your app work?
Ans1. I have used the MVC model to develop the app. The view has been build using the Storyboard. I build a networking layer that allows to fetch movie data from the omdb website. The networking layer is also responsible for downloading posters of the movies to display in the app.
#### Q2 What design decisions did you make and why?
Ans2. I chose the MVC architecture to build this app. I consider this design appropriate for this kind of app because it allows modularizing various parts of the app as well as plays a crucial role in the easy testing of the app. The user interacts with the view which triggers functions in the controller which helps in providing information back to the view with the help of the model and the networking layer.
#### Q3 What design patterns or architecture might be necessary in the future?
Ans3. Depending on the features in the app, MVVM, MVP, or SOA design patterns could be used in the future.
#### Q4 How would we extend your app if we had to add functionality?
Ans4. It would depend on what kind of functionality needs to be added. For example, if we want to allow users to search movies by other parameters like year or language, we would need to do some modifications in the networking layer; namely making the fetchData a more generic function by passing a dictionary which would contain other url parameters. It would also require some modifications in the view as well.
#### Q5 How might you change the architecture of the app if the data model and end point code needed to be reused in a second app?
Ans5. I would create a service for it that could be injected in the second app.
#### Q6 What documentation, websites, papers, etc. did you consult for this assignment?
Ans6. I consulted StackOverflow for some of the errors I faced while developing the app.
#### Q7 What third-party libraries or other tools does your application use? How did you choose each library or framework you used?
Ans7. I used 2 third-party libraries to develop this app. I installed them using CocoaPods and they are called Cosmos and JGProgressHUD. I used Cosmos to display the star rating of the movies and I used JGProgressHUD to display the loading indicator. 
#### Q8 How long did you spend on this exercise? If you had unlimited time to spend on this, how would you spend it and how would you prioritize each item?
Ans8. ~2hours. 
If I had unlimited time, I would use it to test the app more rigorously and change some UI. My priority would also be in the same order as well, i.e. first testing and then working on UI.
#### Q9 If you were going to implement a level of automated testing to prepare this for a production environment, how would you go about doing so?
Ans9. For some basic automated testing, one could use tools available in Xcode to implement them as I have done in the app. Using other software like Jenkins and Appium would be another approach.
#### Q10 If you were unable to finish the exercise, what issues did you face and how did you plan on finishing the exercise?
Ans10. N/A
#### Q11.  Prove that the “Movie not found” warning will be displayed if there are no search results?
Ans11. I have proved this using UI testing in Xcode. The code for it is in the repo. I simulate typing nonsense words in the search bar and check if the movie name's label's text has been changed to 'Movie not found' or not.
