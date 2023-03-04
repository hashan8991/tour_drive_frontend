import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/routes.dart';
import 'package:tour_drive_frontend/screens/feedback/feedback_screen.dart';
import 'package:tour_drive_frontend/screens/forget_password/forget_password_screen.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
import 'package:tour_drive_frontend/screens/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/screens/sign_up/sign_up_screen.dart';
import 'package:tour_drive_frontend/screens/tour_home_screen/tour_home_screen.dart';

void main() {
  runApp(const MyApp());
}

// void main() {
//   runApp(
//     DevicePreview(
//       builder: (context) =>  const MyApp(),
//     ),
//   );
// }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TourDrive",
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
      ),
    
      //home: const LogInScreen(),
      //home: const ForgetPasswordScreen(),
      //home:  SignUpScreen(),
      //home: const LoadingScreen() ,
      //home: const FeedbackForm(),
      home: const TourHomeScreen(),
      //initialRoute: LoadingScreen.routeName,
     // routes: routes,
    );
  }
}