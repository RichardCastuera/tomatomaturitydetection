import 'dart:io';
import 'dart:developer' as devtools;
import 'package:image/image.dart' as imglib;
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatomaturityapp/screens/loaderscreen.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';
import 'package:tomatomaturityapp/widgets/appiconbutton.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? filePath;
  String label = '';
  double confidence = 0.0;
  bool isModelLoaded = false;

  @override
  void initState() {
    super.initState();
    _tfLteInit();
  }

  // Load the model
  Future<void> _tfLteInit() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/model/ResNet50_DIAMANTE.tflite",
        labels: "assets/label/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false, // defaults to false, set to true to use GPU delegate
      );
      if (res == null) {
        throw Exception("Failed to load model");
      }
      setState(() {
        isModelLoaded = true;
      });
    } catch (e) {
      devtools.log("Model loading error: $e");
    }
  }

  // Function to resize image
  String resizedImage(File file) {
    var rawBytes = file.readAsBytesSync();
    var image = imglib.decodeImage(rawBytes);
    // Resize image to 224x224 pixels
    var resizedImage = imglib.copyResize(image!, width: 224, height: 224);
    // Save resized image to a temporary file
    var tempDir = Directory.systemTemp;
    var tempFile = File('${tempDir.path}/resized_image.jpg');
    tempFile.writeAsBytesSync(imglib.encodeJpg(resizedImage));
    // Return the path to the saved resized image
    return tempFile.path;
  }

  // Function to upload picture from the local file
  Future<void> pickImageGallery() async {
    if (!isModelLoaded) return;

    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);
    // Call the resizeImage function to resize the image input
    var resImage = resizedImage(imageMap);

    setState(() {
      filePath = imageMap;
    });

    await runInference(resImage);
  }

  // Function to capture picture through device camera
  Future<void> pickImageCamera() async {
    if (!isModelLoaded) return;

    final ImagePicker picker = ImagePicker();
    // Open Camera.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);
    // Call the resizeImage function to resize the image input
    var resImage = resizedImage(imageMap);

    setState(() {
      filePath = imageMap;
    });

    await runInference(resImage);
  }

  // Function to run model inference
  Future<void> runInference(String imagePath) async {
    var recognitions = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 8,
      threshold: 0.5,
      asynch: true,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      setState(() {
        confidence = (recognitions[0]['confidence'] * 100);
        label = recognitions[0]['label'].toString();
      });
      devtools.log(recognitions.toString());
    } else {
      setState(() {
        label = "No Tomato Detected";
        confidence = 0;
      });
    }

    Navigator.pushNamed(
      // ignore: use_build_context_synchronously
      context,
      ScanningImageScreen.id,
      arguments: {
        'filePath': filePath,
        'label': label,
        'confidence': confidence,
      },
    );

    devtools.log("Navigated to DisplayImageScreen");
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: EdgeInsets.only(
            left: width * 0.05,
            right: width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.2,
                width: height * 0.2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  child: Image(
                    image: AssetImage('assets/imgs/2-rbg.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
              Text(
                "DIAMANTE",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.orange[900],
                  fontSize: height * 0.06,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "TOMATO MATURITY IDENTIFIER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.orange[900],
                  fontSize: height * 0.02,
                  letterSpacing: 5,
                ),
              ),
              SizedBox(height: height * 0.17),
              Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIconButton(
                        onPress: () => pickImageCamera(),
                        horizontalPadding: width * 0.1,
                        verticalPadding: height * 0.015,
                        iconData: Icons.camera_rounded,
                        title: "Capture",
                        bgColor: Colors.orange[900]!,
                        textColor: white,
                      ),
                      SizedBox(width: width * 0.05),
                      AppIconButton(
                        onPress: () => pickImageGallery(),
                        horizontalPadding: width * 0.11,
                        verticalPadding: height * 0.015,
                        iconData: Icons.upload_rounded,
                        title: "Import",
                        bgColor: Colors.orange[900]!,
                        textColor: white,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
