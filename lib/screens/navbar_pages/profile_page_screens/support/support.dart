// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/list_tiles1.dart';
import 'package:tour_drive_frontend/widgets/list_tiles2.dart';
import 'package:tour_drive_frontend/widgets/list_tiles3.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../widgets/list_tile_phone_call.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_ios), //replace with our own icon data.
          ),
          iconTheme: const IconThemeData(color: kPrimaryColor),
          title: const Text(
            "Support",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.09),
                  child: Image.asset('assets/images/logoPic.png'),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      color: Colors.white,
                      border: Border.all(color: kSecondaryColor),
                      boxShadow: const [
                        BoxShadow(
                          color: kSecondaryColor,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(3, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        MyListTile(
                          iconLeading: Icons.contact_support_outlined,
                          title: 'Customer Support',
                          iconTail: Icons.navigate_next,
                          press: () {
                            showDialog(
                              barrierColor:
                                  const Color.fromARGB(100, 80, 132, 11),
                              context: context,
                              builder: (context) => AlertDialog(
                                icon: const Icon(
                                  Icons.contact_support_outlined,
                                  color: kPrimaryColor,
                                ),
                                title: const Text(
                                  'Customer Support',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                content: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.02),
                                    color: Colors.white,
                                    border: Border.all(color: kSecondaryColor),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        
                                        const MyListTile2(
                                            iconLeading: Icons.email_outlined,
                                            title: 'tourdrive@gmail.com'),
                                        ListTile(
                                          leading: const Icon(Icons.link),
                                          title: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'www.tourdrive.com',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () async {
                                                          const url =
                                                              'https://www.google.com';
                                                          if (await canLaunch(
                                                              url)) {
                                                            await launch(url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const PhoneCallListTile(
                              iconLeading: Icons.phone_android_outlined,
                              title:
                                  '011 123 4567', // add this phone number to the definition of this list_tile
                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryColor),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Ok'),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        MyListTile(
                          iconLeading: Icons.policy_outlined,
                          title: 'Privacy & Policy',
                          iconTail: Icons.navigate_next,
                          press: () {
                            showDialog(
                              barrierColor:
                                  const Color.fromARGB(100, 80, 132, 11),
                              context: context,
                              builder: (context) => AlertDialog(
                                icon: const Icon(
                                  Icons.policy_outlined,
                                  color: kPrimaryColor,
                                ),
                                title: const Text(
                                  'Privacy & Policy',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(screenWidth * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.02),
                                      color: Colors.white,
                                      border:
                                          Border.all(color: kSecondaryColor),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'At TourDrive, we take the privacy and security of our users very seriously. This Privacy Policy outlines the types of information we collect from our users and how we use, store, and protect that information.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),
                                        const Text(
                                          "Information we collect \n \nWhen you use TourDrive, we may collect the following types of information:\n\n 1.Personal Information: We may collect your name, email address, phone number, and other contact information when you create an account or sign up for our newsletter.\n\n 2.Location Information: We may collect your device's location when you use our app to help you find nearby attractions, restaurants, and hotels.\n\n 3.Usage Information: We may collect information about how you use our app, such as which features you use and how often you use them.\n\n",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),
                                        const Text(
                                          'How We Use Your Information:\n\n We use the information we collect to:\n\n 1.Provide you with personalized recommendations for attractions, restaurants, and hotels based on your location and preferences.\n\n 2.Improve our app and services by analyzing usage patterns and user feedback.\n\n 3.Communicate with you about new features, promotions, and other news related to TourDrive.\n\n 4.Respond to your inquiries and provide customer support.\n\n',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),
                                        const Text(
                                          'How We Protect Your Information:\n\n We take appropriate measures to protect your personal information from unauthorized access, disclosure, or misuse. We use industry-standard encryption and security protocols to safeguard your data and ensure its confidentiality.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),
                                        const Text(
                                          'Disclosure of Your Information:\n\nWe may disclose your personal information to third-party service providers who perform services on our behalf, such as hosting our app or sending promotional emails. We may also disclose your information if required by law or to protect our rights or the rights of others.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),
                                        const Text(
                                          'Changes to this Privacy and Policy Statement:\n\nWe may update this Privacy and Policy Statement from time to time. If we make significant changes, we will notify you by email or by posting a notice on our app.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),
                                        const Text(
                                          'Contact Us:\n\n If you have any questions or concerns about our Privacy and Policy Statement, please contact us at support@tourdrive.com.\n\nThank you for using TourDrive, and we hope you enjoy your travels!',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Ok'),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        MyListTile(
                          iconLeading: Icons.contacts_outlined,
                          title: 'Contact Channels',
                          iconTail: Icons.navigate_next,
                          press: () {
                            showDialog(
                              barrierColor:
                                  const Color.fromARGB(100, 80, 132, 11),
                              context: context,
                              builder: (context) => AlertDialog(
                                icon: const Icon(
                                  Icons.contacts_outlined,
                                  color: kPrimaryColor,
                                ),
                                title: const Text(
                                  'Contact Channels',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                content: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.02),
                                    color: Colors.white,
                                    border: Border.all(color: kSecondaryColor),
                                  ),
                                  // child: const Text(
                                  //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                  //   style: TextStyle(color: kTextColor),
                                  // ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        MyListTile1(
                                          title: 'Facebook',
                                          iconTail:
                                              Icons.arrow_forward_outlined,
                                          press: () async {
                                            const url =
                                                'https://www.facebook.com';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                        ),
                                        const Divider(),
                                        MyListTile1(
                                          title: 'Twitter',
                                          iconTail:
                                              Icons.arrow_forward_outlined,
                                          press: () async {
                                            const url =
                                                'https://www.twitter.com';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                        ),
                                        const Divider(),
                                        MyListTile1(
                                          title: 'Instagram',
                                          iconTail:
                                              Icons.arrow_forward_outlined,
                                          press: () async {
                                            const url =
                                                'https://www.instagram.com';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                        ),
                                        const Divider(),
                                        MyListTile1(
                                          title: 'Pinterest',
                                          iconTail:
                                              Icons.arrow_forward_outlined,
                                          press: () async {
                                            const url =
                                                'https://www.pinterest.com';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: kPrimaryColor),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Ok'),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
