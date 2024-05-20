import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';

class RedTomato extends StatelessWidget {
  const RedTomato({super.key});

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
          "More than 90% of the surface, in the aggregate, shows red color.",
          style: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: height * 0.018,
            color: white,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Remaining days to fully ripen: 1 to 2 days",
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
