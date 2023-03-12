import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(text: "Features", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleVehicleScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      SizedBox(height: screenHeight * 0.02,),
                      Text("🔰  Powerful engine that delivers exceptional performance and speed"),
                      SizedBox(height: screenHeight * 0.02,),
                      Text("🔰  Advanced safety features, including adaptive cruise control, automatic emergency braking, lane departure warning, and blind-spot monitoring"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}