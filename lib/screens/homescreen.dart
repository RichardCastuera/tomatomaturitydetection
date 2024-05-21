import 'dart:io';
import 'dart:developer' as devtools;
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatomaturityapp/screens/loaderscreen.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';
import 'package:tomatomaturityapp/widgets/appiconbutton.dart';

// ImageNet mean values for zero-centering
const imageNetMean = [123.68, 116.779, 103.939];

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

// Function to preprocess the image
  Uint8List preprocessImage(Uint8List imageData) {
    // Decode the image
    img.Image image = img.decodeImage(imageData)!;

    // Resize image to 224x224 pixels
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // Convert the image from RGB to BGR and zero-center with ImageNet means
    List<double> pixels = [];
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        double r = img.getRed(pixel).toDouble();
        double g = img.getGreen(pixel).toDouble();
        double b = img.getBlue(pixel).toDouble();

        // Zero-center with ImageNet means
        b -= imageNetMean[2];
        g -= imageNetMean[1];
        r -= imageNetMean[0];

        // Add the BGR values to the list
        pixels.add(b);
        pixels.add(g);
        pixels.add(r);
      }
    }

    // Convert the list to Float32List
    Float32List float32Pixels = Float32List.fromList(pixels);
    return float32Pixels.buffer.asUint8List();
  }

  Future<void> _tfLteInit() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/model/ResNet50_DIAMANTE_60_20_20.tflite",
        labels: "assets/label/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false,
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

  Future<void> pickImageGallery() async {
    if (!isModelLoaded) return;

    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    await runInference(imageMap.path);
  }

  Future<void> pickImageCamera() async {
    if (!isModelLoaded) return;

    final ImagePicker picker = ImagePicker();
    // Open Camera.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    await runInference(imageMap.path);
  }

// Function to run model inference
  Future<void> runInference(String imagePath) async {
    File imageFile = File(imagePath);
    Uint8List imageData = imageFile.readAsBytesSync();
    Uint8List preprocessedData = preprocessImage(imageData);

    var recognitions = await Tflite.runModelOnBinary(
      binary: preprocessedData,
      numResults: 6,
      threshold: 0.3,
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
