import 'package:flutter/services.dart';

import '/constants/constants.dart';
import '/routes/app_pages.dart';
import 'screens/bmi_result_screen.dart';

import 'screens/bmi_data_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.bmiDataScreen,
      routes: {
        Routes.bmiDataScreen: (context) => const BMIDataScreen(),
        Routes.bmiResultScreen: (context) => const BMIResultScreen(),
      },
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: primaryColorDarker,
        ),
      ),
    );
  }
}
