import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/models/tour/tour_data.dart';

class TourHomeScreen extends StatefulWidget {
  
  const TourHomeScreen({super.key,  });

  @override
  State<TourHomeScreen> createState() => _TourHomeScreenState();
}

class _TourHomeScreenState extends State<TourHomeScreen> {
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
      return Text(stars);
    }

     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.arrow_back, color:Colors.black, )),
          elevation: 0,
          // title: Image.asset("assets/images/logoNew.png"),
          // centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black,),
              onPressed: () {
 
              },
            ),
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black, ),
              onPressed: () {

              },
            ),
          ],
        ),
        

        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.05),
          child: ListView.builder(
           
            scrollDirection: Axis.vertical,
            itemCount: tours.length,
            itemBuilder: (BuildContext context, int index) {
            
            return Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,8),
              child: Container(
                
                height: screenHeight * 0.22,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(115, 155, 239, 254),
                  borderRadius:
                      BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Container(
                  margin: EdgeInsets.all(screenWidth * 0.025),
                  child: Row(
                    children: [
                      ClipRRect( 
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        child: Image.asset('assets/images/sigiriya.jpeg', fit: BoxFit.fill, height: screenHeight * 0.3,width: screenWidth * 0.38, )),
                      SizedBox(width: screenWidth * 0.03),
                      Container(
                        height: screenHeight * 0.3,
                        width: screenWidth * 0.44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: Column(
                          //margin: EdgeInsets.all(screenWidth * 0.05),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( tours[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03), maxLines: 2, overflow: TextOverflow.ellipsis,),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, color: kPrimaryColor,),
                                SizedBox(width: screenWidth * 0.37, child: Text(tours[0].locations, style: TextStyle(fontSize: screenHeight * 0.02), maxLines:1, overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005,),
                            buildRatingStars(tours[index].ratingsAverage),
                            SizedBox(height: screenHeight * 0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.people_outline_sharp, color: kPrimaryColor, size: screenHeight * 0.025,),
                                    SizedBox(width: screenWidth *0.01,),
                                    Text("${tours[index].maxSeats}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.timer_outlined, color: kPrimaryColor, size: screenHeight * 0.025,),
                                    SizedBox(width: screenWidth *0.01,),
                                    Text("${tours[index].duration} days"),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.001,),
                            Center(child: Text("\$ ${tours[index].price.toStringAsFixed(0)}", style: TextStyle(fontSize: screenHeight * 0.025,fontWeight: FontWeight.bold),))
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
      ),
    );
  }
}