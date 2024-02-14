import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'onboarding.dart';

late SharedPreferences sharedPreferences;
late bool? isFirstTime;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  sharedPreferences = await SharedPreferences.getInstance();
  isFirstTime = sharedPreferences.getBool('isFirstTime');
  isFirstTime = isFirstTime ?? true;
  // sharedPreferences.clear();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(splashColor: Colors.transparent),
        debugShowCheckedModeBanner: false,
        home: isFirstTime! ? const OnboardingScreen() : const HomeScreen());
  }
}
