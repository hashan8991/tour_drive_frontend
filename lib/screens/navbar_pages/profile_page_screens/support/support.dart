import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/list_tiles1.dart';
import 'package:tour_drive_frontend/widgets/list_tiles3.dart';
// import 'package:profilepg_content/widgets/constants.dart';
// import 'package:profilepg_content/widgets/my_list_tile.dart';
// import 'package:profilepg_content/widgets/my_list_tile1.dart';

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
                                      border:
                                          Border.all(color: kSecondaryColor),
                                    ),
                                    child: const Text(
                                      'Enter the data to get support ...............',
                                      style: TextStyle(color: kTextColor),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
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
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.02),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.02),
                                        color: Colors.white,
                                        border:
                                            Border.all(color: kSecondaryColor),
                                      ),
                                      child: const Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                        style: TextStyle(color: kTextColor),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
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
                                      border:
                                          Border.all(color: kSecondaryColor),
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
                                            press: () => {},
                                          ),
                                          const Divider(),
                                          MyListTile1(
                                            title: 'Twitter',
                                            iconTail:
                                                Icons.arrow_forward_outlined,
                                            press: () => {},
                                          ),
                                          const Divider(),
                                          MyListTile1(
                                            title: 'Instagram',
                                            iconTail:
                                                Icons.arrow_forward_outlined,
                                            press: () => {},
                                          ),
                                          const Divider(),
                                          MyListTile1(
                                            title: 'Pinterest',
                                            iconTail:
                                                Icons.arrow_forward_outlined,
                                            press: () => {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
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
          )),
    );
  }
}
