import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final url;
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final desc;

  const Order(
      {Key? key, required this.url, required this.desc, required this.title})
      : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int quantity = 1;

  // ignore: prefer_typing_uninitialized_variables
  var total;

  @override
  void initState() {
   // total = 200;
   total=int.parse(widget.desc);
    setState(() {});
    super.initState();
  }

  increase() {
    setState(() {
      if (quantity >= 20) {
        quantity;
      } else {
        quantity++;
        //total = total + widget.desc;
        total = total + int.parse(widget.desc);
      }
    });
  }

  decrease() {
    setState(() {
      if (quantity <= 1) {
        quantity;
      } else {
        --quantity;
        //total = total - widget.desc;
        total = total - int.parse(widget.desc);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 25),
        actionsIconTheme: const IconThemeData(color: Colors.black, size: 28),
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            SizedBox(
              width: 5,
            ),
            Text(
              "Order",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 11),
            child: IconButton(
              icon: const Icon(
                Icons.clear,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.asset(
                          widget.url,
                          height: 220,
                          width: MediaQuery.of(context).size.width - 60,
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
                const SizedBox(height: 23),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text("Rs.",
                      style:  TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),),
                          const SizedBox(width: 5,),
                    Text(
                      total.toString(),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  indent: 1,
                  endIndent: 1,
                  thickness: 0.5,
                  color: Color.fromARGB(255, 201, 198, 198),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: decrease,
                      child: const Text("-"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(30, 30),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          primary: const Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: increase,
                      child: const Text("+"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(30, 30),
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          primary: const Color.fromARGB(255, 255, 255, 255),
                          onPrimary: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shop,
                        size: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Buy Now",
                        style: TextStyle(fontSize: 16.5),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(30, 40),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                      primary: const Color.fromARGB(255, 255, 255, 255),
                      onPrimary: Colors.black),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Text(
                      "Deliver To",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      size: 16,
                      color: Color.fromARGB(176, 244, 67, 54),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Edit Location",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(176, 244, 67, 54),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 2,
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: MediaQuery.of(context).size.height / 11,
                  margin: const EdgeInsets.only(top: 15, bottom: 25),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border(
                        top: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 211, 210, 210)),
                        left: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 211, 210, 210)),
                        right: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 211, 210, 210)),
                        bottom: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 211, 210, 210)),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Location, Location",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Receipt",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "Sub Total",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "(With VAT):",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                    const Text("Rs."),
                          const SizedBox(width: 5,),
                        Text(total.toString()),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text(
                      "Deliver Fee:",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Text("Rs. 100"),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  indent: 0,
                  endIndent: 0,
                  thickness: 1,
                  color: Color.fromARGB(255, 201, 198, 198),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Total:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text("Rs. ${100 + total}", style: const TextStyle(fontWeight: FontWeight.w600),),
                  ],
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
