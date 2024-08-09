
![posterrr](https://github.com/user-attachments/assets/fa36fbca-e035-45df-8c0c-13cf60b27d42)


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
•	Built using Flask and Python <br>
•	Uses the ResNet50 model to classify images of clothing items <br>
•	Integrates with the OpenWeatherMap API to retrieve current weather data <br>
•	Provides API endpoints for the frontend to retrieve recommended outfits <br>
<h2>Features</h2>
•	User authentication and authorization <br>
•	Wardrobe management (store and retrieve user wardrobe data) <br>
•	Outfit recommendation algorithm (uses ResNet50 and user data to generate recommendations) <br>
•	Push notification service (sends notifications to users) <br>

<h1>How to Run</h1>
1.	Clone the repository and navigate to the flutter_app folder <br>
2.	Run flutter pub get to install dependencies <br>
3.	Run flutter run to start the Flutter app <br>
4.	Navigate to the flask_api folder and run python app.py to start the Flask API <br>
5.	Open a web browser and navigate to http://localhost:5000 to access the API endpoints <br>
<h2>Database</h2>
The repository uses a Firebase use to store user data and wardrobe information. You will need to create a database and run the migration scripts to set up the schema.
<h2>Note</h2>
This repository is a comprehensive implementation of an outfit recommendation system, but it may require modifications to fit your specific use case. Additionally, you may need to obtain an API key from OpenWeatherMap to use their weather API. You will also need to set up a Firebase can use to store data and run the migration scripts to use the repository.

