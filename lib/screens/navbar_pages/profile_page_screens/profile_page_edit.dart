import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_details_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final countryController = TextEditingController();
  final passportIdController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? name,email,country,passportID;
  int? mobileNum;
  bool isloading = true;
  bool isloading1 = false;
  bool isloading2 = false;
  bool isError1 = false;
  String errorMessage1 = "";
  bool isError2 = false;
  String errorMessage2 = "";
  
  void setDetails() async{
    
    final prefl = await SharedPreferences.getInstance();
    name = await prefl.getString('name');
    email = await prefl.getString('email');
    mobileNum = await prefl.getInt('mobile');
    country = await prefl.getString('country');
    passportID = await prefl.getString('passportID');

    setState(() {
      nameController.text = name.toString();
      mobileController.text = mobileNum.toString();
      countryController.text = country.toString();
      passportIdController.text = passportID.toString();
      isloading = false;

    });
    
  }

  @override
  void initState() {
    super.initState();
    setDetails();
  }
  // ########################## Profile updataed ################################

  Future updateProfile() async {

    setState(() {
      isloading1 = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final cookie = await prefs.getString('Cookie');
    final response = await http
        .patch(Uri.parse('$URL/api/v1/auth/update-me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie == null) ? "" : cookie,
        },
        body: jsonEncode(<String, String>{  // what we need to send to the server
          "name": nameController.text,
          "country": countryController.text,
          "passportID": passportIdController.text,
          "mobile": mobileController.text,
          
        }),
    );

    setState(() {
      isloading1 = false;
    });

  return response;

}
  
  // ########################## Password updataed ################################
  Future updatePassword() async {

    setState(() {
      isloading2 = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final cookie = await prefs.getString('Cookie');

    final response = await http
        .patch(Uri.parse('$URL/api/v1/auth/update-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie == null) ? "" : cookie,
        },
        body: jsonEncode(<String, String>{  // what we need to send to the server
          "passwordCurrent": currentPasswordController.text,
          "password": newPasswordController.text,
          "passwordConfirm": confirmPasswordController.text
        }),
    );

    setState(() {
      isloading2 = false;
    });

  return response;

}

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_ios), //replace with our own icon data.
          ),
          title: const Center(
            child: Text(
              'Edit My Account',
              // textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      kPrimaryColor), //add the given colors of the built tour drive app
            ),
          ),
          actions: [
            SizedBox(
              height: screenHeight * 0.01,
              child: TextButton(
                onPressed: () {},
                // child: const Text(
                //   'Save',
                //   style: TextStyle(color: kTextColor),
                // )
                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                  semanticLabel:
                      'Save ', // this icon is for saving the edited data, you can save data from the provided save button at the bottom of the form
                ),
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   height: screenHeight * 0.12,
                  //   width: screenWidth * 0.3,
                  //   color: const Color.fromARGB(0, 0, 97, 3),
                  //   child: Stack(
                  //     alignment: Alignment.bottomRight,
                  //     children: [
                  //       CircleAvatar(
                  //         radius: screenWidth * 0.1,
                  //         backgroundColor: kTextColor,
                  //         //please enter the relavent image from web
                  //         backgroundImage:
                  //             const AssetImage('assets/images/avatar2.png'),
                  //       ),
                  //       GestureDetector(
                  //         child: const Icon(
                  //           Icons.camera_alt_rounded,
                  //           color: kPrimaryColor,
                  //         ),
                  //         onTap:
                  //             () {}, //the functionality for profile image changing goes here
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: screenHeight * 0.01),
                  isloading 
                  ? Center(
                      child:CircularProgressIndicator(
                        backgroundColor: Colors.grey[200], // Set the background color of the widget
                        valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                        strokeWidth: 3, // Set the width of the progress indicator
                      )
                    )
                  :
                  isloading1 
                  ? Center(
                      child:CircularProgressIndicator(
                        backgroundColor: Colors.grey[200], // Set the background color of the widget
                        valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                        strokeWidth: 3, // Set the width of the progress indicator
                      )
                    )
                  :
                  
                  Visibility(
                        visible: isError1,
                        child: Text("🛑 $errorMessage1 " , style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Form(
                    key: formKey1,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '* Please enter your name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Name",
                              floatingLabelStyle:
                                  const TextStyle(color: kPrimaryColor),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.028),
                              hintText: 'Enter your name',
                              suffixIcon: const Icon(
                                Icons.man,
                                color: kPrimaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.03),
                                borderSide: const BorderSide(color: kPrimaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.03),
                                borderSide: const BorderSide(color: kPrimaryColor),
                              )),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: mobileController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Please enter your mobile number';
                        }if (value.length != 10 && value.length != 9) {
                          return '* Please enter valid mobile number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Moblie number",
                          floatingLabelStyle:
                              const TextStyle(color: kPrimaryColor),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.028),
                          hintText: 'Enter your mobile number',
                          suffixIcon: const Icon(
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          )),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: countryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Please enter your country';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Country",
                          floatingLabelStyle:
                              const TextStyle(color: kPrimaryColor),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.028),
                          hintText: 'Enter your email',
                          suffixIcon: const Icon(
                            Icons.location_on_sharp,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          )),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: passportIdController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Please enter your NIC or passport Id';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: "NIC or Passport Id",
                          floatingLabelStyle:
                              const TextStyle(color: kPrimaryColor),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.028),
                          hintText: 'Enter your Id',
                          suffixIcon: const Icon(
                            Icons.insert_drive_file_outlined,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          )),
                    ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.02),
                  DefaultButton(text: 'Update Profile', press: () async{

                    var response1;

                    if(formKey1.currentState!.validate()){
                      response1 = await updateProfile();
                    }
                    
                    if( formKey1.currentState!.validate() && response1.statusCode == 201 ) {  

                      final Map<String, dynamic> responseData = json.decode(response1.body); 

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('name', responseData["data"]["updatedUser"]["name"]);
                      await prefs.setInt('mobile', responseData["data"]["updatedUser"]["mobile"]);
                      await prefs.setString('country', responseData["data"]["updatedUser"]["country"]);
                      await prefs.setString('passportID', responseData["data"]["updatedUser"]["passportID"]);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile Updated Successfully'), 
                          backgroundColor: kPrimaryColor,
                          ),
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileDetails()));
                    }else{
                      final Map<String, dynamic> responseData = json.decode(response1.body);
                      errorMessage1 = responseData["message"];
                      setState(() {
                        isError1 = true;
                      });
                    }
                  }),

     // ##############################################################################################################################################             
                  const Divider(color: Colors.black,),
                  isloading2 
                  ? Center(
                      child:CircularProgressIndicator(
                        backgroundColor: Colors.grey[200], // Set the background color of the widget
                        valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                        strokeWidth: 3, // Set the width of the progress indicator
                      )
                    )
                  :
                  Visibility(
                        visible: isError2,
                        child: Text("🛑 $errorMessage2 " , style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Form(
                    key: formKey2,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: currentPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '* Please enter your Password';
                            }
                            if (value.length < 8) {
                              return '* Please enter more than 8 characters';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Current Password",
                              floatingLabelStyle:
                                  const TextStyle(color: kPrimaryColor),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.028),
                              hintText: 'Enter your current password',
                              suffixIcon: const Icon(
                                Icons.lock,
                                color: kPrimaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.03),
                                borderSide: const BorderSide(color: kPrimaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.03),
                                borderSide: const BorderSide(color: kPrimaryColor),
                              )),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: newPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Please enter your new password';
                        }
                        if (value.length < 8) {
                          return '* Please enter more than 8 characters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "New Password",
                          floatingLabelStyle:
                              const TextStyle(color: kPrimaryColor),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.028),
                          hintText: 'Enter your new password',
                          suffixIcon: const Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          )),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Please enter your Password';
                        }
                        if (value.length < 8) {
                          return '* Please enter more than 8 charactersl';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Confirm Password",
                          floatingLabelStyle:
                              const TextStyle(color: kPrimaryColor),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.028),
                          hintText: 'Re-enter your confirm password',
                          suffixIcon: const Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          )),
                    ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.02),
                  DefaultButton(text: 'Update Password', press: () async{
                    
                    var response2;

                    if(formKey2.currentState!.validate()){
                      response2 = await updatePassword();
                    }
                    
                    if( formKey1.currentState!.validate() && response2.statusCode == 201 ) {  

                      final cookies =  await response2.headers["set-cookie"];
                      final pre = await SharedPreferences.getInstance();
                      await pre.setString('Cookie', cookies);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile Updated Successfully'), 
                          backgroundColor: kPrimaryColor,
                          ),
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileDetails()));
                    }else{
                      final Map<String, dynamic> responseData = json.decode(response2.body);
                      errorMessage1 = responseData["message"];
                      setState(() {
                        isError2 = true;
                      });
                    }
                  }),
                  const Divider(color: Colors.black,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
