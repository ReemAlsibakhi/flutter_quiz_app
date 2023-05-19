import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  String text;
  MaterialColor color;
  // Color color;

  CircularImage(this.text, this.color, {super.key});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 20,
      child: Text(
        text,
        style: TextStyle(fontSize: 25, color: Colors.white),
      ), //Text
    );
  }
}
