// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khana/remote_config.dart';
import 'package:khana/view/order.dart';
import 'package:khana/view/sectionview.dart';

import 'bottomnav.dart';

class Khana extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfigData;
  const Khana({Key? key, required this.remoteConfigData}) : super(key: key);

  @override
  State<Khana> createState() => _KhanaState();
}

class _KhanaState extends State<Khana> {
  static RemoteConfigService remoteService = RemoteConfigService();
  var box = GetStorage();
  var user = FirebaseAuth.instance.currentUser;
  borderdec() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(17)),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 185, 184, 184),
              offset: Offset(5, 5),
              blurRadius: 10)
        ]);
  }

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  String get text =>
      jsonDecode(widget.remoteConfigData.getString('khanaView'))['text'];

  String get image =>
      jsonDecode(widget.remoteConfigData.getString('khanaView'))['image'];

  int get color => int.parse(
      jsonDecode(widget.remoteConfigData.getString('khanaView'))['color']);

  int get color2 => int.parse(
      jsonDecode(widget.remoteConfigData.getString('khanaView'))['color2']);

  double get size =>
      jsonDecode(widget.remoteConfigData.getString('khanaView'))['size'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            //Heading
            SafeArea(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 27),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Khana Ghar",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(color),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Check out our food items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(color),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FutureBuilder<FirebaseRemoteConfig>(
                                  future: remoteService.setRemoteConfig(),
                                  builder: (context,
                                      AsyncSnapshot<FirebaseRemoteConfig>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Scaffold(
                                        body: CircularProgressIndicator(),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      return BottomNav(
                                        remoteConfigData: snapshot.requireData,
                                        index: 4,
                                      );
                                    }
                                    return const Text("No text");
                                  }),
                        )),
                    child: StreamBuilder<QuerySnapshot>(
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
                            List<QueryDocumentSnapshot<Object?>>
                                firestoreItems = snapshot.data!.docs;
                            return Container(
                              padding: const EdgeInsets.only(right: 25),
                              child: CircleAvatar(
                                  radius: 34.5,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: firestoreItems[0]['photo'] != ""
                                        ? CachedNetworkImage(
                                            imageUrl: firestoreItems[0]
                                                ['photo'],
                                            height: 65,
                                            width: 65,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/icon/l2.png",
                                            height: 75,
                                            width: 75,
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),

            //Body1

            Container(
              margin: const EdgeInsets.only(top: 26),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //body1_box1
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const Sections(title: "Authentics")))),
                    child: Container(
                      padding: const EdgeInsets.only(top: 19),
                      height: 240,
                      width: MediaQuery.of(context).size.width / 2.22,
                      decoration: borderdec(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.food_bank,
                                size: 32,
                                color: Colors.orange,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text('Authentics',
                                  style: TextStyle(
                                    color: Color(color),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            '14',
                            style: TextStyle(
                                fontSize: 80, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Text(
                            'Delicious',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 146, 145, 145)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'Items',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 146, 145, 145)),
                          )
                        ],
                      ),
                    ),
                  ),

                  //body1_box2
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const Sections(title: "Achar")))),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 24, left: 12, right: 12),
                          height: 112,
                          width: MediaQuery.of(context).size.width / 2.31,
                          decoration: borderdec(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  const Icon(
                                    Icons.restaurant,
                                    size: 23,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    'Achar',
                                    style: TextStyle(
                                        color: Color(color),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Text('8',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width -285,
                                    child: const FittedBox(
                                      child: Text(
                                        'Special Achar',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 146, 145, 145)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      ////body1_box3
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const Sections(title: "Our Pizza")))),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 23, left: 12, right: 12),
                          margin: const EdgeInsets.only(top: 16),
                          height: 112,
                          width: MediaQuery.of(context).size.width / 2.31,
                          decoration: borderdec(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  const Icon(
                                    Icons.local_pizza,
                                    size: 26,
                                    color: Color.fromARGB(255, 255, 230, 0),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Our Pizza',
                                    style: TextStyle(
                                        color: Color(color),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('12',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -290,
                                    child: const FittedBox(
                                      child: Text(
                                        'Special Pizza',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 146, 145, 145)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //Body 2
            const SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Explore our food items',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(color),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("explore")
                        .orderBy("title", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text(
                          'No User Data...',
                        );
                      } else {
                        List<QueryDocumentSnapshot<Object?>> firestoreExplore =
                            snapshot.data!.docs;
                        return Container(
                          padding: const EdgeInsets.only(left: 15),
                          height: 165,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: firestoreExplore.length,
                              itemBuilder: (context, index) {
                                return CardTile(
                                  img: firestoreExplore[index]["image"],
                                  txt: firestoreExplore[index]["title"]
                                      .toString(),
                                  txt1: firestoreExplore[index]["desc"]
                                      .toString(),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => Order(
                                                  desc: firestoreExplore[index]
                                                          ["price"]
                                                      .toString(),
                                                  title: firestoreExplore[index]
                                                          ["title"]
                                                      .toString(),
                                                  url: firestoreExplore[index]
                                                          ["image"]
                                                      .toString(),
                                                  analytics: analytics,
                                                  observer: observer,
                                                ))));
                                  },
                                );
                              }),
                        );
                      }
                    })
              ],
            ),

            //Body3
            Center(
                child: widget.remoteConfigData.getBool('khanaContainer')
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(
                            top: 25, right: 16, left: 16, bottom: 10),
                        decoration: borderdec(),
                        height: 128,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Image.asset(
                              image,
                              height: 80,
                              width: 80,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: FittedBox(
                                      child: Text(
                                        text,
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: Color(color),
                                            fontSize: size,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 15,
                                        color: Color(color2),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Within 30 minutes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(color2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 15,
                                        color: Color(color2),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "All over Nepal",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(color2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(
                            top: 25, right: 16, left: 16, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            border: const Border(
                              top: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 211, 210, 210)),
                              left: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 211, 210, 210)),
                              right: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 211, 210, 210)),
                              bottom: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(255, 211, 210, 210)),
                            )),
                        height: 128,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Image.asset(
                              image,
                              height: 80,
                              width: 80,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      text,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: size,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Within 30 minutes",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "All over Nepal",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

class CardTile extends StatefulWidget {
  final img, txt, txt1;
  final VoidCallback onTap;
  const CardTile({Key? key, this.img, this.txt, this.txt1, required this.onTap})
      : super(key: key);

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 0),
                fadeOutDuration: const Duration(milliseconds: 0),
                imageUrl: widget.img,
                height: 165,
                width: 270,
                fit: BoxFit.cover,
              )),
          Container(
            height: 165,
            width: 270,
            padding: const EdgeInsets.only(top: 25, left: 28),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: const Color.fromARGB(103, 0, 0, 0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.txt,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.txt1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                ElevatedButton(
                  onPressed: widget.onTap,
                  child: const Text("Order Now"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(50, 30),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                      primary: const Color.fromARGB(255, 255, 255, 255),
                      onPrimary: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
