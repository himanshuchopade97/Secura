// ignore_for_file: no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double? _deviceHeight, _deviceWidth;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: _deviceWidth * 0.87,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Theme.of(context)
              .colorScheme
              .onTertiary, // Change the text color here
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.onTertiary),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.onTertiary),
          ),
          fillColor: Colors.grey.shade300,
          filled: true,
          label: Text(hintText),
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
