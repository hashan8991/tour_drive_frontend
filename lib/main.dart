import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/routes.dart';
import 'package:tour_drive_frontend/screens/sign_in/login_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    DevicePreview(
      builder: (context) =>  const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TourDrive",
      theme: ThemeData(
        backgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
      ),
      home: const LogInScreen(),
      // initialRoute: LogInScreen.routeName,
      // routes: routes,
    );
  }
}