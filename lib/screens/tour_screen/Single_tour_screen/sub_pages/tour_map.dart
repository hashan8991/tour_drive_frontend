import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/tour_screen/Single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class TourMapScreen extends StatefulWidget {
  const TourMapScreen({super.key});

  @override
  State<TourMapScreen> createState() => _TourMapScreenState();
}

class _TourMapScreenState extends State<TourMapScreen> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Header(text: "Tour Map", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    
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