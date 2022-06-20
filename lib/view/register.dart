import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:khana/remote_config.dart';

import '../main.dart';
import 'bottomnav.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static RemoteConfigService remoteService = RemoteConfigService();
  bool _obscureText = true;
  bool _obscureText2 = true;
  String diffrentPassword = "";

  //email and password firebase
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstPassword = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else if (snapshot.hasData) {
          return FutureBuilder<FirebaseRemoteConfig>(
              future: remoteService.setRemoteConfig(),
              builder: (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return BottomNav(
                    remoteConfigData: snapshot.requireData,
                    index: 0,
                  );
                }
                return const Text("No text");
              });
        } else {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 35,
                          ),
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 46,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 172, 171, 171)),
                            ),
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Image.asset(
                        "assets/icon/l1.png",
                        height: 105,
                        width: 105,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: Colors.grey,
                              ),
                              child: TextFormField(
                                cursorColor:
                                    const Color.fromARGB(255, 130, 137, 247),
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(37),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Color.fromARGB(255, 167, 166, 166),
                                  ),
                                  labelText: 'Full Name',
                                  labelStyle: const TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 167, 166, 166)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              cursorColor:
                                  const Color.fromARGB(255, 130, 137, 247),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  size: 19.5,
                                  color: Color.fromARGB(255, 167, 166, 166),
                                ),
                                labelText: 'Email address',
                                labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 167, 166, 166)),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              controller: phoneController,
                              cursorColor:
                                  const Color.fromARGB(255, 130, 137, 247),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  size: 19.5,
                                  color: Color.fromARGB(255, 167, 166, 166),
                                ),
                                labelText: 'Phone',
                                labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 167, 166, 166)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: _obscureText,
                              controller: firstPassword,
                              textInputAction: TextInputAction.next,
                              cursorColor:
                                  const Color.fromARGB(255, 130, 137, 247),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                prefixIcon: const Icon(
                                  Icons.security,
                                  size: 19.5,
                                  color: Color.fromARGB(255, 167, 166, 166),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  }),
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 23,
                                    color: const Color.fromARGB(
                                        255, 167, 166, 166),
                                  ),
                                ),
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 167, 166, 166)),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => (value != null &&
                                      value.length < 6)
                                  ? 'Password must be more than 6 characters'
                                  : null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                obscureText: _obscureText2,
                                controller: passwordController,
                                cursorColor:
                                    const Color.fromARGB(255, 130, 137, 247),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(37),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  prefixIcon: const Icon(
                                    Icons.security,
                                    size: 19.5,
                                    color: Color.fromARGB(255, 167, 166, 166),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _obscureText2 = !_obscureText2;
                                      });
                                    }),
                                    child: Icon(
                                      _obscureText2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 23,
                                      color: const Color.fromARGB(
                                          255, 167, 166, 166),
                                    ),
                                  ),
                                  labelText: 'Repeat Password',
                                  labelStyle: const TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 167, 166, 166)),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    (value != firstPassword.text)
                                        ? ' Password do not match'
                                        : null),
                            const SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              onPressed: register,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.check,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "SIGN UP",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fixedSize: const Size(285, 50),
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                  primary:
                                      const Color.fromARGB(255, 253, 253, 253),
                                  onPrimary:
                                      const Color.fromARGB(255, 53, 53, 53)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Terms of Service",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 190, 189, 189)),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future register() async {
    // ignore: unused_local_variable
    User? user = FirebaseAuth.instance.currentUser;
    // var phoneNumber = phoneController.text.trim();

    // ignore: unrelated_type_equality_checks
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim(),
      );

      //uploads auth in firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(emailController.text.trim().toLowerCase())
          .set({
        'email': emailController.text.trim().toLowerCase(),
        'password': passwordController.text.trim(),
        'name': nameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'photo': '',
      });

      Utils.showSnackBar('Registered successfully', true);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      // email already used
      Utils.showSnackBar(e.message, false);
      Navigator.of(context).pop();
      navigatorKey.currentState!.popUntil((route) => route.isActive);
    }
  }
}

//email already used sncakbar
class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text, status) {
    if (text == null) return;

    final snackBarError = SnackBar(
      content: Text(text),
      backgroundColor: const Color.fromARGB(199, 244, 67, 54),
    );

    final snackBarSuccess = SnackBar(
      content: Text(text),
      backgroundColor: const Color.fromARGB(186, 76, 175, 79),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(status == true ? snackBarSuccess : snackBarError);
  }
}
