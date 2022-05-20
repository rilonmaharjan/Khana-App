// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:khana/list/list.dart';
import 'package:khana/view/foodsClass.dart';
import 'package:khana/view/order.dart';
import 'package:khana/view/restaurant.dart';
import 'package:khana/view/search.dart';

import '../list/foodsList.dart';
import '../list/restaurantList.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
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
                  top: 10,
                  left: 5,
                  right: 15,
                ),
                child: Row(
                  children: [
                    const Text(
                      "Foods and Resturaunt",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()))),
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 235, 231, 231),
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 29,
                          )),
                    ),
                  ],
                ),
              ),

              //Story Design
              SizedBox(
                height: 118,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Resturaunt(
                        img: list[index]["img"],
                        text: list[index]["text"],
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Order(
                                        url: list[index]["img"].toString(),
                                        desc: list[index]["rs"].toString(),
                                        title: list[index]["text"].toString(),
                                      ))));
                        },
                      );
                    }),
              ),

              //offer
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 5, bottom: 5),
                child: Row(
                  children: const [
                    Text(
                      "Pre Monsoon Offer",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Icon(
                      Icons.local_offer,
                      size: 18,
                      color: Color.fromARGB(255, 255, 154, 59),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 245,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: offer.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Offer(
                        img: offer[index]["img"],
                        text: offer[index]["text"],
                        text2: offer[index]["text2"],
                        text3: offer[index]["text3"],
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Order(
                                        url: offer[index]["img"].toString(),
                                        desc: offer[index]["rs"].toString(),
                                        title: offer[index]["text"].toString(),
                                      ))));
                        },
                      );
                    }),
              ),

              const SizedBox(
                height: 15,
              ),

              //worldcup offer2
              Padding(
                padding: const EdgeInsets.only(left: 14, bottom: 5),
                child: Row(
                  children: const [
                    Text(
                      "World Cup Offer",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Icon(Icons.sports_soccer, size: 19, color: Colors.blue),
                  ],
                ),
              ),
              SizedBox(
                height: 245,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: offer2.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Offer2(
                        img: offer2[index]["img"],
                        text: offer2[index]["text"],
                        text2: offer2[index]["text2"],
                        text3: offer2[index]["text3"],
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Order(
                                        url: offer2[index]["img"].toString(),
                                        desc: offer2[index]["rs"].toString(),
                                        title: offer2[index]["text"].toString(),
                                      ))));
                        },
                      );
                    }),
              ),

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
              SizedBox(
                child: ListView.builder(
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
                                        text2:
                                            restro[index]["text3"].toString(),
                                      ))));
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodItems extends StatefulWidget {
  final img, txt, txt2, txt3;
  final VoidCallback onTap;
  const FoodItems(
      {Key? key, this.img, this.txt, this.txt2, this.txt3, required this.onTap})
      : super(key: key);

  @override
  State<FoodItems> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  borderdec() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        border: const Border(
          top:
              BorderSide(width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
          left:
              BorderSide(width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
          right:
              BorderSide(width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
          bottom:
              BorderSide(width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: borderdec(),
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: Image.asset(
                widget.img,
                height: 180,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, left: 13),
              child: Text(
                widget.txt,
                style: const TextStyle(
                    color: Color.fromARGB(255, 17, 17, 17),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 255, 186, 59),
                  size: 17,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.txt2,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 102, 101, 101),
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 17,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.txt3,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 102, 101, 101),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
