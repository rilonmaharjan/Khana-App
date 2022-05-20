// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khana/list/list.dart';
import 'package:khana/view/order.dart';
import 'package:khana/view/sectionview.dart';

import 'bottomnav.dart';

class Khana extends StatefulWidget {
  const Khana({Key? key}) : super(key: key);

  @override
  State<Khana> createState() => _KhanaState();
}

class _KhanaState extends State<Khana> {
  var box = GetStorage();
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
                      children: const [
                        Text(
                          "Khana Ghar",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Check out our food items',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNav(index: 2))),
                    child: Container(
                      padding: const EdgeInsets.only(right: 25),
                      child: CircleAvatar(
                          radius: 34.5,
                          backgroundColor:
                              const Color.fromARGB(255, 130, 137, 247),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: box.read("a") != null
                                ? Image.file(
                                    File(box.read("a")),
                                    height: 65,
                                    width: 65,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/icon/l1.png",
                                    height: 65,
                                    width: 65,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                    ),
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
                            children: const [
                              Icon(
                                Icons.food_bank,
                                size: 32,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Authentics',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
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
                                    const Sections(title: "Achaar")))),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 24, left: 12, right: 5),
                          height: 112,
                          width: MediaQuery.of(context).size.width / 2.31,
                          decoration: borderdec(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.restaurant,
                                    size: 23,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    'Achaar',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Row(
                                children:  [
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
                                    width: MediaQuery.of(context).size.width*0.3,
                                    child: const Text(
                                      'Special Achar', overflow: TextOverflow.ellipsis,
                                      
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 146, 145, 145)),
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
                              top: 23, left: 12, right: 5),
                          margin: const EdgeInsets.only(top: 16),
                          height: 112,
                          width: MediaQuery.of(context).size.width / 2.31,
                          decoration: borderdec(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.local_pizza,
                                    size: 26,
                                    color: Color.fromARGB(255, 255, 230, 0),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Our Pizza',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Row(
                                children:  [
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
                                    width: MediaQuery.of(context).size.width*0.27,
                                    child: const Text(
                                      'Special Pizza',overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 146, 145, 145)),
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
                    children: const [
                      Text(
                        'Explore our food items',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  height: 165,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return CardTile(
                          img: data[index]["url"],
                          txt: data[index]["name"],
                          txt1: data[index]["text"],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Order(
                                          desc: data[index]["rs"].toString(),
                                          title: data[index]["name"].toString(),
                                          url: data[index]["url"].toString(),
                                        ))));
                          },
                        );
                      }),
                ),
              ],
            ),

            //Body3
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(
                  top: 25, right: 16, left: 16, bottom: 10),
              decoration: borderdec(),
              height: 128,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Image.asset(
                    "images/img-2.png",
                    height: 80,
                    width: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:7.0,left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width *0.5,
                          child: const Text(
                            "Free and Quick Delivery!",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
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
                              style: TextStyle(fontWeight: FontWeight.w600),
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
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
              child: Image.asset(
                widget.img,
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
