import 'package:flutter/material.dart';
import 'package:khana/view/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(
                height: MediaQuery.of(context).size.height/3,
              ),
              Image.asset(
                "assets/icon/l1.png",
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Khana Ghar",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
