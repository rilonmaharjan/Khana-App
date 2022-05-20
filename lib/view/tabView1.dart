import 'package:flutter/material.dart';
import 'package:khana/list/restaurantList.dart';
import 'package:khana/view/foods.dart';
import 'package:khana/view/restaurant.dart';

class TabViewOne extends StatefulWidget {
  const TabViewOne({Key? key}) : super(key: key);

  @override
  State<TabViewOne> createState() => _TabViewOneState();
}

class _TabViewOneState extends State<TabViewOne> {
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
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restro.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return FoodItems(
                  img: restro[index]["img"],
                  txt: restro[index]["text"],
                  txt2: restro[index]["text2"],
                  txt3: restro[index]["text3"],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Restaurant(
                                  img: restro[index]["img"].toString(),
                                  title: restro[index]["text"].toString(),
                                  text: restro[index]["text2"].toString(),
                                  text2: restro[index]["text3"].toString(),
                                ))));
                  },
                );
              }),
        ],
      ),
    );
  }
}
