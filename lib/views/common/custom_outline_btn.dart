import 'package:flutter/material.dart';

import 'exports.dart';

class CustomOutlineBtn extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Function()? onPressed;
  final Color color;
  final Color? color2;
  final Color? textColor;
  const CustomOutlineBtn({super.key, this.width, this.height, required this.text, this.onPressed, required this.color, this.color2, this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          // borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color)
        ),
        child: Center(
          child: ReusableText(text: text, style: appstyle(16, textColor ?? color, FontWeight.w600)),
        ),
      ),
    );
  }
}