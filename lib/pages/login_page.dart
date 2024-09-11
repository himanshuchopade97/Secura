// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:secura/components/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

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
          SizedBox.expand(
            child: Image.asset(
              'assets/images/light_blue_cloudy_bg.jpeg',
              fit: BoxFit.cover,
            ),
          ),
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
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.blue[700],
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
                          "Not a Member?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue[700],
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
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      // color: Color(0xFF755DC1),
      color:  Colors.blue[700],
      minWidth: _deviceWidth! * 0.60,
      height: _deviceHeight! * 0.07,
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _registerButton() {
    return MaterialButton(
      onPressed: () {},
      // color: Colors.blue,
      minWidth: _deviceWidth! * 0.05,
      height: _deviceHeight! * 0.08,
      child:  Text(
        "Register here",
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: 15,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
