import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final country = ['Sri Lanka', 'Other'];
    String? selectedVal;
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
                  color: kPrimaryColor,
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
                  Container(
                    height: screenHeight * 0.12,
                    width: screenWidth * 0.3,
                    color: const Color.fromARGB(0, 0, 97, 3),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.1,
                          backgroundColor: kTextColor,
                          //please enter the relavent image from web
                          backgroundImage:
                              const AssetImage('assets/images/avatar2.png'),
                        ),
                        GestureDetector(
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: kPrimaryColor,
                          ),
                          onTap:
                              () {}, //the functionality for profile image changing goes here
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    // controller: firstNameController,
                    onSaved: (value) {
                      // fName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your first name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "First Name",
                        floatingLabelStyle:
                            const TextStyle(color: kPrimaryColor),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.028),
                        hintText: 'Enter your first name',
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
                    // controller: lastNameController,
                    onSaved: (value) {
                      // fName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your last name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Last Name",
                        floatingLabelStyle:
                            const TextStyle(color: kPrimaryColor),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.028),
                        hintText: 'Enter your last name',
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
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text('Button'),
                  // ),
                  TextFormField(
                    // controller: emailController,
                    onSaved: (name) {
                      // email = name!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return '* Please enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        floatingLabelStyle:
                            const TextStyle(color: kPrimaryColor),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.028),
                        hintText: 'Enter your email',
                        suffixIcon: const Icon(
                          Icons.email,
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
                    // controller: lastNameController,
                    onSaved: (value) {
                      // fName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your last name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Address",
                        floatingLabelStyle:
                            const TextStyle(color: kPrimaryColor),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.028),
                        hintText: 'Enter your address',
                        suffixIcon: const Icon(
                          Icons.home_rounded,
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
                    // controller: lastNameController,
                    onSaved: (value) {
                      // fName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your last name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Contact Number",
                        floatingLabelStyle:
                            const TextStyle(color: kPrimaryColor),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.028),
                        hintText: 'Enter your contact number',
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
                    // controller: passwordController,
                    onSaved: (value) {
                      // password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your Password';
                      }
                      if (value.length < 3) {
                        return '* Please enter valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        floatingLabelStyle:
                            const TextStyle(color: kPrimaryColor),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.028),
                        hintText: 'Enter your password',
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
                    // controller: passwordController,
                    onSaved: (value) {
                      // password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your Password';
                      }
                      if (value.length < 3) {
                        return '* Please enter valid email';
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
                    // controller: passwordController,
                    onSaved: (value) {
                      // password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Please enter your Password';
                      }
                      if (value.length < 3) {
                        return '* Please enter valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Retype New Password",
                        floatingLabelStyle:
                            const TextStyle(color: kPrimaryColor),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.028),
                        hintText: 'Re-enter your new password',
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

                  DropdownButtonFormField(
                    value: selectedVal,
                    items: country.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedVal = val as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      hintText: "Where Are you from ?",
                      prefixIcon: const Icon(Icons.location_on),
                      prefixIconColor: kPrimaryColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.03),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.03),
                          borderSide: const BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Divider(),
                  SizedBox(height: screenHeight * 0.02),
                  DefaultButton(text: 'Save ', press: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
