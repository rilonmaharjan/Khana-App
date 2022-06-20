import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khana/remote_config.dart';
import 'package:khana/view/register.dart';
import 'package:path/path.dart';

import 'bottomnav.dart';

class Edit extends StatefulWidget {
  final String? editname, editphone;
  const Edit({Key? key, this.editname, this.editphone}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  static RemoteConfigService remoteService = RemoteConfigService();
  @override
  void initState() {
    _nameController.text = widget.editname!;
    _phoneController.text = widget.editphone!;
    super.initState();
  }

  File? file;
  User? user = FirebaseAuth.instance.currentUser;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black, size: 20),
          actionsIconTheme: const IconThemeData(color: Colors.black, size: 25),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 11),
              child: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  uploadFile(context);
                },
              ),
            ),
          ],
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.only(left: 12),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'Unsaved Changes',
                            style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          content: const Text(
                            'Are you sure you want to cancel?',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 130, 137, 247)),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  box.write("a", null);
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FutureBuilder<FirebaseRemoteConfig>(
                                              future: remoteService
                                                  .setRemoteConfig(),
                                              builder: (context,
                                                  AsyncSnapshot<
                                                          FirebaseRemoteConfig>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Scaffold(
                                                    body:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                if (snapshot.hasData) {
                                                  return BottomNav(
                                                    remoteConfigData:
                                                        snapshot.requireData,
                                                    index: 4,
                                                  );
                                                }
                                                return const Text("No text");
                                              }),
                                    ));
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 130, 137, 247)),
                              ),
                            ),
                          ],
                        ));
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
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
                  List<QueryDocumentSnapshot<Object?>> firestoreItems =
                      snapshot.data!.docs;
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 17,
                      ),
                      Center(
                        child: GestureDetector(
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
                                    titlePadding: const EdgeInsets.all(0),
                                    title: box.read("a") != null
                                        ? Image.file(
                                            box.read("a"),
                                            fit: BoxFit.cover,
                                          )
                                        : firestoreItems[0]['photo'] == ''
                                            ? Image.asset(
                                                "assets/icon/l2.png",
                                                fit: BoxFit.cover,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: firestoreItems[0]
                                                    ['photo'],
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                              maxRadius: 74,
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: box.read("a") != null
                                    ? Image.file(
                                        box.read("a"),
                                        height: 144,
                                        width: 144,
                                        fit: BoxFit.cover,
                                      )
                                    : firestoreItems[0]['photo'] == ''
                                        ? Image.asset(
                                            "assets/icon/l2.png",
                                            height: 105,
                                            width: 105,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: firestoreItems[0]
                                                ['photo'],
                                            height: 154,
                                            width: 154,
                                            fit: BoxFit.cover,
                                          ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10, top: 10),
                                    height: 160,
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              pickImage(ImageSource.gallery)
                                                  .then(
                                            (value) => Navigator.pop(context),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.image,
                                                color: Colors.black,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                "Upload Image from Gallery",
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              // fixedSize: const Size(295, 45),
                                              padding: const EdgeInsets.all(20),
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                              primary: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              onPrimary: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              pickImage(ImageSource.camera)
                                                  .then((value) =>
                                                      Navigator.pop(context)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.camera_alt,
                                                color: Colors.black,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                "Upload Image from Camera",
                                              ),
                                              SizedBox(
                                                width: 3.1,
                                              )
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(20),
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                              primary: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              onPrimary: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: const Text("Change Profile Photo"),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(37),
                            ),
                            fixedSize: const Size(220, 40),
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            primary: const Color.fromARGB(255, 255, 255, 255),
                            onPrimary: Colors.black),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 45,
                          right: 45,
                          top: 40,
                          bottom: 40,
                        ),
                        child: Form(
                          // key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 117, 117, 117)),
                                cursorColor:
                                    const Color.fromARGB(255, 130, 137, 247),
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                controller: _nameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person_rounded,
                                    size: 18,
                                    color: Color.fromARGB(255, 153, 153, 153),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(37),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  hintText: 'Enter your name',
                                  labelText: 'Name',
                                  labelStyle: const TextStyle(
                                      fontSize: 15.5,
                                      color:
                                          Color.fromARGB(255, 117, 117, 117)),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 117, 117, 117)),
                                cursorColor:
                                    const Color.fromARGB(255, 130, 137, 247),
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(37),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  prefixIcon: const Icon(
                                    Icons.phone_rounded,
                                    size: 18,
                                    color: Color.fromARGB(255, 153, 153, 153),
                                  ),
                                  hintText: 'Enter a phone number',
                                  labelText: 'Phone',
                                  labelStyle: const TextStyle(
                                      fontSize: 15.5,
                                      color:
                                          Color.fromARGB(255, 117, 117, 117)),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }
              }),
        ));
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState(() {
        file = File(image.path);
        box.write("a", file);
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to upload image: $e");
    }
  }

  Future uploadFile(context) async {
    String url;
    if (file == null) {
      // updates without changing image
      try {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
        DocumentReference documentReferencer =
            FirebaseFirestore.instance.collection('users').doc(user!.email);
        Map<String, dynamic> data = <String, dynamic>{
          'name': _nameController.text,
          'phoneNumber': _phoneController.text,
        };
        await documentReferencer
            .update(data)
            .then((value) => Navigator.pop(context))
            .then((value) => Navigator.pop(context))
            .then((value) =>
                Utils.showSnackBar("Profile updated successfully", true));
      } on FirebaseException catch (e) {
        Utils.showSnackBar(e.message, false);
      }
    } else {
      // updates all
      final fileName = basename(file!.path);
      final destination = 'images/$fileName';
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        final ref = FirebaseStorage.instance.ref(destination);
        UploadTask uploadTask = ref.putFile(File(file!.path));
        uploadTask.whenComplete(() async {
          url = await ref.getDownloadURL();

          DocumentReference documentReferencer =
              FirebaseFirestore.instance.collection('users').doc(user!.email);
          Map<String, dynamic> data = <String, dynamic>{
            'name': _nameController.text,
            'phoneNumber': _phoneController.text,
            'photo': url
          };
          await documentReferencer
              .update(data)
              .then((value) => Navigator.pop(context))
              .then((value) => Navigator.pop(context))
              .then((value) =>
                  Utils.showSnackBar("Profile updated successfully", true))
              .then((value) => setState((() => box.write('a', null))));
        });
      } on FirebaseException catch (e) {
        // ignore: avoid_print
        print(e);
        Utils.showSnackBar(e.message, false);
      }
    }
  }
}
