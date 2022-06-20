
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khana/main.dart';
import 'package:khana/view/login.dart';
import 'package:khana/view/register.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  var newPassword = "";

  final oldEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Change Password",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Set a good password ",
                    style: TextStyle(fontSize: 16),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   controller: oldEmailController,
                  //   keyboardType: TextInputType.emailAddress,
                  //   cursorColor: const Color.fromARGB(255, 130, 137, 247),
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //         borderSide: const BorderSide(color: Colors.grey)),
                  //     prefixIcon: const Icon(
                  //       Icons.email,
                  //       size: 19.5,
                  //       color: Color.fromARGB(255, 167, 166, 166),
                  //     ),
                  //     labelText: 'Email',
                  //     labelStyle: const TextStyle(
                  //         fontSize: 18,
                  //         color: Color.fromARGB(255, 167, 166, 166)),
                  //   ),
                  //   autovalidateMode:
                  //                   AutovalidateMode.onUserInteraction,
                  //               validator: (email) => email != null &&
                  //                       !EmailValidator.validate(email)
                  //                   ? 'Enter a valid email'
                  //                   : null,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _obscureText2,
                    controller: newPasswordController,
                    cursorColor: const Color.fromARGB(255, 130, 137, 247),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey)),
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
                          color: const Color.fromARGB(255, 167, 166, 166),
                        ),
                      ),
                      labelText: 'New Password',
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 167, 166, 166)),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => (value != null && value.length < 6)
                        ? 'Password must be more than 6 characters'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      obscureText: _obscureText3,
                      controller: confirmPasswordController,
                      cursorColor: const Color.fromARGB(255, 130, 137, 247),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey)),
                        prefixIcon: const Icon(
                          Icons.security,
                          size: 19.5,
                          color: Color.fromARGB(255, 167, 166, 166),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: (() {
                            setState(() {
                              _obscureText3 = !_obscureText3;
                            });
                          }),
                          child: Icon(
                            _obscureText3
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 23,
                            color: const Color.fromARGB(255, 167, 166, 166),
                          ),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 167, 166, 166)),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          (value != newPasswordController.text)
                              ? ' Password do not match'
                              : null),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: changePassword,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.change_circle_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Change Password",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        fixedSize: const Size(200, 40),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                        primary: const Color.fromARGB(255, 253, 253, 253),
                        onPrimary: const Color.fromARGB(255, 53, 53, 53)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future changePassword() async {
    final isValid = formKey.currentState!.validate() ;
    if (!isValid) {
      return Utils.showSnackBar(
          'An error occured', false);
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    setState(() {
      newPassword = confirmPasswordController.text.trim();
    });

    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ));
      Utils.showSnackBar(
          'Your password has been changed .. Login again !', true);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      Utils.showSnackBar(e.message, false);
      Navigator.of(context).pop();
      navigatorKey.currentState!.popUntil((route) => route.isActive);
    }
  }
}
