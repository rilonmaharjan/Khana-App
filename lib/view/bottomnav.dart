import 'package:flutter/material.dart';
import 'package:khana/view/foods.dart';
import 'package:khana/view/khana.dart';
import 'package:khana/view/profile.dart';

class BottomNav extends StatefulWidget {

  const BottomNav({ Key? key ,required this.index}) : super(key: key);
  final int index;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {


  int _selectedIndex = 0;
  List pages = [
    const Khana(),
    const Food(),
    const Profile(),
  ];
  
  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  _handleTap(index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[_selectedIndex],
      //BottomNavigation Bar
      bottomNavigationBar: BottomNavigationBar( 

        onTap: _handleTap,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 130, 137, 247),
        iconSize: 29,
        unselectedFontSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.cookie_outlined,
              ),
              label: 'Foods',),
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