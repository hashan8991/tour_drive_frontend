// ignore_for_file: unnecessary_string_interpolations



import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VehicleCheckAvailability extends StatefulWidget {

  final String vehicleName;
  late num priceWithDriver;
  late num priceWithoutDriver;
  VehicleCheckAvailability({super.key, required this.vehicleName, required this.priceWithDriver, required this.priceWithoutDriver});

  @override
  State<VehicleCheckAvailability> createState() => _VehicleCheckAvailabilityState();
}

class _VehicleCheckAvailabilityState extends State<VehicleCheckAvailability> {

  TextEditingController dateController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  late Map<String, dynamic> paymentIntent;
  final formKey = GlobalKey<FormState>();
  // late final double price;
  late var price = widget.priceWithDriver;

  String drivingOption = "With driver";
  var items = [
    "With driver",
    "Without driver"
  ];

  void _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kPrimaryColor, // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.black, // body text color
              )
            ),
            child: child!,
          );
        },
    );

    if (picked != null) {
        fromDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
    
  }

  void _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kPrimaryColor, // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.black, // body text color
              )
            ),
            child: child!,
          );
        },
    );

    if (picked != null) {
        toDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
    
  }

  Future<void> vehicleBooking() async {

    final prefs = await SharedPreferences.getInstance();
    final cookie = await prefs.getString('Cookie');
    final userid = await prefs.getString('userId');
    final vehicleId = await prefs.getString('vehicleId');
  
    final response = await http
        .post(Uri.parse('$URL/api/v1/booking/create-checkout-session'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie == null) ? "" : cookie,
        },
        body: jsonEncode(<String, String>{  // what we need to send to the server
          "user": (userid == null) ? "" : userid,
          "vehicle": (vehicleId == null) ? "" : vehicleId,
          "bookingType": "vehicle",
          "vehicleName": widget.vehicleName,
          "noOfSeats": "0",
          "price": "$price",
          "from": "${fromDateController.text}",
          "to": "${toDateController.text}"
          
        }),
    );

    if (response.statusCode == 201) {
      print("payment success");

    } else {

      final Map<String, dynamic> responseData =  jsonDecode(response.body);
        String message =  responseData["message"];
        print(message);
        throw Exception('Failed to vehicleBooking ');
    }

  }

  Future<void> makePayment(String totalAmount) async {
    try{
      paymentIntent = await createPaymentIntent(totalAmount,'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          // applePay: const PaymentSheetApplePay(merchantCountryCode: '+94'),
          // googlePay: const PaymentSheetGooglePay(testEnv: true,currencyCode: 'USD',merchantCountryCode: '+94'),
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
        vehicleBooking();
      }).onError((error, stackTrace) {
          print("error=>>>$error $stackTrace");
      } );
    } on StripeException catch(e) {
      print(e);

      showDialog(
        context: context, 
        builder: (_) => const AlertDialog(
          content: Text("cancelled"),
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
                Navigator.pop(context, MaterialPageRoute(builder: (context) => const SingleVehicleScreen()));
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
                          Text("\$ $price", style: TextStyle(fontSize: screenHeight * 0.04, fontWeight: FontWeight.bold),),
                          const Divider(thickness: 1.0),
                          SizedBox(height: screenHeight * 0.02,),
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("From", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                                SizedBox(height: screenHeight * 0.01,),
                                TextFormField(
                                  controller: fromDateController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '* Please enter from date?';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "From Date",
                                    floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                    contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.date_range,color: kPrimaryColor,),
                                       onPressed: () => _selectDate1(context),
                                    ),
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
                                SizedBox(height: screenHeight * 0.02,),
                                Text("To", style: TextStyle(fontSize: screenHeight * 0.025,letterSpacing: screenWidth * 0.003, fontWeight: FontWeight.bold),),
                                SizedBox(height: screenHeight * 0.01,),
                                TextFormField(
                                  controller: toDateController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '* Please enter to date?';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "To Date",
                                    floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                    contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                                    hintText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.date_range,color: kPrimaryColor,),
                                       onPressed: () => _selectDate2(context),
                                    ),
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
                                        if(drivingOption == "With driver"){
                                         
                                            price = widget.priceWithDriver;
                                          
                                        }else{
                                            
                                            price = widget.priceWithoutDriver;
                                          
                                        }
                                      });
                                    }
                                    ),
                                    
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.06,),
                              ],
                            ),
                          ),
                          
                          DefaultButton(text: "Rent Now", press: () async{
                         
                            if( formKey.currentState!.validate()) { 
                                if(drivingOption == "With driver"){
                                  setState(() {
                                    price = widget.priceWithDriver;
                                  });
                                }else{
                                    setState(() {
                                    price = widget.priceWithoutDriver;
                                  });
                                }

                                String totalamout = price.toString().split('.')[0];
                                makePayment(totalamout);
                                
                              }
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