import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/routes.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_feedback_screen.dart';
import 'package:tour_drive_frontend/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/landing_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_page_sreen.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:tour_drive_frontend/screens/tour_screen/tour_home_screen.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/sub_pages/vehicle_check_availability.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/vehicle_home_screen.dart';

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
      //home: SignUpScreen(),
      home: const LoadingScreen(), // first page of the app

      //home: const FeedbackForm(),

      //home: const TourFeedbackForm(),

      //home: const TourHomeScreen(),
      //home: const NavbarMainPage(),
      //initialRoute: LoadingScreen.routeName,
      // routes: routes,
      //home: const LandingScreen(),
      // home: const ProfileScreen(),


      // home: SingleTourScreen(),


      //home: SingleTourScreen(),
      //home: VehicleHomeScreen(),
      //home: SingleVehicleScreen(),
      //home: VehicleCheckAvailability(),


    );
  }
}
