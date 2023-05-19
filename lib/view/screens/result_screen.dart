import 'package:flutter/material.dart';

import '../base/custom_button.dart';

class ResultScreen extends StatelessWidget {
  String? status;
  String? image;
  String? score;
  String? text;
  ResultScreen(this.status, this.image, this.score, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          status!,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 30, color: Colors.teal),
        ),
        Image.asset(
          image!,
          scale: 1.9,
        ),
        Text(
          score!,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.teal),
        ),
        Text(
          text!,
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 17, color: Colors.black),
        ),
        CustomButton(
            title: 'Back to home', onPressed: () => {Navigator.pop(context)})
      ],
    );
  }
}
