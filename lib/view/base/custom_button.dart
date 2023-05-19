import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.title, required this.onPressed});

  String title;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        padding: const EdgeInsets.only(top: 14, bottom: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.teal),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
