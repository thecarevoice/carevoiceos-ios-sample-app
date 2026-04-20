# CareVoiceOS iOS SDK Sample App

This sample application demonstrates how to integrate and use the **CareVoiceOS iOS SDK** in a native iOS project. It provides practical examples of using the SDK's API, including authentication and launching wellness features for iOS development.

## Watch the Integration Demo

To help you get started, we have created a step-by-step demo video that walks you through the entire iOS integration process.

The integration process is designed to be straightforward, allowing you to focus on building your iOS app while we handle the SDK integration.

<video width="800" controls>
  <source src="https://carevoiceos-public.s3.us-west-2.amazonaws.com/ios_sample_app.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>


## Prerequisites

Before running the iOS sample app, ensure you have the following iOS development tools:

- **macOS 12.0 (Monterey) or higher**
- **Xcode 16.0 or higher**
- **iOS 14.0 or higher**
- **CocoaPods 1.11.0 or higher**
- **Swift 5.5 or higher**
- **Command Line Tools for Xcode installed**
- **Physical iOS device or iOS Simulator**

## Step 1: Download and Set up the Backend Simulation Service (Demo API)

This backend simulation service will mimic a client backend or MyClient backend service, handling authentication and integration with the CareVoiceOS OpenAPI.

1. **Clone the Demo API Repository**
   
   Download the Demo API repository: `https://github.com/thecarevoice/carevoiceos-demo-api`
   
   Execute the following commands in your terminal:
   ```bash
   git clone https://github.com/thecarevoice/carevoiceos-demo-api
   cd carevoiceos-demo-api
   ```

2. **Configure Environment Variables**
   
   Copy the `client.env` file from the shared directory and rename it to `.env` within the `carevoiceos-demo-api` directory.
   ```bash
   cp client.env .env
   ```
   
   **Note**: The values for `CAREVOICE_API_KEY`, `CAREVOICE_CLIENT_ID`, `CAREVOICE_CLIENT_SECRET`, and `CAREVOICE_GROUP` should match the credentials you received. `JWT_SECRET` should be a strong, random string.

3. **Install Dependencies and Start the Backend Service**
   
   Install all necessary Node.js dependencies:
   ```bash
   npm install
   ```
   
   Start the development server:
   ```bash
   npm run dev
   ```
   
   The backend service should now be running at `http://localhost:3005`.

## Step 2: Download and Set up the iOS Demo Application

This iOS application will simulate the MyClient application and integrate the CareVoiceOS SDK.

1. **Clone the iOS Demo Repository**
   
   Download the iOS Demo repository: `https://github.com/thecarevoice/carevoiceos-ios-sample-app.git`
   
   Execute the following commands in your terminal:
   ```bash
   git clone https://github.com/thecarevoice/carevoiceos-ios-sample-app.git
   cd carevoiceos-ios-sample-app/carevoicesDemo
   ```

2. **Install CocoaPods Dependencies**
   
   **Note**: If you need to log in to access CareVoice CocoaPods repositories during the setup, please refer to `nexus-credential.md` for the necessary credentials.
   
   Install CocoaPods dependencies:
   ```bash
   pod install
   ```
   
   This will download and configure the CareVoiceOS SDK and all required dependencies

3. **Open Xcode Workspace**
   
   Open the `.xcworkspace` file (NOT the `.xcodeproj` file):
   ```bash
   open carevoicesDemo.xcworkspace
   ```
   
   Wait for Xcode to load and index the project

4. **Configure Backend API Connection**
   
   The demo app is configured the network host in `Config.swift`:
   ```swift
   struct Config {
       static let baseURL = "http://localhost:3005"
   }
   ```
   
   - For iOS Simulator, `localhost:3005` should work directly
   - For physical devices, you may need to use your computer's IP address instead of `localhost`

5. **Verify SDK Integration**
   
   The CareVoiceOS SDK is integrated through CocoaPods with the following pods:
   ```ruby
   pod 'CVDesign/iOS' , '3.1.1'
   pod 'CVCommon/iOS' , '3.1.1'
   pod 'CVWellness/iOS' , '3.1.1'
   ```
   

## Step 3: Build and Run the iOS Application

1. **Select Target Device**
   
   In Xcode, select either an iOS Simulator or a connected physical iOS device from the device dropdown. Ensure your device runs iOS 15.1 or higher.

2. **Configure Signing (if using physical device)**
   
   - Select the project in the Xcode navigator
   - Go to the "Signing & Capabilities" tab
   - Select your development team
   - Xcode will automatically manage provisioning profiles

3. **Build and Run**
   
   - Press `Cmd + R` or click the "Run" button in Xcode
   - Wait for the build to complete
   - The app should install and launch on your selected device

## Step 4: Register and Activate the SDK in the Demo App

1. **Launch the Demo App**
   
   - The iOS Demo application should successfully launch on your device/simulator
   - You should see a modern login interface with CareVoice branding

2. **Register User**
   
   - Tap on the registration option or sign-up button
   - Fill in the required user information:
     - Email address
     - Password
     - Any additional required fields
   - Submit the registration form
   - This will create a user in your backend simulation service

3. **Login and Activate SDK**
   
   - Use the registered credentials to log in
   - Upon successful authentication, the app will:
     - Receive an authentication token from the backend
     - Initialize the CareVoiceOS SDK with the token and tenant code
     - Navigate to the main wellness dashboard

4. **Access CareVoiceOS Features**
   
   - After successful login, you should see the main navigation with wellness features
   - The CareVoiceOS SDK will be fully activated and ready to use


We hope this guide helps you complete the iOS SDK integration successfully! If you encounter any issues at any step, please check the Xcode console output or contact the CareVoiceOS support team.
