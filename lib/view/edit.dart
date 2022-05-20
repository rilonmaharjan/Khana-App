import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'bottomnav.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key, this.restorationId}) : super(key: key);
  final String? restorationId;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
//  class _EditState extends State<Edit> with RestorationMixin {
  // @override
  // String? get restorationId => widget.restorationId;

  // final RestorableDateTime _selectedDate =
  //     RestorableDateTime(DateTime(1991, 7, 25));
  // late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  //     RestorableRouteFuture<DateTime?>(
  //   onComplete: _selectDate,
  //   onPresent: (NavigatorState navigator, Object? arguments) {
  //     return navigator.restorablePush(
  //       _datePickerRoute,
  //       arguments: _selectedDate.value.millisecondsSinceEpoch,
  //     );
  //   },
  // );

  // static Route<DateTime> _datePickerRoute(
  //   BuildContext context,
  //   Object? arguments,
  // ) {
  //   return DialogRoute<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return DatePickerDialog(
  //         restorationId: 'date_picker_dialog',
  //         initialEntryMode: DatePickerEntryMode.calendarOnly,
  //         initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
  //         firstDate: DateTime(1900),
  //         lastDate: DateTime(2022),
  //       );
  //     },
  //   );
  // }

  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   registerForRestoration(_selectedDate, 'selected_date');
  //   registerForRestoration(
  //       _restorableDatePickerRouteFuture, 'date_picker_route_future');
  // }

  // void _selectDate(DateTime? newSelectedDate) {
  //   if (newSelectedDate != null) {
  //     setState(() {
  //       _selectedDate.value = newSelectedDate;
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(
  //             'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
  //       ));
  //     });
  //   }
  // }


  // ignore: prefer_typing_uninitialized_variables
  var imagePermanent;
  final box = GetStorage();

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      setState(() {
        imagePermanent = image.path;
        box.write("a", imagePermanent);
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to upload image: $e");
    }
  }



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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNav(
                              index: 2,
                            )));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BottomNav(
                                            index: 2,
                                          )));
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
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    maxRadius: 74,
                    backgroundColor: const Color.fromARGB(255, 130, 137, 247),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: box.read("a") != null
                          ? Image.file(
                              File(box.read("a")),
                              height: 144,
                              width: 144,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/icon/l1.png",
                              height: 144,
                              width: 144,
                              fit: BoxFit.cover,
                            ),
                    )),
              ],
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
                                    pickImage(ImageSource.gallery).then(
                                  (value) => Navigator.pop(context),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                onPressed: () => pickImage(ImageSource.camera)
                                    .then((value) => Navigator.pop(context)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: Colors.grey,
                      ),
                      child: TextFormField(
                        cursorColor: const Color.fromARGB(255, 130, 137, 247),
                        keyboardType: TextInputType.name,
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
                              borderSide: const BorderSide(color: Colors.grey)),
                          hintText: 'Enter your name',
                          labelText: 'Name',
                          labelStyle: const TextStyle(
                              fontSize: 15.5,
                              color: Color.fromARGB(255, 117, 117, 117)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 130, 137, 247),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(37),
                              borderSide: const BorderSide(color: Colors.grey)),
                        prefixIcon: const Icon(
                          Icons.phone_rounded,
                          size: 18,
                          color: Color.fromARGB(255, 153, 153, 153),
                        ),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone',
                        labelStyle: const TextStyle(
                            fontSize: 15.5,
                            color: Color.fromARGB(255, 117, 117, 117)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
                // ElevatedButton(
                //   onPressed: () {
                // //    _restorableDatePickerRouteFuture.present();
                //   },
                //   child: const Text("Save"),
                //   style: ElevatedButton.styleFrom(
                //     shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(37),
                //                 ),
                //       fixedSize: const Size(90, 40),
                //       textStyle: const TextStyle(
                //           fontSize: 15, fontWeight: FontWeight.w600),
                //       primary: const Color.fromARGB(255, 255, 255, 255),
                //       onPrimary: Colors.black),
                // ),
            
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
