// import 'dart:io';
// import 'package:androguard/androguard.dart';
// import 'package:tflite/tflite.dart';

// class APKAnalyzer {
//   static Future<void> analyzeAPK(String apkFilePath) async {
//     // Load the TFLite model if not already loaded
//     await loadModel();

//     // Analyze APK and extract features
//     List<String> permissions = await analyzePermissions(apkFilePath);

//     // Perform prediction using the TFLite model
//     bool isMalicious = await predict(permissions);

//     // Display results to the user
//     if (isMalicious) {
//       print('The APK is detected as malicious.');
//     } else {
//       print('The APK is not detected as malicious.');
//     }
//   }

//   static Future<void> loadModel() async {
//     if (!Tflite.isModelLoaded) {
//       // Load the TFLite model
//       await Tflite.loadModel(
//         model: 'assets/model/model.tflite',
//         labels: 'assets/model/labels.txt',
//       );
//     }
//   }

//   static Future<List<String>> analyzePermissions(String apkFilePath) async {
//     // Extract permissions from the APK
//     ApkParser parser = ApkParser();
//     Apk apk = await parser.parse(File(apkFilePath));
//     List<String> permissions = apk.permissions;
//     return permissions;
//   }

//   static Future<bool> predict(List<String> permissions) async {
//     // Prepare features for prediction
//     // Convert permissions to a feature vector format expected by the model
//     // Example: Convert permissions to a one-hot encoded vector

//     // Pass the features to the TFLite model for prediction
//     List<dynamic> prediction = await Tflite.runModelOnBinary(
//       binary: permissions, // Pass features here
//       asynch: true,
//     );

//     // Interpret the prediction result
//     // Example: Check if the prediction confidence exceeds a threshold
//     double confidenceThreshold = 0.5;
//     bool isMalicious = prediction[0][0] > confidenceThreshold;
//     return isMalicious;
//   }
// }
