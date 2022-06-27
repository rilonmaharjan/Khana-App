import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:khana/remote_config.dart';
import 'package:khana/view/foods.dart';
import 'package:khana/view/khana.dart';
import 'package:khana/view/profile.dart';
import 'package:khana/view/search.dart';

import 'cart.dart';

class BottomNav extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfigData;
  const BottomNav(
      {Key? key, required this.index, required this.remoteConfigData})
      : super(key: key);
  final int index;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static RemoteConfigService remoteService = RemoteConfigService();
  List pages = [


    //Khana
    FutureBuilder<FirebaseRemoteConfig>(
        future: remoteService.setRemoteConfig(),
        builder: (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.hasData) {
            return Khana(remoteConfigData: snapshot.requireData);
          }
          return const Text("No text");
        }),


    //Search
    const SearchView(),


    //Food
    FutureBuilder<FirebaseRemoteConfig>(
        future: remoteService.setRemoteConfig(),
        builder: (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.hasData) {
            return Food(remoteConfigData: snapshot.requireData);
          }
          return const Text("No text");
        }),


    //Cart
    FutureBuilder<FirebaseRemoteConfig>(
        future: remoteService.setRemoteConfig(),
        builder: (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.hasData) {
            return Cart(remoteConfigData: snapshot.requireData);
          }
          return const Text("No text");
        }),


    //Profile
    FutureBuilder<FirebaseRemoteConfig>(
        future: remoteService.setRemoteConfig(),
        builder: (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.hasData) {
            return Profile(remoteConfigData: snapshot.requireData);
          }
          return const Text("No text");
        }),
  ];

  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  _handleTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int get navcolor => int.parse(jsonDecode(
      widget.remoteConfigData.getString('khanaView'))['bottomNavColor']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      //BottomNavigation Bar
      bottomNavigationBar: BottomNavigationBar(
        onTap: _handleTap,
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color.fromARGB(255, 90, 90, 90),
        selectedItemColor: Color(navcolor),
        // 8289F7
        iconSize: 26,
        unselectedFontSize: 13,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cookie_outlined,
            ),
            label: 'Foods',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: 'Basket'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
