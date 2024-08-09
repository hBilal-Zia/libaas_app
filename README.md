![33](https://github.com/user-attachments/assets/ad194768-7c3b-4eea-987d-1381d76f2124)

DartFlix is a Content-Based-Movie-Recommender which gives recommendations based on KNN.

A Content-Based Recommender works by the data that we take from the user, either explicitly (rating) or implicitly (clicking on a link). By the data we create a user profile, which is then used to suggest to the user, as the user provides more input or take more actions on the recommendation, the engine becomes more accurate.

Content Based Recommender System recommends movies similar to the movie user likes and analyses the sentiments on the reviews given by the user for that movie.

The details of the movies(title, genre, runtime, rating, poster, etc) are fetched using an API created in this project using Flask and Machine learning, https://enage22.herokuapp.com/ and https://www.themoviedb.org/documentation/api, and using the IMDB id of the movie in the API, I did web scraping to get the reviews given by the user in the IMDB site using beautifulsoup4 and performed sentiment analysis on those reviews.It uses recommendations fetched from api made by me https://enage22.herokuapp.com/.

There is a Movie search feature which will show all the recommended movies from the movies name.

DartFlix uses users movie taste to show recommended movies in the homepage.

It also stores the users previously watched movies.

There is a Movie review tab which shows all reviews and performed sentiment analysis on those reviews.
