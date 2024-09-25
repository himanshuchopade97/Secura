import 'package:flutter/material.dart';

/*
  simple box with text inside. used to display bio on profile pages'
 */

class MyBioBox extends StatelessWidget {
  final String text;

  const MyBioBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(

      //padding outside
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),

      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(25),
      child: Text(
        text.isNotEmpty ? text : "Empty bio...",
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
