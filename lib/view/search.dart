import 'package:flutter/material.dart';
import 'package:khana/view/tabView1.dart';
import 'package:khana/view/tabView2.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final nameHolder = TextEditingController();
  clearTextInput() {
    nameHolder.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 21,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: const Border(
                    top: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                    left: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                    right: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                    bottom: BorderSide(
                        width: 1, color: Color.fromARGB(255, 124, 123, 123)),
                  )),
              child: Center(
                child: TextField(
                  controller: nameHolder,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color.fromARGB(186, 244, 67, 54),
                        ),
                        onPressed: clearTextInput,
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            ),
            bottom: const TabBar(
                indicatorColor: Colors.green,
                unselectedLabelColor: Colors.grey,
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
