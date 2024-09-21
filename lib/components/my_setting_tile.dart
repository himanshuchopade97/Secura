import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySettingTile extends StatelessWidget {
  final String title;
  final Widget action;

  const MySettingTile({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),

      //padding ouotside
      margin: EdgeInsets.only(left: 25, right: 25, top: 10),

      //padding inside
      padding: EdgeInsets.all(15),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          action,
        ],
      ),
    );
  }
}
