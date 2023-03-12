import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';

class VehicleHomeScreen extends StatefulWidget {
  const VehicleHomeScreen({super.key});

  @override
  State<VehicleHomeScreen> createState() => _VehicleHomeScreenState();
}

class _VehicleHomeScreenState extends State<VehicleHomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Text buildRatingStars(double rating) {

      String stars = '';
      for (double i = 0; i < rating; i++) {
        stars += '⭐ ';
      }
      stars.trim();
      return Text(stars, style: TextStyle(fontSize: screenHeight * 0.015),);
    }

     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const NavbarMainPage()));}, 
            icon: const Icon(Icons.arrow_back, color:Colors.black, )),
          elevation: 0,
          title: Image.asset("assets/images/logoPic.png"),
          centerTitle: true,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.all(3),
              child: IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.search, color: Colors.black,),
                onPressed: () {
 
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black, ),
              onPressed: () {

              },
            ),
          ],
        ),
        

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Choose Your best vehicle here", style: TextStyle(fontSize: screenHeight * 0.032, fontWeight: FontWeight.bold),),
              SizedBox(height: screenHeight * 0.02,),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                  
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
                                  Row(
                                    children: [
                                      const Icon(Icons.construction_outlined, color: kPrimaryColor, size: 12.0,),
                                      SizedBox(width: screenWidth * 0.4, child: Text(" Brandnew condition", style: TextStyle(fontSize: screenHeight * 0.018), maxLines:1, overflow: TextOverflow.ellipsis,)),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.008,),
                                  Row(children: [buildRatingStars(3), SizedBox(width: screenWidth * 0.02,),Text("2 reviews", style: TextStyle(fontSize: screenHeight *0.015),)]),
                                  SizedBox(height: screenHeight * 0.007,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.airline_seat_recline_normal_sharp, color: kPrimaryColor, size: screenHeight * 0.02,),
                                          SizedBox(width: screenWidth *0.005,),
                                          Text("4 seats"),
                                        ],
                                      ),
                                      Text("\$ 200", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
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
      ),
    );
  }
}

