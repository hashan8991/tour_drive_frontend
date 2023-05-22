// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

// ignore: must_be_immutable
class TourCheckAvailabilityScreen extends StatefulWidget {

  final String tourname;
  final String tourdes;
  final String tourStartDate ;
  final String tourEndDate;
  final int price;

  const TourCheckAvailabilityScreen({super.key, required this.tourname, required this.tourdes, required this.tourStartDate, required this.tourEndDate, required this.price});

  @override
  State<TourCheckAvailabilityScreen> createState() => _TourCheckAvailabilityScreenState();
}

class _TourCheckAvailabilityScreenState extends State<TourCheckAvailabilityScreen> {
// #######################################################################################################
  late Map<String, dynamic> paymentIntent;
  final needSeats = TextEditingController();
  late int seats;
  late int totalAmount ;
  final formKey = GlobalKey<FormState>();

  // ########################## booking request #################################################################

    Future<void> tourBooking() async {

    final prefs = await SharedPreferences.getInstance();
    final cookie = await prefs.getString('Cookie');
    final userid = await prefs.getString('userId');
    final tourid = await prefs.getString('tourId');
  
    final response = await http
        .post(Uri.parse('$URL/api/v1/booking/create-checkout-session'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie == null) ? "" : cookie,
        },
        body: jsonEncode(<String, String>{  // what we need to send to the server
          "user": (userid == null) ? "" : userid,
          "tourID": (tourid == null) ? "" : tourid,
          "bookingType": "tour",
          "tourName": widget.tourname,
          "tourDesc": widget.tourdes,
          "noOfSeats": "$seats",
          "price": "$totalAmount",
          "from": "${widget.tourStartDate}",
          "to": "${widget.tourEndDate}"
          
        }),
    );

    if (response.statusCode == 201) {
      print("payment success");

    } else {

      final Map<String, dynamic> responseData =  jsonDecode(response.body);
        String message =  responseData["message"];
        throw Exception('Failed to TourBooking ');
    }

  }


  // ############################ payment request ##################################################################

  Future<void> makePayment(String totalAmount) async {
    try{
      paymentIntent = await createPaymentIntent(totalAmount,'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'TourDrive')).then((value){
        });

        displayPaymentSheet();
    }
    catch(e){
      print(e);
    }
  }

  displayPaymentSheet() async {
    try{
      
      await Stripe.instance.presentPaymentSheet(
      ).then((value) {
        showDialog(
          context: context, 
          builder: (_) =>  AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Icon(Icons.check_circle,color: kPrimaryColor,),
                    Text("payment Successfully"),
                  ],
                ),
              ],
            ),
          )

        );
// ############### send backed to tour booking detail #######################################
        tourBooking();

      }).onError((error, stackTrace) {
          print("error=>>>$error $stackTrace");
      } );

    } on StripeException catch(e) {
      print(e);

      showDialog(
        context: context, 
        builder: (_) => const AlertDialog(
          content: Text("Cancelled"),
        ));
    }catch(e){
      print(e);
    }
    
  }

  createPaymentIntent(String amount,String currency) async {
    try{
      Map<String,dynamic> body = {
        'amount' : calculateAmount(amount),
        'currency' : currency,
        'payment_method_types[]' : 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization' : 'Bearer sk_test_51N1atlGJCiP6SiMGoa1ZNe0WC5awUqfk1f26dCHZH1JuRWVvqa6kGH6OWt0opjypCirKxq1ui0u8LUthSCEiiEWe00gXpZ4cpc',
          'Contert-Type' : 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      //print('payment Intent body->>>${response.body.toString()}');
      return jsonDecode(response.body);
    }
    catch(e){
      print(e);
    }
  }

   calculateAmount(String amount) {
    final calculateAmount = (int.parse(amount))*100 ;
    return calculateAmount.toString();
  }

// ###################################################################################################
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
                Navigator.pop(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
              }),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: screenWidth * 0.9 ,
                    height: screenHeight * 0.88,
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.sell_outlined, color: kPrimaryColor, size: 25.0,),
                                SizedBox(width: screenWidth * 0.02),
                                Text("From", style: TextStyle(fontSize: screenHeight * 0.03, )),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("\$ ${widget.price}", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),),
                            const Divider(thickness: 1.0),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("Check In", style: TextStyle(fontSize: screenHeight * 0.02,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                            SizedBox(height: screenHeight * 0.01,),
                            Container(
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4F9FB),
                                borderRadius: BorderRadius.circular(screenHeight * 0.02),
                              ),
                              child: Container(
                                margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
                                child: 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.tourStartDate.split('T')[0], style: TextStyle( fontSize: screenHeight * 0.025),),
                                    Icon(Icons.date_range, color: kPrimaryColor, size: screenHeight * 0.03,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("Check Out", style: TextStyle(fontSize: screenHeight * 0.02,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                            SizedBox(height: screenHeight * 0.01,),
                            Container(
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4F9FB),
                                borderRadius: BorderRadius.circular(screenHeight * 0.02),
                              ),
                              child: Container(
                                margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
                                child: 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.tourEndDate.split('T')[0], style: TextStyle( fontSize: screenHeight * 0.025),),
                                    Icon(Icons.date_range, color: kPrimaryColor, size: screenHeight * 0.03,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("Already booked", style: TextStyle(fontSize: screenHeight * 0.02,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                            SizedBox(height: screenHeight * 0.01,),
                            Container(
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4F9FB),
                                borderRadius: BorderRadius.circular(screenHeight * 0.02),
                              ),
                              child: Container(
                                margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
                                child: 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("05", style: TextStyle( fontSize: screenHeight * 0.025),),
                                    Icon(Icons.book_outlined, color: kPrimaryColor, size: screenHeight * 0.03,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("Available Seats", style: TextStyle(fontSize: screenHeight * 0.02,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                            SizedBox(height: screenHeight * 0.01,),
                            Container(
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4F9FB),
                                borderRadius: BorderRadius.circular(screenHeight * 0.02),
                              ),
                              child: Container(
                                margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
                                child: 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("10", style: TextStyle( fontSize: screenHeight * 0.025),),
                                    Icon(Icons.airline_seat_recline_normal_outlined, color: kPrimaryColor, size: screenHeight * 0.03,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("How many seats do you need?", style: TextStyle(fontSize: screenHeight * 0.02,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                            SizedBox(height: screenHeight * 0.01,),
                            Form(
                              key: formKey,
                              child: TextFormField(
                                controller: needSeats,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '* Please enter How many seats do you need?';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Seats Count",
                                  floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                  contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                                  hintText: 'Enter your Num Of Seats',
                                  suffixIcon: const Icon(Icons.chair_alt_outlined, color: kPrimaryColor,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenHeight * 0.025),
                                    borderSide: const BorderSide(color: kPrimaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(screenHeight * 0.025),
                                    borderSide: const BorderSide(color: kPrimaryColor),
                                  )
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05,),
                            DefaultButton(text: "Book Now", press: () async{
                            
                              if( formKey.currentState!.validate()) { 
                                setState(() {
                                  seats = int.parse(needSeats.text);
                                  totalAmount = seats * widget.price;
                                });
                                String totalamout = totalAmount.toString();
                                makePayment(totalamout);
                              }  
                            })
                          ],
                        ),
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