import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tour_drive_frontend/provider/internet_provider.dart';
import 'package:tour_drive_frontend/provider/sign_in_provider.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
// import 'package:tour_drive_frontend/screens/navbar_pages/drive_option_screen.dart';
// import 'package:tour_drive_frontend/screens/navbar_pages/emergency_screen.dart';
// import 'package:tour_drive_frontend/screens/navbar_pages/tour_option_screen.dart';
// import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
// import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_check_availability.dart';
// import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_feedback_screen.dart';
// import 'package:tour_drive_frontend/screens/authentication/forget_password/forget_password_screen.dart';
// import 'package:tour_drive_frontend/screens/navbar_pages/landing_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/landing_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_page_sreen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/tour_option_new.dart';
import 'package:tour_drive_frontend/screens/tour_screen/Single_tour_screen/sub_pages/tour_feedback_screen.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/screens/tour_screen/tour_home_screen.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
// import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
// import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_page_sreen.dart';
// import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
// import 'package:tour_drive_frontend/screens/authentication/sign_up/sign_up_screen.dart';
// import 'package:tour_drive_frontend/screens/tour_screen/tour_filter.dart';
// import 'package:tour_drive_frontend/screens/tour_screen/tour_home_screen.dart';
// import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
// import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/sub_pages/vehicle_check_availability.dart';
// import 'package:tour_drive_frontend/screens/vehicle_screen/vehicle_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51N1atlGJCiP6SiMGdIAuABxakpw7SAEIIhIfUJMX2i6PzeRLVTH88yj79nnURfSybXGxKAC6iFcXfIdfdFJzjcgh00ZjbmbfNr";
     await Firebase.initializeApp();
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
    return MultiProvider(
      providers: [ ChangeNotifierProvider(
            create: (context) => SignInProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => InternetProvider(),
          ),],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: "TourDrive",
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
        ),
    
        //home: const LogInScreen(),
        //home: const ForgetPasswordScreen(),
        //home: const SignUpScreen(),
         home: const LoadingScreen(), // first page of the app
    
        //home: const FeedbackForm(),
    
        //home: const TourFeedbackForm(),
    
        //home: const TourHomeScreen(),
        // home: const NavbarMainPage(),  // navbar screen
        //initialRoute: LoadingScreen.routeName,
        // routes: routes,
        //home: const LandingScreen(),
        //home: const ProfileScreen(),
        // home: SingleTourScreen(),
        //home: SingleTourScreen(),
        //home: VehicleHomeScreen(),
        //home: SingleVehicleScreen(),
        //home: VehicleCheckAvailability(),
        //home: const EmergencyScreen(),
        //home:  CardListScreen(),
        //home: TourHomeScreen(),
        //home: TourFilter(),
        //home:  TourCheckAvailabilityScreen(),
        //home: TourOptionNewScreen(),
        
      ),
    );
  }
}
