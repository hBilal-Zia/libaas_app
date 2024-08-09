
![33](https://github.com/user-attachments/assets/ad194768-7c3b-4eea-987d-1381d76f2124)

•Brief OverView:
This repository implements a comprehensive outfit recommendation system that integrates a Flutter frontend with a Flask backend. The system uses the ResNet50 model to classify images of clothing items and recommends outfits based on the user's preferences, wardrobe, and current weather

<h1>Frontend (Flutter) </h1> 
•	Built using Flutter and Dart <br>
•	Uses the GetX package for state management<br>
<h2>Features</h2>
•	Account Signup & Login <br>
•	Wardrobe Management (add, edit, delete clothing items) <br>
•	Outfit Recommendation (based on user preferences, wardrobe, and weather) <br>
•	Weekly Outfit Plan (generate a weekly plan based on user preferences) <br>
•	Outfit Feedback (allow users to rate and comment on recommended outfits) <br>
•	Recommendation History (display previous outfit recommendations) <br>
•	Push Notifications (send notifications for new outfit recommendations) <br>
•	Virtual Try-On (allow users to try on outfits virtually using augmented reality)<br>

<h1>Backend (Flask) </h1>
•	Built using Flask and Python
•	Uses the ResNet50 model to classify images of clothing items
•	Integrates with the OpenWeatherMap API to retrieve current weather data
•	Provides API endpoints for the frontend to retrieve recommended outfits
•	Features:
•	User authentication and authorization
•	Wardrobe management (store and retrieve user wardrobe data)
•	Outfit recommendation algorithm (uses ResNet50 and user data to generate recommendations)
•	Push notification service (sends notifications to users)
Files and Folders:
•	flutter_app: contains the Flutter frontend code
•	flask_api: contains the Flask backend code
•	models: contains the ResNet50 model and other machine learning models
•	utils: contains utility functions for image processing and API integration
•	database: contains the database schema and migration scripts

<h1>How to Run</h1>
1.	Clone the repository and navigate to the flutter_app folder
2.	Run flutter pub get to install dependencies
3.	Run flutter run to start the Flutter app
4.	Navigate to the flask_api folder and run python app.py to start the Flask API
5.	Open a web browser and navigate to http://localhost:5000 to access the API endpoints
Database:
The repository uses a Firebase use to store user data and wardrobe information. You will need to create a database and run the migration scripts to set up the schema.
Note:
This repository is a comprehensive implementation of an outfit recommendation system, but it may require modifications to fit your specific use case. Additionally, you may need to obtain an API key from OpenWeatherMap to use their weather API. You will also need to set up a Firebase can use to store data and run the migration scripts to use the repository.

