import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/about_us/about_us_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/contact_us/contact_us.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_details_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/support/support.dart';

import '../../../constants.dart';
import '../../../provider/sign_in_provider.dart';
import '../../../util/next_screen.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/list_tiles1.dart';
import '../../authentication/sign_in/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final sp = context.watch<SignInProvider>();
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          // shadowColor: const Color.fromARGB(0, 37, 97, 107),
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(
          //       Icons.arrow_back_ios), //replace with our own icon data.
          // ),
          title: const Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Container(
                      height: screenHeight * 0.12,
                      width: screenWidth * 0.3,
                      color: const Color.fromARGB(0, 0, 97, 3),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.1,
                            backgroundColor: kTextColor,
                            backgroundImage: NetworkImage(user.photoURL!),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      user.displayName!,
                      style: const TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: kTextColor),
                    )
                  ],
                ),
                const Divider(),
                Column(
                  children: [
                    MyListTile(
                        iconLeading: Icons.perm_identity_rounded,
                        title: 'My Account',
                        iconTail: Icons.navigate_next,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileDetails(),
                            ),
                          );
                        }),
                    const Divider(),
                    MyListTile(
                        iconLeading: Icons.support_agent_rounded,
                        title: 'Support',
                        iconTail: Icons.navigate_next,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Support(),
                            ),
                          );
                        }),
                    const Divider(),
                    MyListTile(
                        iconLeading: Icons.phone_in_talk_outlined,
                        title: 'Contact Us',
                        iconTail: Icons.navigate_next,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContactUs(),
                            ),
                          );
                        }),
                    const Divider(),
                    MyListTile(
                        iconLeading: Icons.info_outline_rounded,
                        title: 'About Us',
                        iconTail: Icons.navigate_next,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutUs(),
                            ),
                          );
                        }),
                    const Divider(),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.15,
                ),
                SizedBox(
                  width: screenWidth * 0.9,
                  child: DefaultButton(
                    text: 'Sign Out',
                    press: () {
                      sp.userSignOut();
                      nextScreenReplace(context, const LogInScreen());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
