// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khana/view/restaurant.dart';
import 'package:khana/view/searchh.dart';

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
          GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const Search())),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 15),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width-80,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
                    color: const Color.fromARGB(255, 236, 236, 236),),
                    child: Row(children: const[
                      SizedBox(width: 15,),
                      Icon(Icons.search,size: 28,color: Color.fromARGB(255, 134, 134, 134),),
                      SizedBox(width: 16,),
                      Text("Search...", style: TextStyle(color: Color.fromARGB(255, 134, 134, 134),fontSize: 16),)
                    ],),
                  ),
              const SizedBox(width: 10,),
              Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
                    color: const Color.fromARGB(255, 236, 236, 236),),
                    child: const Icon(Icons.edit_note,color: Color.fromARGB(255, 134, 134, 134),size: 28,),
                  ),
               ],
              ),
            ),
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
                  List<QueryDocumentSnapshot<Object?>> firestoreRestroItems =
                      snapshot.data!.docs;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: firestoreRestroItems.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return FirebaseRestroItems(
                          img: firestoreRestroItems[index]["image"].toString(),
                          txt: firestoreRestroItems[index]["title"].toString(),
                          txt2:
                              firestoreRestroItems[index]["rating"].toString(),
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
                                          title: firestoreRestroItems[index]
                                                  ["title"]
                                              .toString(),
                                          text: firestoreRestroItems[index]
                                                  ["rating"]
                                              .toString(),
                                          text2: firestoreRestroItems[index]
                                                  ["location"]
                                              .toString(),
                                        ))));
                          },
                        );
                      });
                }
              }),
        ],
      ),
    );
  }
}

class FirebaseRestroItems extends StatefulWidget {
  final img, txt, txt2, txt3;
  final VoidCallback onTap;
  const FirebaseRestroItems(
      {Key? key, this.img, this.txt, this.txt2, this.txt3, required this.onTap})
      : super(key: key);

  @override
  State<FirebaseRestroItems> createState() => _FirebaseRestroItemsState();
}

class _FirebaseRestroItemsState extends State<FirebaseRestroItems> {
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
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 0),
                fadeOutDuration: const Duration(milliseconds: 0),
                imageUrl: widget.img,
                height: 180,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8, left: 13),
              child: FittedBox(
                child: Text(
                  widget.txt,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 17, 17, 17),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
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
                FittedBox(
                  child: Text(
                    widget.txt3,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 102, 101, 101),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400),
                  ),
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
