import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:khana/view/order.dart';
import 'package:khana/view/tabview2.dart';

class Searchfood extends StatefulWidget {
  const Searchfood({Key? key}) : super(key: key);

  @override
  State<Searchfood> createState() => _SearchfoodState();
}

class _SearchfoodState extends State<Searchfood> {
  final nameHolder = TextEditingController();
  clearTextInput() {
    nameHolder.clear();
  }

  var name = "";

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 21,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: const Border(
                    top: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                    left: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                    right: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                    bottom: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                  )),
              child: Center(
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: nameHolder,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color.fromARGB(186, 244, 67, 54),
                        ),
                        onPressed: clearTextInput,
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit_note,
                            color: Color.fromARGB(255, 71, 71, 71),
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Filter",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 71, 71),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(87, 30),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          primary: const Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Offer",
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 71, 71),
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(87, 30),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          primary: const Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Delivery",
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 71, 71),
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(87, 30),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          primary: const Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Service",
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 71, 71),
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(87, 30),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          primary: const Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: (name != "")
                        ? FirebaseFirestore.instance
                            .collection('foods')
                            .where('title', isGreaterThanOrEqualTo: name)
                            .where('title', isLessThan: name + 'z')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("foods")
                            .snapshots(),
                    builder: (context, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.docs.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Object?>? data =
                                    snapshot.data?.docs[index];
                                return FirestoreFoodList(
                                  img: data!["image"].toString(),
                                  txt: data["title"].toString(),
                                  txt2: data["price"].toString(),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => Order(
                                                  desc: data["prevprice"]
                                                      .toString(),
                                                  title:
                                                      data["title"].toString(),
                                                  url: data["image"].toString(), analytics: analytics, observer: observer,
                                                ))));
                                  },
                                );
                              });
                    }),
              ],
            ),
          ),
        ));
  }
}
