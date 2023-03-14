import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/navbar_pages/profile_page_screens/profile_details_screen.dart';

import '../../../constants.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/list_tiles1.dart';

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
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kTextColor),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          // shadowColor: const Color.fromARGB(0, 37, 97, 107),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_ios), //replace with our own icon data.
          ),
          title: const Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(color: kTextColor),
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
                            backgroundColor: Colors.blueGrey,
                            backgroundImage:
                                const AssetImage('assets/images/avatar2.png'),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Udaya Anushanka',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                  builder: (context) =>
                                      const ProfileDetails()));
                        }),
                    const Divider(),
                    MyListTile(
                        iconLeading: Icons.support_agent_rounded,
                        title: 'Support',
                        iconTail: Icons.navigate_next,
                        press: () {}),
                    const Divider(),
                    MyListTile(
                        iconLeading: Icons.call,
                        title: 'Contact Us',
                        iconTail: Icons.navigate_next,
                        press: () {}),
                    const Divider(),
                    MyListTile(
                        iconLeading: Icons.info_outline_rounded,
                        title: 'About Us',
                        iconTail: Icons.navigate_next,
                        press: () {}),
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
                      //sign out function goes here..
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
