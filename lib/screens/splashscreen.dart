import 'package:flutter/material.dart';
import 'package:tomatomaturityapp/screens/homescreen.dart';
import 'package:tomatomaturityapp/utils/appcolor.dart';
import 'package:tomatomaturityapp/widgets/appbutton.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splash_screen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primarybgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: height * 1,
              width: width * 1,
              child: const Image(
                image: AssetImage('assets/imgs/bg.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color: Color.fromARGB(189, 126, 126, 126),
                    ),
                    width: width * 0.90,
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.17,
                          width: width * 0.35,
                          child: const Image(
                            image: AssetImage('assets/imgs/2-rbg.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Text(
                          "DIAMANTE",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            color: white,
                            fontSize: height * 0.06,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "TOMATO MATURITY IDENTIFIER",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            color: white,
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.30,
                  ),
                  AppButton(
                    title: "Get Started",
                    onPress: () =>
                        Navigator.popAndPushNamed(context, HomeScreen.id),
                    fontSize: height * 0.03,
                    horizontalPadding: width * 0.3,
                    verticalPadding: height * 0.015,
                    bgColor: Colors.orange[900]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
