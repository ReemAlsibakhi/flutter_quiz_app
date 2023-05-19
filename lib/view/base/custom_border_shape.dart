import 'package:flutter/material.dart';

class BorderShape extends StatelessWidget {
  final Widget widget;
  final Color valColor;
  final Function()? onTap;
  String? from;
  BorderShape(
      {Key? key,
      required this.widget,
      required this.valColor,
      this.onTap,
      this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: valColor,
          border: from != "1"
              ? Border.all(color: Colors.teal, width: 1)
              : Border.all(color: valColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: widget,
      ),
    );
  }
}
