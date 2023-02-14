import 'package:flutter/widgets.dart';
import 'screens/sign_in/login_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LogInScreen.routeName: (context) => const LogInScreen(),
  
};