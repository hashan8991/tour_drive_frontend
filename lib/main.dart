import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    DevicePreview(
      builder: (context) =>  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: ContinueScreen(),
    );
  }
}