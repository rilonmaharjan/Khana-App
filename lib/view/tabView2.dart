// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:khana/view/order.dart';
import 'package:khana/view/search_food.dart';

class TabViewTwo extends StatefulWidget {
  const TabViewTwo({Key? key}) : super(key: key);

  @override
  State<TabViewTwo> createState() => _TabViewTwoState();
}

class _TabViewTwoState extends State<TabViewTwo> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Searchfood())),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color.fromARGB(255, 236, 236, 236),
                    ),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.search,
                          size: 28,
                          color: Color.fromARGB(255, 134, 134, 134),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Search...",
                          style: TextStyle(
                              color: Color.fromARGB(255, 134, 134, 134),
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color.fromARGB(255, 236, 236, 236),
                    ),
                    child: const Icon(
                      Icons.edit_note,
                      color: Color.fromARGB(255, 134, 134, 134),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("foods")
                  .orderBy("title", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'No User Data...',
                  );
                } else {
                  List<QueryDocumentSnapshot<Object?>> firestoreFoodItems =
                      snapshot.data!.docs;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: firestoreFoodItems.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return FirestoreFoodList(
                          img: firestoreFoodItems[index]["image"].toString(),
                          txt: firestoreFoodItems[index]["title"].toString(),
                          txt2: firestoreFoodItems[index]["price"].toString(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Order(
                                          desc: firestoreFoodItems[index]
                                                  ["price"]
                                              .toString(),
                                          title: firestoreFoodItems[index]
                                                  ["title"]
                                              .toString(),
                                          url: firestoreFoodItems[index]
                                                  ["image"]
                                              .toString(), analytics: analytics, observer: observer,
                                        ))));
                          },
                        );
                      });
                }
              })
        ],
      ),
    );
  }
}

class FirestoreFoodList extends StatefulWidget {
  final img, txt, txt2;
  final VoidCallback onTap;
  const FirestoreFoodList({
    Key? key,
    this.img,
    this.txt,
    this.txt2,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FirestoreFoodList> createState() => _FirestoreFoodListState();
}

class _FirestoreFoodListState extends State<FirestoreFoodList> {
  borderdec() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(17)),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 212, 210, 210),
              offset: Offset(5, 5),
              blurRadius: 20)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 10, right: 20, left: 25),
      margin: const EdgeInsets.only(
        top: 4,
        bottom: 4,
        right: 12,
        left: 12,
      ),
      decoration: borderdec(),
      height: 142,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.txt,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Text(
                    "Rs.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 136, 135, 135)),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.txt2,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 136, 135, 135)),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              ElevatedButton(
                onPressed: widget.onTap,
                child: const Text("Order Now"),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 30),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                    primary: const Color.fromARGB(255, 122, 122, 122),
                    onPrimary: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ),
          const Spacer(),
          ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 0),
                fadeOutDuration: const Duration(milliseconds: 0),
                imageUrl: widget.img,
                height: 115,
                width: 135,
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
