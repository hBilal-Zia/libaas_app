

<img src="https://github.com/user-attachments/assets/e3969dbe-04cc-4be8-ba5c-e9742caf590c" width="800" height="500">
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
<h2>Prerequisites</h2>
•	Operating System <br>
Ensure you have a compatible OS 10 & 11 (Windows, macOS, or Linux) <br>
<h2>Hardware</h2>
At least 4GB of RAM (8GB recommended) and 2.8 GB of free disk space (more required for Flutter development) <br>
3.2.2. Install Android Studio
•Download Android Studio: <br>
•	Go to the Android Studio download page.
•	Download the installer for your OS <br>
3.2.3. Run the Installer: <br>
•	For Windows: Double-click the .exe file and follow the prompts <br>
•	For macOS: Open the .dmg file and drag Android Studio to your Applications folder <br>
•	For Linux: Extract the .zip file and run the studio.sh script from the command line <br>
3.2.4. Complete Setup:
•	Follow the setup wizard to install the necessary SDK packages <br>
•	You may need to install additional components such as the Android SDK and Android SDK Build-Tools <br>
 <h3>Install Flutter </h3> <br>
•	Download Flutter SDK <br>
•	Visit the Flutter SDK download page <br>
•	Download the stable release for your OS <br>
 • Extract the SDK <br>
•	Extract the downloaded .zip file to a suitable location on your file system <br>
•	For example, on macOS and Linux, you can extract it to your home directory: ~/flutter <br>
Add Flutter to PATH <br>
•	Add the flutter/bin directory to your system's PATH environment variable <br>
•	For Windows, modify your PATH in the Environment Variables settings <br>
•	For macOS and Linux, add export PATH="$PATH:<flutter-directory>/flutter/bin" to your .bashrc, .zshrc, or .bash_profile file <br>
Verify Installation: <br>
•	Open a terminal or command prompt and run flutter doctor to ensure everything is set up correctly <br>
Configure Android Studio for Flutter <br>
•	Install Flutter Plugin <br>
•	Open Android Studio <br>
•	Go to File > Settings (or Android Studio > Preferences on macOS) <br>
•	Navigate to Plugins and search for "Flutter" <br>
•	Install the Flutter plugin (this will also install the Dart plugin) <br>
•	Restart Android Studio <br>
•	Restart Android Studio to activate the new plugins <br>
 <h3>Create a New Flutter Project </h3>
•	Start a New Project:
•	Open Android Studio.
•	Go to File > New > New Project.
•	Select "Flutter" from the project type options.
•	Click "Next".
•	Configure Project:
•	Enter a project name, location, and other details.
•	Click "Finish" to create the project.
•	Run Your Flutter App:
•	Connect an Android device or start an emulator.
•	Click the green "Run" button (a play icon) in Android Studio to build and run your app.
3.2.10.   Common Flutter Commands
•	Run App: flutter run
•	Build APK: flutter build apk
•	Build iOS App: flutter build ios
•	Update Flutter: flutter upgrade
•	Install Packages: flutter pub get
3.2.11. Troubleshooting
•	If you encounter issues, refer to the Flutter documentation or the Android Studio documentation.
This repository is a comprehensive implementation of an outfit recommendation system, but it may require modifications to fit your specific use case. Additionally, you may need to obtain an API key from OpenWeatherMap to use their weather API. You will also need to set up a Firebase can use to store data and run the migration scripts to use the repository.

