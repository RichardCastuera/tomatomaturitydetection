import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPress,
    required this.fontSize,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.bgColor,
  });
  final String title;
  final Function()? onPress;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        backgroundColor: bgColor,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: white,
          fontFamily: 'ProximaNova',
          fontSize: fontSize,
        ),
      ),
    );
  }
}
