import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'on_boarding_screen2.dart';

// ignore: use_key_in_widget_constructors
class OnBoardingScreen1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/onBoardingScreen1.png',
            ),
          )),
        ),
            Padding(
          padding: const EdgeInsets.only(left: 100, bottom: 500),
          child: Container(
            width: 209,
            height: 219,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/appLogo.png'),
              ),
            ),
          ),
        ),
            Padding(
          padding: const EdgeInsets.only(top: 145, left: 89),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Kindergarten',
                textStyle:  GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  fontSize: 33,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                speed: const Duration(milliseconds: 150),
              ),
            ],
            isRepeatingAnimation: false,
            onFinished: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen2()));
            },
          ),
        ),
          ]
      ),
    );
  }
}
