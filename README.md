# Self-Checkout Mobile Application 
Using Flutter and Firebase
![ScanGo mobile application flyer design](https://github.com/sunalii/Self-Checkout-Mobile-App/blob/master/assets/ScanGo%20Poster.png)

## Features
- Developement is based on **Flutter**.
- Supports on **Android**.
- Barcode/QR Code **scanning**.
- Integrated for **Stripe API**.

## Libraries
- Find and use packages to build Dart and Flutter apps from [pub.dev](https://pub.dev/). <br>
 ```flutter_barcode_scanner```, ```flutter_credit_card```, ```flutter_spinkit```, ```stripe_payment```, ```http```, ```cloud_firestore```, ```firebase_auth```, ```shared_preferences```, ```google_fonts```, ```progress_dialog```

## API
### Firebase API
- Create a [Firebase](https://firebase.google.com/) project and add your own Firebase  ```google-services.json``` file to project root folder (App uses **Firestore** to save login details).

### Stripe API
- [Stripe](https://stripe.com/) (free plan) was used to do payments from the mobile app.
- Replace the ```payment_services.dart``` file with your own *SECRET KEY* and *PUBLIC KEY* from your Stripe account.

## Hardware requirements
- Smartphone enabled with camera.

## How the application works
- Scan barcodes/QR codes of products to add them to cart.
- The payments can be done only upon an equal total weight of the products brought were verified by scanning a equally weighted QR code.

## Installation
1. Add your Firebase ```google-services.json``` to the project
2. Add your Stripe API *SECRET KEY* and *PUBLIC KEY* in ```payment_services.dart``` 
3. Update dependencies in ```pubspec.yaml``` file.
