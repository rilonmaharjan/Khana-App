// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khana/list/list.dart';
import 'package:khana/provider/google_sign_in.dart';
import 'package:khana/remote_config.dart';
import 'package:khana/view/edit.dart';
import 'package:khana/view/settings.dart';
import 'package:provider/provider.dart';

// import 'package:khana/view/khana.dart';

enum popupBtn { settings, logout }

class Profile extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfigData;
  const Profile({Key? key, required this.remoteConfigData}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static RemoteConfigService remoteService = RemoteConfigService();
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                                  builder: (context) => const SettingPage()));
                          break;

                        case popupBtn.logout:
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogout();
                          FirebaseAuth.instance.signOut();
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 30,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: const Center(
                    child: Icon(
                      Icons.drag_handle,
                      color: Color.fromARGB(255, 173, 173, 173),
                    ),
                  )),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 680.0,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 22,
                    right: 22,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .where('email', isEqualTo: user!.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Text(
                                'No User Data...',
                              );
                            } else {
                              List<QueryDocumentSnapshot<Object?>>
                                  firestoreItems = snapshot.data!.docs;
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: InteractiveViewer(
                                                child: AlertDialog(
                                                  titlePadding:
                                                      const EdgeInsets.all(0),
                                                  title: firestoreItems[index]
                                                              ['photo'] !=
                                                          ""
                                                      ? CachedNetworkImage(
                                                          imageUrl:
                                                              firestoreItems[
                                                                      index]
                                                                  ['photo'],
                                                          fit: BoxFit.cover,
                                                        )
                                                      //NetworkImage(user.photoURL!),
                                                      : Image.asset(
                                                          "assets/icon/l2.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 53,
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: firestoreItems[index]
                                                        ['photo'] !=
                                                    ""
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        firestoreItems[index]
                                                            ['photo'],
                                                    height: 104,
                                                    width: 104,
                                                    fit: BoxFit.cover,
                                                  )
                                                //NetworkImage(user.photoURL!),
                                                : Image.asset(
                                                    "assets/icon/l2.png",
                                                    height: 105,
                                                    width: 105,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 22,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.9,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                firestoreItems[index]['name'],
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 68, 67, 67)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                firestoreItems[index]['email'],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromARGB(
                                                        255, 95, 95, 95)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            Text(
                                              firestoreItems[index]
                                                  ['phoneNumber'],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 100, 100, 100)),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Edit(
                                                      editname:
                                                          firestoreItems[index]
                                                              ['name'],
                                                      editphone:
                                                          firestoreItems[index]
                                                              ['phoneNumber'],
                                                    )));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          fixedSize: const Size(150, 40),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                          primary: const Color.fromARGB(
                                              255, 253, 253, 253),
                                          onPrimary: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        indent: 0,
                        endIndent: 0,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.remoteConfigData.getString('audience'),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
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
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          padding: const EdgeInsets.only(top: 10, bottom: 0),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                          crossAxisCount: 3,
                          children: List.generate(9, (index) => Grid(
                            img: data2[index]['url'],
                            txt:data2[index]['name'] ,
                            txt1:data2[index]['text'] ,
                          ))
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
  const Grid({Key? key, this.img, this.txt, this.txt1}) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                widget.txt,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
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
    ]);
  }
}



