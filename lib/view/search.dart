import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 18,
        ),
        title: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(
                width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
            left: BorderSide(
                width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
            right: BorderSide(
                width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
            bottom: BorderSide(
                width: 0.5, color: Color.fromARGB(255, 211, 210, 210)),
          )),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(),
        ),
      ),
    );
  }
}
