import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/vehicle_home_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import '../../constants.dart';

class VehicleFilter extends StatefulWidget {
  const VehicleFilter({super.key});

  @override
  State<VehicleFilter> createState() => _VehicleFilterState();
}

class _VehicleFilterState extends State<VehicleFilter> {


  List<String> veihcleType = [];
  List<int> vehicleReviewScore = [];
  List<String> fuelType = [];
  List<String> transmission = [];
  int minPrice = 0;
  int maxPrice = 2000;
  

  final List<String> _veicleTypesOptions = ['car', 'van', 'suv', 'bike'];
  final List<bool> _veicleTypeSelected = [false, false, false, false,];
  final List<String> _vehicleReviewScore = ['⭐⭐⭐⭐⭐', '⭐⭐⭐⭐', '⭐⭐⭐', '⭐⭐', '⭐'];
  final List<bool> _vehicleReviewSelected = [false, false, false, false, false];
  final List<String> _fuelTypeOptons = ['petrol', 'diesal'];
  final List<bool> _fuelTypeSelected = [false, false];
  final List<String> _transmissionOptons = ['auto', 'manuel'];
  final List<bool> _transmissionSelected = [false, false]; 
  


  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(onPressed: () {
                      Navigator.pop(context,MaterialPageRoute(builder: (context) => const VehicleHomeScreen()));
                    }, child: Text("❌", style: TextStyle(fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),),),
                    SizedBox(width: screenWidth * 0.1,),
                    Text("Vehicle Type", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01,),
                Column(
                children: _veicleTypesOptions.map((option) {
                  int index = _veicleTypesOptions.indexOf(option);
                  return CheckboxListTile(
                    visualDensity:  const VisualDensity(horizontal: -4, vertical: -4),
                    title: Text(option),
                    activeColor: kPrimaryColor,
                    value: _veicleTypeSelected[index],
                    onChanged: (value) {
                      setState(() {
                        _veicleTypeSelected[index] = value!;
                        if(value){
                          veihcleType.add(option);
                        } else {
                          veihcleType.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
                ),
                SizedBox(height: screenHeight * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Fuel Type", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Column(
                            children: _fuelTypeOptons.map((option) {
                            int index = _fuelTypeOptons.indexOf(option);
                            return CheckboxListTile(
                              title: Text(option),
                              visualDensity:  const VisualDensity(horizontal: -4, vertical: -4),
                              activeColor: kPrimaryColor,
                              value: _fuelTypeSelected[index],
                              onChanged: (value) {
                                setState(() {
                                  _fuelTypeSelected[index] = value!;
                                  if(value){
                                    fuelType.add(option);
                                  } else {
                                    fuelType.remove(option);
                                  }
                                });
                              },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                  children: [
                    Text("Transmission", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: screenWidth * 0.4,
                      child: Column(
                      children: _transmissionOptons.map((option) {
                        int index = _transmissionOptons.indexOf(option);
                        return CheckboxListTile(
                          title: Text(option),
                          visualDensity:  const VisualDensity(horizontal: -4, vertical: -4),
                          activeColor: kPrimaryColor,
                          value: _transmissionSelected[index],
                          onChanged: (value) {
                            setState(() {
                              _transmissionSelected[index] = value!;
                              if(value){
                                transmission.add(option);
                              } else {
                                transmission.remove(option);
                              }
                            });
                          },
                        );
                      }).toList(),
                        ),
                    ),
                  ],
                ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02,),
                // Text("Reviews Score", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                // Column(
                //   children: _vehicleReviewScore.map((option) {
                //     int index = _vehicleReviewScore.indexOf(option);
                //     return CheckboxListTile(
                //       title: Text(option),
                //       visualDensity:  const VisualDensity(horizontal: -4, vertical: -4),
                //       activeColor: kPrimaryColor,
                //       value: _vehicleReviewSelected[index],
                //       onChanged: (value) {
                //         setState(() {
                //           _vehicleReviewSelected[index] = value!;
                //           if(value){
                //           vehicleReviewScore.add((option.length.toInt()));
                //           //print(option);
                //         } else {
                //           vehicleReviewScore.remove((option.length.toInt()));
                //         }
                //         });
                //       },
                //     );
                //   }).toList(),
                //  ),
                SizedBox(height: screenHeight * 0.01,),
                Text("Filter Price", style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                RangeSlider(
                  values: RangeValues(minPrice.toDouble(), maxPrice.toDouble()),
                  min: 0,
                  max: 2000,
                  divisions: 10,
                  activeColor: kPrimaryColor,
                  labels: RangeLabels(minPrice.toString(), maxPrice.toString()),
                  onChanged: (values) {
                    setState(() {
                      minPrice = values.start.toInt();
                      maxPrice = values.end.toInt();
                     
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.01,),
                DefaultButton(text: "Filter", press: () async{
                    // save filter values
                    final pref = await SharedPreferences.getInstance();
                    await pref.setStringList('VehicleType', veihcleType);

                    String jsonString = json.encode(vehicleReviewScore);
                    await pref.setString('VehicleReviewScore', jsonString);

                    await pref.setStringList('FuelType', fuelType);
                    await pref.setStringList('TransmissionType', transmission);

                    await pref.setInt('VehicleMinPrice', minPrice);
                    await pref.setInt('VehicleMaxPrice', maxPrice);
                    
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const VehicleHomeScreen()));
                  }
                )
                
            ]),
          ),
        ),
      ),
    );
  }
}