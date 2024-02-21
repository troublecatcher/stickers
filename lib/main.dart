import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'onboarding_screen.dart';

late SharedPreferences sharedPreferences;
late bool? isFirstTime;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  isFirstTime = sharedPreferences.getBool('isFirstTime');
  isFirstTime = isFirstTime ?? true;
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
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          listTileTheme: ListTileThemeData(
            iconColor: Colors.red,
          ),
          splashColor: Colors.transparent,
          appBarTheme: AppBarTheme(
              titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontFamily: 'Numberplate',
                  ),
              color: Colors.redAccent,
              iconTheme: IconThemeData(color: Colors.white)),
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Numberplate',
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: isFirstTime! ? const OnboardingScreen() : const HomeScreen());
  }
}
