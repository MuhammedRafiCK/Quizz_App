import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/gk.dart';
import 'package:quiz_app/provider/science.dart';
import 'package:quiz_app/provider/sports.dart';
import 'package:quiz_app/provider/timeAndDate.dart';
import 'package:quiz_app/splashScreen.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => saveScore(),
        ),
        ChangeNotifierProvider(
          create: (context) => saveScoreSports(),
        ),
        ChangeNotifierProvider(
          create: (context) => SaveScoreScience(),
        ),
        ChangeNotifierProvider(
          create: (context) => TimeAndDate(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
    // );
  }
}
