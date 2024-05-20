import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tomatomaturityapp/screens/displayscreen.dart';

class ScanningImageScreen extends StatefulWidget {
  static const String id = "scanning_image_screen";

  const ScanningImageScreen({
    super.key,
    required this.filePath,
    required this.label,
    required this.confidence,
  });

  final File? filePath;
  final String? label;
  final double? confidence;

  @override
  State<ScanningImageScreen> createState() => _ScanningImageScreenState();
}

class _ScanningImageScreenState extends State<ScanningImageScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).popAndPushNamed(
      DisplayImageScreen.id,
      arguments: {
        'filePath': widget.filePath,
        'label': widget.label,
        'confidence': widget.confidence,
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitPouringHourGlass(
            color: Colors.orange[900]!,
            size: 60.0,
            controller: _animationController,
          ),
          SizedBox(height: height * 0.02),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontFamily: "ProximaNova",
                fontSize: height * 0.018,
                color: Colors.orange[900]!,
              ),
              children: const [
                TextSpan(
                    text:
                        "We are currently in the process of identification.\n"),
                TextSpan(
                    text:
                        "Please allow us a few moments to analyze your sample.\n"),
                TextSpan(text: "You will receive the results shortly after!"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
