import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';

class LightRedTomato extends StatelessWidget {
  const LightRedTomato({super.key});

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
          "More than 60% of the surface, in the aggregate, shows pinkish-red or red: Provided, that not more than 90% of the surface is red color.",
          style: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: height * 0.018,
            color: white,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Remaining days to fully ripen: 2 to 3 days",
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
