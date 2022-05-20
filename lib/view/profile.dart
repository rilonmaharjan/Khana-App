// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khana/list/list.dart';
import 'package:khana/view/edit.dart';
import 'package:khana/view/login.dart';
import 'package:khana/view/settings.dart';

import 'order.dart';

// import 'package:khana/view/khana.dart';

enum popupBtn { settings, logout }

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 238, 239, 233),
            iconTheme: const IconThemeData(color: Colors.black),
            expandedHeight: 280.0,
            floating: true,
            title: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            actions: [
              Row(
                children: [
                  PopupMenuButton<popupBtn>(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            Icon(Icons.settings),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        value: popupBtn.settings,
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.logout,
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        value: popupBtn.logout,
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case popupBtn.settings:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Settings()));
                          break;

                        case popupBtn.logout:
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text(
                                      'Do you want to Log Out?',
                                      style: TextStyle(
                                        fontSize: 16.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    content: const Text(
                                      'This will log you out.',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 130, 137, 247)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login()));
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 130, 137, 247)),
                                        ),
                                      ),
                                    ],
                                  ));
                          break;
                        default:
                      }
                    },
                  ),
                  const SizedBox(
                    width: 3,
                  )
                ],
              ),
            ],
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "images/sliver.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 687.0,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 22,
                    right: 22,
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 212, 210, 210),
                            offset: Offset(5, 5),
                            blurRadius: 20)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.drag_handle,
                            color: Color.fromARGB(255, 173, 173, 173),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 53,
                            backgroundColor:
                                const Color.fromARGB(255, 130, 137, 247),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: box.read("a") != null
                                  ? Image.file(
                                      File(box.read("a")),
                                      height: 104,
                                      width: 104,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/icon/l1.png",
                                      height: 95,
                                      width: 95,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Anik Shakya",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 68, 67, 67)),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                "aniklinkin@gmail.com",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 95, 95, 95)),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                "9861333456",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 100, 100, 100)),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Edit()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.edit,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                                primary:
                                    const Color.fromARGB(255, 253, 253, 253),
                                onPrimary: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        indent: 0,
                        endIndent: 0,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Favorites",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.favorite,
                            size: 21,
                            color: Color.fromARGB(255, 243, 143, 136),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.only(top: 10, bottom: 0),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                          crossAxisCount: 3,
                          children: <Widget>[
                            Grid(
                              img: data2[0]["url"],
                              txt: data2[0]["name"],
                              txt1: data2[0]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[0]["url"].toString(),
                                              desc:
                                                  data2[0]["rs"].toString(),
                                              title: list[0]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[1]["url"],
                              txt: data2[1]["name"],
                              txt1: data2[1]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[1]["url"].toString(),
                                              desc:
                                                  data2[1]["rs"].toString(),
                                              title:
                                                  data2[1]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[3]["url"],
                              txt: data2[3]["name"],
                              txt1: data2[3]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[3]["url"].toString(),
                                              desc:
                                                  data2[3]["rs"].toString(),
                                              title:
                                                  data2[3]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[4]["url"],
                              txt: data2[4]["name"],
                              txt1: data2[4]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[4]["url"].toString(),
                                              desc:
                                                  data2[4]["rs"].toString(),
                                              title:
                                                  data2[4]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[5]["url"],
                              txt: data2[5]["name"],
                              txt1: data2[5]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[5]["url"].toString(),
                                              desc:
                                                  data2[5]["rs"].toString(),
                                              title:
                                                  data2[5]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[6]["url"],
                              txt: data2[6]["name"],
                              txt1: data2[6]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[6]["url"].toString(),
                                              desc:
                                                  data2[6]["rs"].toString(),
                                              title:
                                                  data2[6]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[7]["url"],
                              txt: data2[7]["name"],
                              txt1: data2[7]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[7]["url"].toString(),
                                              desc:
                                                  data2[7]["rs"].toString(),
                                              title:
                                                  data2[7]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[8]["url"],
                              txt: data2[8]["name"],
                              txt1: data2[8]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[8]["url"].toString(),
                                              desc:
                                                  data2[8]["rs"].toString(),
                                              title:
                                                  data2[8]["name"].toString(),
                                            ))));
                              },
                            ),
                            Grid(
                              img: data2[9]["url"],
                              txt: data2[9]["name"],
                              txt1: data2[9]["text"],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Order(
                                              url: data2[9]["url"].toString(),
                                              desc:
                                                  data2[9]["rs"].toString(),
                                              title:
                                                  data2[9]["name"].toString(),
                                            ))));
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class Grid extends StatefulWidget {
  final img, txt, txt1;
  final VoidCallback onTap;
  const Grid({Key? key, this.img, this.txt, this.txt1, required this.onTap})
      : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Image.asset(
              widget.img,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            )),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(103, 0, 0, 0),
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              Text(
                widget.txt,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.txt1,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
