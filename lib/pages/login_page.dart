// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:secura/components/text_field.dart';
import 'package:secura/pages/register_page.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onPressed;

  const LoginPage({super.key, required this.onPressed});

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [

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
                      'Welcome Back, User',
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
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 200,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
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
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600
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
        signIn();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      // color: Color(0xFF755DC1),
      color: Theme.of(context).colorScheme.onSecondary,
      minWidth: _deviceWidth! * 0.60,
      height: _deviceHeight! * 0.07,
      child:  Text(
        "Login",
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _registerButton() {
    return MaterialButton(
      onPressed: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => RegisterPage()));
          widget.onPressed!();
      },
      // color: Colors.blue,
      minWidth: _deviceWidth! * 0.05,
      height: _deviceHeight! * 0.08,
      child: Text(
        "Register here",
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  void signIn() {}
}
