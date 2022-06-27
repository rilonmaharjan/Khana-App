import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khana/provider/google_sign_in.dart';
import 'package:khana/remote_config.dart';
import 'package:khana/view/forgot_password.dart';
import 'package:khana/view/register.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'bottomnav.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static RemoteConfigService remoteService = RemoteConfigService();
  //password visible invisible
  bool _obscureText = true;

  //email and password firebase
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Do you want to exit app?",
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 130, 137, 247)),
                        )),
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text(
                          "No",
                          style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 130, 137, 247)),
                        )),
                  ],
                ));
        return true;
      },
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (snapshot.hasData) {
            return FutureBuilder<FirebaseRemoteConfig>(
                future: remoteService.setRemoteConfig(),
                builder:
                    (context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
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
                              "Login",
                              style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                              child: const Text(
                                "Sign Up",
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
                          height: 65,
                        ),
                        Image.asset(
                          "assets/icon/l1.png",
                          height: 115,
                          width: 115,
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 50,
                            right: 50,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                cursorColor:
                                    const Color.fromARGB(255, 130, 137, 247),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    size: 19.5,
                                    color: Color.fromARGB(255, 167, 166, 166),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(37),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(37),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  labelText: 'Email address',
                                  labelStyle: const TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 167, 166, 166)),
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
                                obscureText: _obscureText,
                                cursorColor:
                                    const Color.fromARGB(255, 130, 137, 247),
                                controller: passwordController,
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
                                      color:
                                          Color.fromARGB(255, 167, 166, 166)),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    (value != null && value.isEmpty)
                                        ? 'Password must not be empty'
                                        : null,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassword(),
                                          ));
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 190, 189, 189)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                onPressed: logIn,
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
                                      "LOG IN",
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
                                    primary: const Color.fromARGB(
                                        255, 253, 253, 253),
                                    onPrimary:
                                        const Color.fromARGB(255, 53, 53, 53)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          "Login with",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 190, 189, 189)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider.googleLogin(context);
                              },
                              child: Image.asset(
                                "images/google.png",
                                height: 70,
                                width: 70,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Utils.showSnackBar(
                                    "Service denied at the moment", false);
                              },
                              child: Image.asset(
                                "images/twitter.png",
                                height: 60,
                                width: 60,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Utils.showSnackBar(
                                    "Service denied at the moment", false);
                              },
                              child: Image.asset(
                                "images/facebook.png",
                                height: 70,
                                width: 70,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

//logIn method for firebase
  Future logIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Utils.showSnackBar('Logged in successfully', true);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      Utils.showSnackBar(e.message, false);
    }

    //Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
