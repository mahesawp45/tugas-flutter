import 'package:bmi_app/database/alarm_hive.dart';
import 'package:bmi_app/providers/alarm_provider.dart';
import 'package:bmi_app/providers/bmi_calculator_provider.dart';
import 'package:bmi_app/providers/bmi_provider.dart';
import 'package:bmi_app/providers/clock_provider.dart';
import 'package:bmi_app/providers/dark_mode_provider.dart';
import 'package:bmi_app/screens/loading_screen.dart';
import 'package:bmi_app/screens/splash_screen.dart';
import 'package:bmi_app/styles/theme_styles.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '/routes/app_pages.dart';
import 'screens/bmi_result_screen.dart';

import 'screens/bmi_data_screen.dart';
import 'package:flutter/material.dart';

// Nama DB
const String alarmBox = 'alarmhive';
const String darkModeBox = 'darkMode';

// LOCAL Notif
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT HIVE
  await Hive.initFlutter();

  // REGISTER si ADAPTER
  Hive.registerAdapter(AlarmHiveAdapter());

  await Hive.openBox(alarmBox);
  await Hive.openBox(darkModeBox);

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });

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
  DarkModeProvider? darkModeProvider;

  @override
  void initState() {
    super.initState();
    darkModeProvider = Provider.of(context, listen: false);
    darkModeProvider?.getDarkMode() ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClockProvider()),
        ChangeNotifierProvider(create: (context) => BMIProvider()),
        ChangeNotifierProvider(create: (context) => BMICalculatorProvider()),
        ChangeNotifierProvider(create: (context) => DarkModeProvider()),
        ChangeNotifierProvider(create: (context) => AlarmProvider()),
      ],
      child: Consumer<DarkModeProvider>(
          builder: (context, darkModeProvider, child) {
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
          theme:
              Styles.themeData(darkModeProvider.getDarkMode() ?? true, context),
        );
      }),
    );
  }
}
