import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
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
              Header(text: "Description", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleVehicleScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: screenHeight * 0.02,),
                      Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sagittis, arcu vitae fringilla sollicitudin, orci ex euismod ligula, pellentesque porttitor dui purus quis lectus. Vivamus magna mi, suscipit ut urna ut, maximus dignissim nisl. Praesent eget justo a nisl accumsan lobortis. Nulla auctor mattis finibus. Vivamus erat nibh, accumsan ut malesuada non, egestas quis nisi. Quisque tristique diam vel eleifend tristique. Vestibulum pharetra semper nunc elementum maximus. Pellentesque pellentesque justo at purus faucibus, a sodales felis posuere. Praesent in tempus ex. Duis lectus ex, suscipit at ligula quis, fermentum lacinia odio. Cras fermentum vulputate diam, eu tempus urna hendrerit malesuada. Aliquam eleifend elit at elit ultrices blandit at at metus. In consequat purus in ex congue ultricies. Vestibulum non iaculis erat, sit amet blandit lacus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eget ex non dolor mattis pharetra.", style: TextStyle(fontSize: screenHeight * 0.017,)),
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