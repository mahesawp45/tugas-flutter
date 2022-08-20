import 'package:bmi_app/providers/bmi_calculator_provider.dart';
import 'package:bmi_app/providers/bmi_provider.dart';
import 'package:bmi_app/providers/clock_provider.dart';
import 'package:bmi_app/providers/dark_theme_provider.dart';
import 'package:bmi_app/screens/loading_screen.dart';
import 'package:bmi_app/screens/splash_screen.dart';
import 'package:bmi_app/styles/theme_styles.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/routes/app_pages.dart';
import 'screens/bmi_result_screen.dart';

import 'screens/bmi_data_screen.dart';
import 'package:flutter/material.dart';

const String alarmBox = 'alarm';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT HIVE
  await Hive.initFlutter();

  // BUAT DB
  await Hive.openBox(alarmBox);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme().then((value) => themeChangeProvider.darkTheme = value);
  }

  Future<bool> getCurrentAppTheme() async {
    var dark = await themeChangeProvider.darkThemePreference.getTheme();
    return themeChangeProvider.darkTheme = dark;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClockProvider()),
        ChangeNotifierProvider(create: (context) => BMIProvider()),
        ChangeNotifierProvider(create: (context) => BMICalculatorProvider()),
        ChangeNotifierProvider(create: (context) => DarkThemeProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (context, darkThemeProvider, child) {
        return MaterialApp(
          title: 'BMI APP | ID CAMP',
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          routes: {
            Routes.splashScreen: (context) => const SplashScreen(),
            Routes.bmiDataScreen: (context) => const BMIDataScreen(),
            Routes.bmiResultScreen: (context) => const BMIResultScreen(),
            Routes.loadingScreen: (context) => const LoadingScreen(),
          },
          theme: Styles.themeData(darkThemeProvider.darkTheme, context),
        );
      }),
    );
  }
}
