import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:geolocator/geolocator.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {

  String latitude = '';
  String longtitude = '';

  void getLocation() async{
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude.toString();
    longtitude = position.longitude.toString();
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kTextColor),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          leading: IconButton(
            onPressed: () {
             
            },
            icon: const Icon(
                Icons.arrow_back_ios, color: Colors.white,), //replace with our own icon data.
          ),
          title: const Text(
            'Emergency Contact',
            textAlign: TextAlign.center,
            style: TextStyle(color: kTextColor),
          ),
        ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03,),
            Text("Let's ride safely!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.025),),
            SizedBox(height: screenHeight * 0.03,),
            Text("When You ride using this profile ,preference will be selected by default.", style: TextStyle( fontSize: screenHeight * 0.02),),
            
            SizedBox(height: screenHeight * 0.04,),
            DefaultButton(text: "ADD SOS", press: (){
              getLocation();
              if(latitude == '' && longtitude == ''){
            
              }
             
               
            }),
          ],
        ),
        ),
        
    );
  }
}