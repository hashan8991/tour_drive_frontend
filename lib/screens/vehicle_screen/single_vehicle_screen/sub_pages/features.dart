import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class FeaturesScreen extends StatefulWidget {
  final String vehicleFeatures;
  const FeaturesScreen({super.key,required this.vehicleFeatures});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  //final String vehicleFeature = widget.vehicleFeatures;
  List<String> vehicleFeatureList = [];

  @override
  void initState()  {
    super.initState();
    vehicleFeatureList =  widget.vehicleFeatures.split('\n');
    print(vehicleFeatureList);
  }
  

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(text: "Features", press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleVehicleScreen()));
            } ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: vehicleFeatureList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("🔰 ${vehicleFeatureList[index]}", style: TextStyle(fontSize: screenHeight * 0.02)),
                  );
                }
              
                ),
            ),
          ],
        ),
      ),
    );
  }
}