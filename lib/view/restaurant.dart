// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:khana/view/searchh.dart';

import 'foods_class.dart';
import 'order.dart';

class Restaurant extends StatefulWidget {
  final img, title, text, text2;
  const Restaurant(
      {Key? key, required this.img, this.title, this.text, this.text2})
      : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: const Color.fromARGB(255, 254, 255, 248),
          expandedHeight: 180.0,
          floating: true,
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Search()));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 185, 184, 184),
                                offset: Offset(2, 2),
                                blurRadius: 2)
                          ]),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      )),
                ),
                const SizedBox(
                  width: 17,
                ),
              ],
            )
          ],
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 185, 184, 184),
                          offset: Offset(2, 2),
                          blurRadius: 2)
                    ]),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                )),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 0),
              fadeOutDuration: const Duration(milliseconds: 0),
              imageUrl: widget.img,
              fit: BoxFit.cover,
            ),
          ),
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 254, 255, 248),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: const Color.fromARGB(255, 254, 255, 248),
                height: 750,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 13,
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 15,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.text2,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 13,
                        ),
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.text,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 41, 41, 41),
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        const Text(
                          "See Reviews",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Divider(
                      indent: 15,
                      endIndent: 15,
                      thickness: 0.5,
                      color: Color.fromARGB(255, 201, 200, 200),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(26, 240, 108, 126),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Color.fromARGB(255, 206, 29, 16),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: const Text(
                                "Use code TAPTAP2022 to get Rs.150 off on orders",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 206, 29, 16),
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Divider(
                      indent: 15,
                      endIndent: 15,
                      thickness: 0.5,
                      color: Color.fromARGB(255, 201, 200, 200),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      child: Row(
                        children: const [
                          Text(
                            "Menu",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.ramen_dining,
                            size: 19,
                            color: Color.fromARGB(176, 0, 0, 0),
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
                                      text: firestoreOffer1Items[index]
                                          ["title"],
                                      text2: firestoreOffer1Items[index]
                                          ["price"],
                                      text3: firestoreOffer1Items[index]
                                          ["prevprice"],
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => Order(
                                                      url: firestoreOffer1Items[
                                                              index]["image"]
                                                          .toString(),
                                                      desc:
                                                          firestoreOffer1Items[
                                                                      index]
                                                                  ["price"]
                                                              .toString(),
                                                      title:
                                                          firestoreOffer1Items[
                                                                      index]
                                                                  ["title"]
                                                              .toString(), analytics: analytics, observer: observer,
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

                    //worldcup offer2
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 5),
                      child: Row(
                        children: const [
                          Text(
                            "World Cup Offer",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(Icons.sports_soccer,
                              size: 19, color: Colors.blue),
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
                                        img: firestoreOffer2Items[index]
                                            ["image"],
                                        text: firestoreOffer2Items[index]
                                            ["title"],
                                        text2: firestoreOffer2Items[index]
                                            ["price"],
                                        text3: firestoreOffer2Items[index]
                                            ["prevprice"],
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) => Order(
                                                        url:
                                                            firestoreOffer2Items[
                                                                        index]
                                                                    ["image"]
                                                                .toString(),
                                                        desc:
                                                            firestoreOffer2Items[
                                                                        index]
                                                                    ["price"]
                                                                .toString(),
                                                        title:
                                                            firestoreOffer2Items[
                                                                        index]
                                                                    ["title"]
                                                                .toString(), analytics: analytics, observer: observer,
                                                      ))));
                                        },
                                      );
                                  }),
                            );
                          }
                        }),
                  ],
                ),
              );
            },
            childCount: 1,
          ),
        )
      ],
    ));
  }
}
