import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';

class GreenTomato extends StatelessWidget {
  const GreenTomato({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: height * 0.03,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        const Divider(color: white),
        Text(
          "The skin of the tomatoes is entirely covered in a vibrant green color. The green hue ranges from light to dark, with a saturation level of 100%.",
          style: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: height * 0.018,
            color: white,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Remaining days to fully ripen: 20 to 30 days",
          style: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: height * 0.018,
            color: white,
          ),
        ),
      ],
    );
  }
}
