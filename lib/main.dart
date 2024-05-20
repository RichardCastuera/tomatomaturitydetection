import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/screens/displayscreen.dart';
import 'package:tomatomaturityapp/screens/homescreen.dart';
import 'package:tomatomaturityapp/screens/loaderscreen.dart';
import 'package:tomatomaturityapp/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tomato Maturity Classification Using ResNet50',
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ScanningImageScreen.id: (context) {
          // Extract arguments from settings.arguments as a Map<String, dynamic> first
          final Map<String, dynamic>? arguments = ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>?;
          // Extract specific arguments from the map
          final File? mainFilePath = arguments?['filePath'] as File?;
          final String? label = arguments?['label'] as String?;
          final double? confidence = arguments?['confidence'] as double?;
          return ScanningImageScreen(
            filePath: mainFilePath,
            label: label,
            confidence: confidence,
          );
        },
        DisplayImageScreen.id: (context) {
          // Extract arguments from settings.arguments as a Map<String, dynamic> first
          final Map<String, dynamic>? arguments = ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>?;
          // Extract specific arguments from the map
          final File? mainFilePath = arguments?['filePath'] as File?;
          final String? label = arguments?['label'] as String?;
          final double? confidence = arguments?['confidence'] as double?;
          return DisplayImageScreen(
            filePath: mainFilePath,
            label: label,
            confidence: confidence,
          );
        },
      },
    );
  }
}
