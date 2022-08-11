import 'package:bmi_app/R/r.dart';
import 'package:bmi_app/providers/bmi_calculator_provider.dart';
import 'package:bmi_app/providers/bmi_provider.dart';
import 'package:bmi_app/providers/clock_provider.dart';
import 'package:bmi_app/screens/loading_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/routes/app_pages.dart';
import 'screens/bmi_result_screen.dart';

import 'screens/bmi_data_screen.dart';
import 'package:flutter/material.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

void main() async {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClockProvider()),
        ChangeNotifierProvider(create: (context) => BMIProvider()),
        ChangeNotifierProvider(create: (context) => BMICalculatorProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.bmiDataScreen,
        routes: {
          Routes.bmiDataScreen: (context) => const BMIDataScreen(),
          Routes.bmiResultScreen: (context) => const BMIResultScreen(),
          Routes.loadingScreen: (context) => const LoadingScreen(),
        },
        theme: ThemeData(
          primaryColor: R.appColors.primaryColor,
          scaffoldBackgroundColor: R.appColors.primaryColor,
          appBarTheme: AppBarTheme(
            backgroundColor: R.appColors.primaryColor,
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: R.appColors.primaryColorDarker,
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent),
        ),
      ),
    );
  }
}
