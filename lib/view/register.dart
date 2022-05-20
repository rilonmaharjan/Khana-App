import 'package:flutter/material.dart';
import 'package:khana/view/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
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
                  bottom: 40,
                ),
                child: Form(
                  // key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.grey,
                        ),
                        child: TextFormField(
                          cursorColor: const Color.fromARGB(255, 130, 137, 247),
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
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
                                color: Color.fromARGB(255, 167, 166, 166)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: const Color.fromARGB(255, 130, 137, 247),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(37),
                              borderSide: const BorderSide(color: Colors.grey)),
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        cursorColor: const Color.fromARGB(255, 130, 137, 247),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(37),
                              borderSide: const BorderSide(color: Colors.grey)),
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
                        textInputAction: TextInputAction.next,
                        cursorColor: const Color.fromARGB(255, 130, 137, 247),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(37),
                              borderSide: const BorderSide(color: Colors.grey)),
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
                              color: const Color.fromARGB(255, 167, 166, 166),
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 167, 166, 166)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: _obscureText2,
                        cursorColor: const Color.fromARGB(255, 130, 137, 247),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(37),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(37),
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
                          labelText: 'Repeat Password',
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 167, 166, 166)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
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
                        fontSize: 18, fontWeight: FontWeight.w700),
                    primary: const Color.fromARGB(255, 253, 253, 253),
                    onPrimary: const Color.fromARGB(255, 53, 53, 53)),
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
