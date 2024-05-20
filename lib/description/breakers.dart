import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';

class BreakersTomato extends StatelessWidget {
  const BreakersTomato({super.key});

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
          "The color transition should be a clear shift from green to tannish-yellow, pink, or red, covering no more than 10% of the total area.",
          style: TextStyle(
            fontFamily: "ProximaNova",
            fontSize: height * 0.018,
            color: white,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Remaining days to fully ripen: 7 to 14 days",
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
