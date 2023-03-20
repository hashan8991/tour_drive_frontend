import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';

class DriveOptionScreen extends StatefulWidget {
  const DriveOptionScreen({super.key});

  @override
  State<DriveOptionScreen> createState() => _DriveOptionScreenState();
}

class _DriveOptionScreenState extends State<DriveOptionScreen> {
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
            'Booked Vehicle',
            textAlign: TextAlign.center,
            style: TextStyle(color: kTextColor),
          ),
        ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,16),
                      child: Container(
                        
                        height: screenHeight * 0.16,
                        width: screenWidth,
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
                          margin: EdgeInsets.all(screenWidth * 0.025),
                          child: Row(
                            children: [
                              ClipRRect( 
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                child: Image.network('https://images.unsplash.com/photo-1638618164682-12b986ec2a75?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, )),
                              SizedBox(width: screenWidth * 0.03),
                              Container(
                                height: screenHeight * 0.14,
                                width: screenWidth * 0.52,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Toyota Prius", style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: screenHeight * 0.008,),                                    
                                    Text("\$ 200", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),),
                                    SizedBox(height: screenHeight * 0.008,),
                                    Text("Check In    :   31/05/2023", style: TextStyle(fontSize: screenHeight * 0.018)), 
                                    SizedBox(height: screenHeight * 0.008,),
                                    Text("Check Out :   31/05/2023 ", style: TextStyle(fontSize: screenHeight * 0.018)),  
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                      ),
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