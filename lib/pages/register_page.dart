// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:secura/components/text_field.dart';
// import 'package:secura/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _confirmpwdcontroller = TextEditingController();
  

  @override
  void dispose() {
    _emailcontroller.dispose();
    _pwdcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // SizedBox.expand(
          //   child: Image.asset(
          //     'assets/images/light_blue_cloudy_bg.jpeg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 50,
              ),
              //logo
              Center(
                child: Icon(
                  Icons.message,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //welcome back
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Text(
                      "Register with us",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 27,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //email text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MyTextField(
                      controller: _emailcontroller,
                      hintText: "Email",
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),

                  //pwd text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MyTextField(
                      controller: _pwdcontroller,
                      hintText: "Password",
                      obscureText: true,
                    ),
                  ),
                  //login in button

                  const SizedBox(
                    height: 18,
                  ),

                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: MyTextField(
                      controller: _confirmpwdcontroller,
                      hintText: "Confirm Password",
                      obscureText: true,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  Center(child: _loginButton()),
                  //not a member
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Already a Member?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        _registerButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: () {
        signUp();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      // color: Color(0xFF755DC1),
      color:  Theme.of(context).colorScheme.onSecondary,
      minWidth: _deviceWidth! * 0.60,
      height: _deviceHeight! * 0.07,
      child:  Text(
        "Register",
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _registerButton() {
    return MaterialButton(
      onPressed: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        Navigator.pop(context);
      },
      // color: Colors.blue,
      minWidth: _deviceWidth! * 0.05,
      height: _deviceHeight! * 0.08,
      child:  Text(
        "Login Now",
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 15,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  void signUp() {}
}
