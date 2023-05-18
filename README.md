# ShopApp
This application provides store management, placing orders, creating new products, marking favorite products. All on your account.

Application built on the basis of the course "Flutter and Dart - The Complite Guide 2022 " by Maximilian Schwarzmüller.

## Application Details:

- Architecture: [FLutter SDK](https://docs.flutter.dev/)
- Platform: Android
- API: [Firebase](https://firebase.google.com/)

## Features
- Login and logout with authorization.
- Adding, editing and deleting a product from the store. 
- Placing orders. 
- Display of all orders placed so far. 
- Marking a product as a favorite. 

## How to Run

1. Create an account at [Firebase](https://firebase.google.com/).
2. Then get your API keys
3. Clone the repo
   ```sh
   git clone https://github.com/krisdev88/ShopApp.git
   ```
4. Install all the packages by typing
   ```sh
   flutter pub get
   ```
5. Create an .env file in the root folder of the project

6. Navigate to **lib/.env** and paste your API keys to the relevant variables
   ```
   FIREBASE_KEY=Paste Your Firebase Key Here

   ```
7. Run the app using flutter run

## License

Distributed under the MIT License.	