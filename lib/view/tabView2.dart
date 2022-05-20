import 'package:flutter/material.dart';
import 'package:khana/view/order.dart';
import 'package:khana/view/sectionview.dart';

import '../list/section.dart';

class TabViewTwo extends StatefulWidget {
  const TabViewTwo({ Key? key }) : super(key: key);

  @override
  State<TabViewTwo> createState() => _TabViewTwoState();
}

class _TabViewTwoState extends State<TabViewTwo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                    itemCount: sec1.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Sectionlist(
                          img: sec1[index]["url"].toString(),
                          txt: sec1[index]["name"].toString(),
                          txt2: sec1[index]["text"].toString(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Order(
                                          desc: sec1[index]["rs"].toString(),
                                          title: sec1[index]["name"].toString(),
                                          url: sec1[index]["url"].toString(),
                                        ))));
                          },
                        );
                    }),
              ),
        ],
      ),
    );
  }
}