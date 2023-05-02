import 'package:curving/core/components/colors/colors.dart';
import 'package:curving/view/pages/homepage.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      loaderColor: orangeColor,
      backgroundColor: bgColor,
      navigator: const HomePage(),
      durationInSeconds: 3,
      title: Text(
        "Curving",
        style: GoogleFonts.lobster(
          fontSize: 28,
          color: textColor,
        ),
      ),
      logo: Image.asset("assets/images/curvingTR.png"),
    );
  }
}
