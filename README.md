# CareVoiceOS iOS Sample App

This repository contains the iOS native sample app for integrating with the CareVoiceOS SDK. It demonstrates the usage of the CareVoiceOS SDK features in a native iOS application.

## Prerequisites

Before you begin, ensure you have the following:

1. **macOS**: A Mac computer running macOS.
2. **Xcode**: Version 16.0 or later installed from the Mac App Store.
3. **CocoaPods(latest version recommended)**: Installed on your system. If not, install it using the following command:
```bash
sudo gem install cocoapods
```
4. **iOS**: Version 15.1 or higher installed on your device or simulator.


## Getting Started. 
Follow these steps to set up and run the sample app:

#### Clone the Repository
```bash
git clone https://github.com/CareVoiceOS/carevoiceos-ios-sample-app.git
```

#### Navigate to the Project Directory
```bash
cd carevoiceos-ios-sample-app/CareVoiceOSDemo
```

#### Install Dependencies
Install the required dependencies using CocoaPods:
```bash
pod install
```
This will download and integrate all the necessary libraries and frameworks specified in the `Podfile`.

####  Build and Run the App
Open the project in Xcode:
```bash
open CareVoiceOSDemo.xcworkspace
```
Build and run the app on your preferred device or simulator. You can do this by clicking the "Run" button in Xcode or using the keyboard shortcut `Cmd + R`.


### Notes
- Authentication & Token Management: For details on authentication flows and token refresh, see the main [Authentication Guide](https://doc.carevoiceos.com/en/sdk/authentication.html).
- The app uses a local server for authentication (http://localhost:3005). Ensure the server is running and accessible. More details refer to the [carevoiceos-demo-api repository](https://github.com/thecarevoice/carevoiceos-demo-api).
