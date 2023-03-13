import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class VehicleCheckAvailability extends StatefulWidget {
  const VehicleCheckAvailability({super.key});

  @override
  State<VehicleCheckAvailability> createState() => _VehicleCheckAvailabilityState();
}

class _VehicleCheckAvailabilityState extends State<VehicleCheckAvailability> {

  TextEditingController dateController = TextEditingController();
  String drivingOption = "With driver";
  var items = [
    "With driver",
    "Without driver"
  ];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
    );

    if (picked != null) {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    
     final double screenWidth = MediaQuery.of(context).size.width;
     final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Header(text: "", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleVehicleScreen()));
              }),
              SizedBox(height: screenHeight * 0.04,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: screenWidth * 0.9 ,
                    height: screenHeight * 0.7,
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(115, 155, 239, 254),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15), // shadow color
                          spreadRadius: 1.0, // how wide the shadow is
                          blurRadius: 5.0, // how soft the shadow is
                          offset: const Offset(0, 3), // offset of the shadow
                        ),
                      ],
                      borderRadius:
                          BorderRadius.circular(screenWidth * 0.03),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.sell_outlined, color: kPrimaryColor, size: 25.0,),
                              SizedBox(width: screenWidth * 0.02),
                              Text("Per day", style: TextStyle(fontSize: screenHeight * 0.04, )),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02,),
    //##########################################   Price  ######################################################################################                      
                          Text("\$ 200", style: TextStyle(fontSize: screenHeight * 0.04, fontWeight: FontWeight.bold),),
                          const Divider(thickness: 1.0),
                          SizedBox(height: screenHeight * 0.02,),
                          Text("From", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                          SizedBox(height: screenHeight * 0.01,),
                          Container(
                            height: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4F9FB),
                              borderRadius: BorderRadius.circular(screenHeight * 0.02),
                            ),
                            child: Container(
                              margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
    //##########################################   From date  ######################################################################################                           
                              child: TextFormField(
                                controller: dateController,
                                //focusNode: _dateFocus,
                                decoration: InputDecoration(
                                  hintText: 'Select Date',
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range,color: kPrimaryColor,),
                                    onPressed: () => _selectDate(context),
                                  ),
                                ),
                              )
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02,),
                          Text("To", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                          SizedBox(height: screenHeight * 0.01,),
                          Container(
                            height: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4F9FB),
                              borderRadius: BorderRadius.circular(screenHeight * 0.02),
                            ),
                            child: Container(
                              margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
                              child: 
//##########################################   To date  ######################################################################################                           
                              TextFormField(
                                controller: dateController,
                                //focusNode: _dateFocus,
                                decoration: InputDecoration(
                                  hintText: 'Select Date',
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range,color: kPrimaryColor,),
                                    onPressed: () => _selectDate(context),
                                  ),
                                ),
                              )
                            ),
                          ),
                  
                          SizedBox(height: screenHeight * 0.02,),
                          Text("Driving Option", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                          SizedBox(height: screenHeight * 0.01,),
                          Container(
                            height: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4F9FB),
                              borderRadius: BorderRadius.circular(screenHeight * 0.02),
                            ),
  //##########################################  Driving option ######################################################################################                                                     
                            child: Container(
                              margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
                              child: DropdownButton(
                                value: drivingOption,
                                icon: const Icon(Icons.keyboard_arrow_down), 
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                              onChanged: (String? newValue) { 
                                setState(() {
                                  drivingOption = newValue!;
                                });
                              }
                              ),
                              
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.06,),
                          DefaultButton(text: "Book Now", press: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const ()));
                          })
                        ],
                      ),
                    ),
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