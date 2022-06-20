import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:khana/remote_config.dart';
import 'package:khana/view/change_password.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khana/view/notification.dart';
import 'package:khana/view/permissions.dart';
import 'package:khana/view/register.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottomnav.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  
 static RemoteConfigService remoteService = RemoteConfigService();
  final user = FirebaseAuth.instance.currentUser;
  gifImage() {
    return Image.asset(
      "images/gif.gif",
      height: 70,
      width: 70,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            iconTheme: const IconThemeData(color: Colors.black),
            expandedHeight: 210.0,
            floating: true,
            title: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            actions: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  )
                ],
              ),
            ],
            automaticallyImplyLeading: false,
            flexibleSpace: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where('email', isEqualTo: user!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      'No User Data...',
                    );
                  } else {
                    List<QueryDocumentSnapshot<Object?>> firestoreItems =
                        snapshot.data!.docs;
                    return FlexibleSpaceBar(
                        background: Stack(
                      children: [
                        firestoreItems[0]['photo'] != ""
                            ? CachedNetworkImage(
                                imageUrl: firestoreItems[0]['photo'],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "images/sliver.jpg",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        Container(
                          color: const Color.fromARGB(103, 0, 0, 0),
                          width: double.infinity,
                        ),
                      ],
                    ));
                  }
                }),
                bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 21, bottom: 18),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                                boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 235, 233, 233),
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]
                           ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Notificason()));
                          },
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 22,
                              ),
                              Icon(
                                Icons.notifications,
                                color: Color.fromARGB(255, 121, 120, 120),
                                size: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Notifications",
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 121, 120, 120),
                                size: 18,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  // height: 782.0,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                       right: 5, left: 5, bottom: 8),
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 7,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 21, bottom: 18),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 235, 233, 233),
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Accounts",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 92, 92, 92)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FutureBuilder<FirebaseRemoteConfig>(
                                              future: remoteService
                                                  .setRemoteConfig(),
                                              builder: (context,
                                                  AsyncSnapshot<
                                                          FirebaseRemoteConfig>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Scaffold(
                                                    body:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                if (snapshot.hasData) {
                                                  return BottomNav(
                                                    remoteConfigData:
                                                        snapshot.requireData,
                                                    index: 4,
                                                  );
                                                }
                                                return const Text("No text");
                                              }),
                                    ));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.person_rounded,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Profile",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChangePassword()));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.security,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Security",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 21, bottom: 18),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 235, 233, 233),
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 92, 92, 92)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: (){
                                Utils.showSnackBar("Not available at the moment", false);
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.language,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Language",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Permissions()));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.back_hand_outlined,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Permissions",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 21, bottom: 18),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 235, 233, 233),
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "More",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 92, 92, 92)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                String phoneUrl = "tel:+977 9861333461";
                                launchUrl(Uri.parse(phoneUrl));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.phone_in_talk,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Help", style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Rate Us",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                String mailUrl =
                                    "mailto:rilon.maharjan@gmail.com?subject=Feedback to KhanaGhar&body=";
                                launchUrl(Uri.parse(mailUrl));
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.feedback,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Feedback",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              indent: 13,
                              endIndent: 13,
                              thickness: 0.3,
                              color: Color.fromARGB(255, 199, 199, 199),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                      "Khana Ghar has developed to incorporate many superb takeout areas in Kathmandu with additional to come sooner rather than later. Our group takes pride in the way that we can furnish our new and faithful clients with extraordinary tasting Nepali authentics that is not normal for that at some other Nepali eatery you visit. Just sit back, relax and wait for your order to arrive.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(
                                              255, 151, 150, 150)),
                                    ),
                                    content: gifImage(),
                                    contentPadding: const EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                        bottom: 12,
                                        top: 8),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Icon(
                                    Icons.info_outline,
                                    color: Color.fromARGB(255, 121, 120, 120),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("About Us",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                          top: 18,
                          bottom: 13,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 235, 233, 233),
                                  offset: Offset(2, 2),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    String url =
                                        "https://www.facebook.com/rilonmhrzn/";
                                    launchUrl(Uri.parse(url));
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.facebook,
                                    size: 25,
                                    color: Color.fromARGB(237, 33, 149, 243),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    String url =
                                        "https://www.youtube.com/channel/UC18AKFbWJ3Wg_op3pbTvR_Q";
                                    launchUrl(Uri.parse(url));
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: 25,
                                    color: Color.fromARGB(206, 244, 67, 54),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    String url =
                                        "https://twitter.com/Rilon_mhrzn";
                                    launchUrl(Uri.parse(url));
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.twitter,
                                    size: 25,
                                    color: Color.fromARGB(202, 33, 149, 243),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    String url =
                                        "https://www.instagram.com/rilon.maharjan/";
                                    launchUrl(Uri.parse(url));
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.instagram,
                                    size: 25,
                                    color: Color.fromARGB(255, 255, 153, 0),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Center(
                              child: Text(
                                "Developed by WeebTech",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 156, 155, 155)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                              child: Text(
                                "Version 1.0.0",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 156, 155, 155)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class UrlLauncher {}
