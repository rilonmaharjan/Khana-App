import 'package:flutter/material.dart';

import 'bottomnav.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Text('AB'),
              ),
              label: const Text('Aaron Burr'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Text('AB'),
              ),
              label: const Text('Aaron Burr'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Text('AB'),
              ),
              label: const Text('Aaron Burr'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Text('AB'),
              ),
              label: const Text('Aaron Burr'),
            ),
            const SizedBox(height:20),
            const Text("Change Password"),
            const SizedBox(height:20),
            ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Change Settings?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: const Text(
                      'This will change your app setting.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Cancel',
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
                          'OK',
                          style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 130, 137, 247)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Ok Done"),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 40),
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                  primary: const Color.fromARGB(255, 255, 255, 255),
                  onPrimary: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
