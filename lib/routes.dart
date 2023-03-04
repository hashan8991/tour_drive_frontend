 import 'package:flutter/widgets.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
import 'screens/sign_in/login_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoadingScreen.routeName: (context) => const LoadingScreen(),
  //LogInScreen.routeName: (context) => const LogInScreen(),
  
};