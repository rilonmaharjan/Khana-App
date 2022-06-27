// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:khana/remote_config.dart';
import 'package:khana/view/foods_class.dart';
import 'package:khana/view/order.dart';
import 'package:khana/view/restaurant.dart';
import 'package:khana/view/tabview1.dart';

class Food extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfigData;
  const Food({Key? key, required this.remoteConfigData}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  static RemoteConfigService remoteService = RemoteConfigService();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  top: 15,
                  left: 5,
                  right: 15,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Foods and Resturaunt",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Spacer(),
                  ],
                ),
              ),

              //Story Design
              FutureBuilder<FirebaseRemoteConfig>(
                future: remoteService.setRemoteConfig(),
                builder: (context,
                    AsyncSnapshot<FirebaseRemoteConfig> futuresnapshot) {
                  if (futuresnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Scaffold(
                      body: CircularProgressIndicator(),
                    );
                  }
                  if (futuresnapshot.hasData) {
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("foods")
                            .orderBy("title", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Text(
                              'No User Data...',
                            );
                          } else {
                            List<QueryDocumentSnapshot<Object?>>
                                firestorefoodItems = snapshot.data!.docs;
                            return SizedBox(
                              height: 120,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: firestorefoodItems.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Resturaunt(
                                      remoteConfigData:
                                          futuresnapshot.requireData,
                                      img: firestorefoodItems[index]["image"],
                                      text: firestorefoodItems[index]["title"],
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => Order(
                                                      url: firestorefoodItems[
                                                              index]["image"]
                                                          .toString(),
                                                      desc: firestorefoodItems[
                                                              index]["price"]
                                                          .toString(),
                                                      title: firestorefoodItems[
                                                              index]["title"]
                                                          .toString(), analytics: analytics, observer: observer,
                                                    ))));
                                      },
                                    );
                                  }),
                            );
                          }
                        });
                  }
                  return const Text("No text");
                },
              ),
              const SizedBox(
                height: 5,
              ),
              //offer
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 5, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      (jsonDecode(widget.remoteConfigData
                          .getString('foodView'))['text1']),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    const Icon(
                      Icons.local_offer,
                      size: 18,
                      color: Color.fromARGB(255, 255, 154, 59),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("offer1")
                      .orderBy("title", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        'No User Data...',
                      );
                    } else {
                      List<QueryDocumentSnapshot<Object?>>
                          firestoreOffer1Items = snapshot.data!.docs;
                      return SizedBox(
                        height: 245,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: firestoreOffer1Items.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Offer(
                                img: firestoreOffer1Items[index]["image"],
                                text: firestoreOffer1Items[index]["title"],
                                text2: firestoreOffer1Items[index]["price"],
                                text3: firestoreOffer1Items[index]["prevprice"],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Order(
                                            analytics: analytics, observer: observer,
                                                url: firestoreOffer1Items[index]
                                                        ["image"]
                                                    .toString(),
                                                desc:
                                                    firestoreOffer1Items[index]
                                                            ["price"]
                                                        .toString(),
                                                title:
                                                    firestoreOffer1Items[index]
                                                            ["title"]
                                                        .toString(),
                                              ))));
                                },
                              );
                            }),
                      );
                    }
                  }),
              const SizedBox(
                height: 19,
              ),

              //worldcup offer2
              Padding(
                padding: const EdgeInsets.only(left: 14, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      (jsonDecode(widget.remoteConfigData
                          .getString('foodView'))['text2']),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Icon(
                      Icons.sports_soccer,
                      size: 19,
                      color: Color(int.parse(jsonDecode(widget.remoteConfigData
                          .getString('foodView'))['color'])),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("offer2")
                      .orderBy("title", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        'No User Data...',
                      );
                    } else {
                      List<QueryDocumentSnapshot<Object?>>
                          firestoreOffer2Items = snapshot.data!.docs;
                      return SizedBox(
                        height: 245,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: firestoreOffer2Items.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Offer2(
                                img: firestoreOffer2Items[index]["image"],
                                text: firestoreOffer2Items[index]["title"],
                                text2: firestoreOffer2Items[index]["price"],
                                text3: firestoreOffer2Items[index]["prevprice"],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Order(
                                            analytics: analytics, observer: observer,
                                                url: firestoreOffer2Items[index]
                                                        ["image"]
                                                    .toString(),
                                                desc:
                                                    firestoreOffer2Items[index]
                                                            ["price"]
                                                        .toString(),
                                                title:
                                                    firestoreOffer2Items[index]
                                                            ["title"]
                                                        .toString(),
                                              ))));
                                },
                              );
                            }),
                      );
                    }
                  }),

              const SizedBox(
                height: 15,
              ),

              //rwsturaunt
              Row(
                children: const [
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "All Restaurants",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.restaurant_menu,
                    size: 19,
                    color: Colors.green,
                  ),
                  Spacer(),
                  Text(
                    "Restaurants near you",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("restaurant")
                      .orderBy("title", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        'No User Data...',
                      );
                    } else {
                      List<QueryDocumentSnapshot<Object?>>
                          firestoreRestroItems = snapshot.data!.docs;
                      return SizedBox(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: firestoreRestroItems.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return FirebaseRestroItems(
                                img: firestoreRestroItems[index]["image"]
                                    .toString(),
                                txt: firestoreRestroItems[index]["title"]
                                    .toString(),
                                txt2: firestoreRestroItems[index]["rating"]
                                    .toString(),
                                txt3: firestoreRestroItems[index]["location"]
                                    .toString(),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Restaurant(
                                                img: firestoreRestroItems[index]
                                                        ["image"]
                                                    .toString(),
                                                title:
                                                    firestoreRestroItems[index]
                                                            ["title"]
                                                        .toString(),
                                                text:
                                                    firestoreRestroItems[index]
                                                            ["rating"]
                                                        .toString(),
                                                text2:
                                                    firestoreRestroItems[index]
                                                            ["location"]
                                                        .toString(),
                                              ))));
                                },
                              );
                            }),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
