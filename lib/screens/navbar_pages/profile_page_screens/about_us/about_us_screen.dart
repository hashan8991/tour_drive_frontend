import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/list_tiles1.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final Uri toLaunch = Uri(
        scheme: 'https', host: 'tour-drive.azurewebsites.net', path: '/blog');
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
            "About Us",
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
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Our Story",
                  style: TextStyle(fontSize: 20, color: kTextColor),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
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
                  child: const Text(
                    "✪ Welcome to our travel and vehicle managing company. We offer seamless, stress-free travel experiences and specialize in providing transportation solutions tailored to your needs. Our experienced team can help you plan your itinerary and book all your reservations in advance. Sit back, relax, and let us take care of the details so you can enjoy your journey. Contact us to learn more.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: kTextColor),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Divider(),
                MyListTile(
                  iconLeading: Icons.tips_and_updates_outlined,
                  title: 'Travel Blog & Tips',
                  iconTail: Icons.navigate_next,
                  press: () {
                    showDialog(
                      barrierColor: const Color.fromARGB(100, 80, 132, 11),
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                          Icons.tips_and_updates_outlined,
                          color: kPrimaryColor,
                        ),
                        title: const Text(
                          'Travel Bolg & Tips',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: Container(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.02),
                              color: Colors.white,
                              border: Border.all(color: kSecondaryColor),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Text(
                                    'Our Travel Blog',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kTextColor,
                                    ),
                                  ),
                                  const Text(
                                    '\n\nTo learn more about us, use our blog it will bring more about our previous tours',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: kTextColor),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: kSecondaryColor),
                                    onPressed: () => setState(() {
                                      _launched = _launchInBrowser(toLaunch);
                                    }),
                                    child: const Text(
                                        'Press here to visit our blog'),
                                  ),
                                  const Text(
                                    '\n\nSome Travel Tips\n',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kTextColor,
                                    ),
                                  ),
                                  const Text(
                                    '1.Do your research: Before traveling to a new destination, make sure to research about the place. Read about its culture, customs, local laws, popular attractions, and safety concerns. This will help you plan your trip better and make the most of your time there.\n\n2.Pack light: Avoid overpacking by packing only what you need. Stick to the essentials like clothes, toiletries, and gadgets. This will make traveling more comfortable and less stressful, especially when moving from one place to another.\n\n3.Stay connected: Make sure to keep your family and friends informed about your travel plans and keep in touch with them during your trip. You can also use social media platforms to share your travel experiences with your loved ones.\n\n4.Stay safe: Be aware of your surroundings and take necessary precautions to stay safe. Keep your valuables close to you, avoid unsafe areas, and be cautious when interacting with strangers.\n\n5.Try new things: Traveling is a great opportunity to try new things. Be open to trying new foods, activities, and experiences. This will enrich your travel experience and create lasting memories.\n\n6.Respect local customs: When traveling to a new destination, make sure to respect local customs and traditions. This includes dressing appropriately, avoiding disrespectful behavior, and being mindful of cultural differences.\n\n7.Keep an open mind: Traveling can be a great learning experience. Keep an open mind and be receptive to new ideas, cultures, and perspectives. This will broaden your horizons and make your trip more rewarding.\n\n8.Stay flexible: Be prepared for unexpected changes or delays in your travel plans. Stay flexible and be ready to adjust your itinerary accordingly. This will help you avoid unnecessary stress and make the most of your trip.\n',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: kTextColor),
                                  ),
                                ],
                              ),
                            )),
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
                  iconLeading: Icons.group_work_outlined,
                  title: 'Working With Us',
                  iconTail: Icons.navigate_next,
                  press: () {
                    showDialog(
                      barrierColor: const Color.fromARGB(100, 80, 132, 11),
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                          Icons.tips_and_updates_outlined,
                          color: kPrimaryColor,
                        ),
                        title: const Text(
                          'Working With Us',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: Container(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                            color: Colors.white,
                            border: Border.all(color: kSecondaryColor),
                          ),
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(color: kTextColor),
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
                  iconLeading: Icons.corporate_fare_outlined,
                  title: 'Be Our Partner',
                  iconTail: Icons.navigate_next,
                  press: () {
                    showDialog(
                      barrierColor: const Color.fromARGB(100, 80, 132, 11),
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(
                          Icons.tips_and_updates_outlined,
                          color: kPrimaryColor,
                        ),
                        title: const Text(
                          'Be Our Partner',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: Container(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                            color: Colors.white,
                            border: Border.all(color: kSecondaryColor),
                          ),
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(color: kTextColor),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
