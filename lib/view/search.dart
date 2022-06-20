import 'package:flutter/material.dart';
import 'package:khana/view/tabview1.dart';
import 'package:khana/view/tabview2.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final nameHolder = TextEditingController();
  clearTextInput() {
    nameHolder.clear();
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 236, 236, 236),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 20),
              child: Text("Search Items"),
            ),
            titleTextStyle: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
            bottom: const TabBar(
                indicatorColor: Colors.green,
                unselectedLabelColor: Color.fromARGB(255, 138, 137, 137),
                tabs: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Restaurant",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Food Items",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                ]),
          ),
          body: const TabBarView(
            children: [
              TabViewOne(),
              TabViewTwo(),
            ],
          )),
    );
  }
}
