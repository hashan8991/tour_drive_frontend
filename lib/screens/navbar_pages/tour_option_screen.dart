import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';

class TourOptionScreen extends StatefulWidget {
  const TourOptionScreen({super.key});

  @override
  State<TourOptionScreen> createState() => _TourOptionScreenState();
}

class _TourOptionScreenState extends State<TourOptionScreen> {

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
            'Booked Tours',
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
                                child: Image.asset('assets/images/sigiriya.jpeg', fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, )),
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
                                    Text("Wonder of Sigiriya", style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02), maxLines: 2, overflow: TextOverflow.ellipsis,),
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