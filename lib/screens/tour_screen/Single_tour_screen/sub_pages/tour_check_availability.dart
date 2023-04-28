import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class TourCheckAvailabilityScreen extends StatefulWidget {
  const TourCheckAvailabilityScreen({super.key});

  @override
  State<TourCheckAvailabilityScreen> createState() => _TourCheckAvailabilityScreenState();
}

class _TourCheckAvailabilityScreenState extends State<TourCheckAvailabilityScreen> {
// #######################################################################################################
  late Map<String, dynamic> paymentIntent;

  Future<void> makePayment() async {
    try{
      paymentIntent = await createPaymentIntent('20','USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          // applePay: const PaymentSheetApplePay(merchantCountryCode: '+94'),
          // googlePay: const PaymentSheetGooglePay(testEnv: true,currencyCode: 'USD',merchantCountryCode: '+94'),
          style: ThemeMode.dark,
          merchantDisplayName: 'manoj')).then((value){
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
                  children: [
                    Icon(Icons.check_circle,color: Colors.green,),
                    Text("payment Successfully"),
                  ],
                ),
              ],
            ),
          )

        );
      }).onError((error, stackTrace) {
          print("error=>>>$error $stackTrace");
      } );
    } on StripeException catch(e) {
      print(e);

      showDialog(
        context: context, 
        builder: (_) => const AlertDialog(
          content: Text("concelled"),
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
      print('payment Intent body->>>${response.body.toString()}');
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
              }),
              SizedBox(height: screenHeight * 0.04,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: screenWidth * 0.9 ,
                    height: screenHeight * 0.8,
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
                                Text("From", style: TextStyle(fontSize: screenHeight * 0.04, )),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("\$ 200", style: TextStyle(fontSize: screenHeight * 0.04, fontWeight: FontWeight.bold),),
                            const Divider(thickness: 1.0),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("Check In", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("03/02/2014", style: TextStyle( fontSize: screenHeight * 0.03),),
                                    Icon(Icons.date_range, color: kPrimaryColor, size: screenHeight * 0.04,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02,),
                            Text("Check Out", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("03/02/2014", style: TextStyle( fontSize: screenHeight * 0.03),),
                                    Icon(Icons.date_range, color: kPrimaryColor, size: screenHeight * 0.04,),
                                  ],
                                ),
                              ),
                            ),
                                        
                            SizedBox(height: screenHeight * 0.02,),
                            Text("Available Seats", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("10", style: TextStyle( fontSize: screenHeight * 0.03),),
                                    Icon(Icons.airline_seat_recline_normal_outlined, color: kPrimaryColor, size: screenHeight * 0.04,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.06,),
                            DefaultButton(text: "Book Now", press: () async{
                              await makePayment();
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