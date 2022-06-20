import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfigData;
  const Cart({Key? key, required this.remoteConfigData}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 25),
        actionsIconTheme: const IconThemeData(color: Colors.black, size: 28),
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: widget.remoteConfigData.getBool('leading'),
        title: Row(
          children: const [
            SizedBox(
              width: 8,
            ),
            Text(
              "My Basket",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.delete_outline_outlined,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          color: const Color.fromARGB(255, 244, 246, 252),
          height: MediaQuery.of(context).size.height - 147,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                jsonDecode(
                    widget.remoteConfigData.getString('cartView'))['image'],
                height: 150,
                width: 150,
              ),
              Text(
                jsonDecode(
                    widget.remoteConfigData.getString('cartView'))['text'],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(int.parse(jsonDecode(widget.remoteConfigData
                        .getString('cartView'))['color']))),
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                "Add food items to your Shopping Cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5,
                    fontSize: 15,
                    color: Color.fromARGB(255, 127, 129, 128)),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
