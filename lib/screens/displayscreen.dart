import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/description/breakers.dart';
import 'package:tomatomaturityapp/description/green.dart';
import 'package:tomatomaturityapp/description/lightred.dart';
import 'package:tomatomaturityapp/description/pink.dart';
import 'package:tomatomaturityapp/description/red.dart';
import 'package:tomatomaturityapp/description/turning.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';

class DisplayImageScreen extends StatefulWidget {
  static const String id = "display_image_screen";
  const DisplayImageScreen({
    super.key,
    required this.filePath,
    required this.label,
    required this.confidence,
  });

  final File? filePath;
  final String? label;
  final double? confidence;

  @override
  State<DisplayImageScreen> createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
          style: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: height * 0.03,
            color: white,
          ),
        ),
        backgroundColor: Colors.orange[900],
        foregroundColor: white,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.075, right: width * 0.075, top: height * 0.060),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          width: width * 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Container(
                  height: height * 0.4,
                  width: width * 1,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                    color: Colors.orange[800],
                  ),
                  padding: EdgeInsets.all(width * 0.02),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                    child: Image(
                      image: FileImage(widget.filePath!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),
              Container(
                width: width * 1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  color: Colors.orange[800],
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.015),
                child: Column(
                  children: [
                    Text(
                      widget.label!,
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                    Text(
                      "Confidence Rate: ${widget.confidence!.toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontSize: height * 0.018,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.015),
              Container(
                width: width * 1,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  color: Colors.blueGrey,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.015,
                  horizontal: width * 0.03,
                ),
                child: (widget.label!.toLowerCase() == 'breakers')
                    ? const BreakersTomato()
                    : (widget.label!.toLowerCase() == 'green')
                        ? const GreenTomato()
                        : (widget.label!.toLowerCase() == 'light red')
                            ? const LightRedTomato()
                            : (widget.label!.toLowerCase() == 'pink')
                                ? const PinkTomato()
                                : (widget.label!.toLowerCase() == 'red')
                                    ? const RedTomato()
                                    : (widget.label!.toLowerCase() == 'turning')
                                        ? const TurningTomato()
                                        : Container(
                                            color: Colors.transparent,
                                          ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
