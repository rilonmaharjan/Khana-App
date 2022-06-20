//ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class Resturaunt extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfigData;
  final img, text;
  final VoidCallback onTap;

  const Resturaunt(
      {Key? key,
      this.img,
      this.text,
      required this.onTap,
      required this.remoteConfigData})
      : super(key: key);

  @override
  State<Resturaunt> createState() => _ResturauntState();
}

class _ResturauntState extends State<Resturaunt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Column(
        children: [
          GestureDetector(
              onTap: widget.onTap,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    (jsonDecode(widget.remoteConfigData.getString('foodView'))[
                        'radius']),
                  ),
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 0),
                    imageUrl: widget.img,
                    height: 65,
                    width: 65,
                    fit: BoxFit.cover,
                  ))),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.text,
            style: const TextStyle(
                color: Color.fromARGB(255, 70, 69, 69),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class Offer extends StatefulWidget {
  final img, text, text2, text3;
  final VoidCallback onTap;
  const Offer(
      {Key? key,
      this.img,
      this.text,
      this.text2,
      required this.onTap,
      this.text3})
      : super(key: key);

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        height: 260,
        width: 260,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
            border: const Border(
              top: BorderSide(
                  width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
              left: BorderSide(
                  width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
              right: BorderSide(
                  width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
              bottom: BorderSide(
                  width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 0),
                  fadeOutDuration: const Duration(milliseconds: 0),
                  imageUrl: widget.img,
                  height: 160,
                  width: 260,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 17, 17, 17),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                      left: 8, right: 5, top: 5, bottom: 5),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: const Text(
                    "Friday Offer",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "Rs.",
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 101, 101),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  widget.text2,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 102, 101, 101),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.text3,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Color.fromARGB(255, 102, 101, 101),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Offer2 extends StatefulWidget {
  final img, text, text2, text3;
  final VoidCallback onTap;
  const Offer2({
    Key? key,
    this.img,
    this.text,
    this.text2,
    required this.onTap,
    this.text3,
  }) : super(key: key);

  @override
  State<Offer2> createState() => _Offer2State();
}

class _Offer2State extends State<Offer2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            height: 260,
            width: 260,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                border: const Border(
                  top: BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
                  left: BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
                  right: BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
                  bottom: BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6)),
                    child: CachedNetworkImage(
                      fadeInDuration: const Duration(milliseconds: 0),
                      fadeOutDuration: const Duration(milliseconds: 0),
                      imageUrl: widget.img,
                      height: 160,
                      width: 260,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 17, 17, 17),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Rs.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 102, 101, 101),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.text2,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 102, 101, 101),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.text3,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Color.fromARGB(255, 102, 101, 101),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10.1),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 5, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(10))),
              child: const Text(
                "Enjoy New Offers",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160, left: 189.6),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 110, 110, 110)
                        .withOpacity(0.5), //color of shadow
                    spreadRadius: 1, //spread radius
                    blurRadius: 5, // blur radius
                    offset: const Offset(0, 0), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                  //you can set more BoxShadow() here
                ],
              ),
              child: const Text(
                "10% to 30% off",
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 8, 8, 8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
