// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'order.dart';

class Sections extends StatefulWidget {
  final title;
  const Sections({Key? key, required this.title}) : super(key: key);

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
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
                    top: 10, left: 16, right: 8, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const Spacer(),
                    GestureDetector(
                      child: const Icon(Icons.arrow_back_ios),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
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
                          firestoreauthentic= snapshot.data!.docs;
                      return 
              SizedBox(
                height: MediaQuery.of(context).size.height - 102.918,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: firestoreauthentic.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (widget.title == firestoreauthentic[index]["category"]) {
                        return Sectionlist(
                          img: firestoreauthentic[index]["image"].toString(),
                          txt: firestoreauthentic[index]["title"].toString(),
                          txt2: firestoreauthentic[index]["price"].toString(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Order(
                                          desc: firestoreauthentic[index]["price"].toString(),
                                          title: firestoreauthentic[index]["title"].toString(),
                                          url: firestoreauthentic[index]["image"].toString(), analytics: analytics, observer: observer,
                                        ))));
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
              );
  }}),
            ],
          ),
        ),
      ),
    );
  }
}

class Sectionlist extends StatefulWidget {
  final img, txt, txt2;
  final VoidCallback onTap;
  const Sectionlist({
    Key? key,
    this.img,
    this.txt,
    this.txt2,
    required this.onTap,
  }) : super(key: key);

  @override
  State<Sectionlist> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<Sectionlist> {
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
                children:  [
                  const Text("Rs.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 136, 135, 135)),
                  ),
                  const SizedBox(width: 5,),
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
                imageUrl:
                widget.img,
                height: 115,
                width: 135,
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
