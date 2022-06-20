
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:khana/view/login.dart';

class Splash extends StatefulWidget {
  final FirebaseRemoteConfig remoteConfigData;
  const Splash({
    Key? key,
    required this.remoteConfigData,
  }) : super(key: key);

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
    await Future.delayed(const Duration(milliseconds: 2500), () {});
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
                height: MediaQuery.of(context).size.height / 3,
              ),
              Image.asset(
                "assets/icon/l1.png",
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.remoteConfigData.getString('welcome'),
                style: const TextStyle(
                    // fontSize: size,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
