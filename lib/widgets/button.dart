import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final ButtonTapped;
  final doubleTap;

  const MyButton({super.key, this.color, this.textColor, required this.buttonText, this.ButtonTapped, this.doubleTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ButtonTapped,
      onDoubleTap:doubleTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(child: Text(buttonText,style: TextStyle(color: textColor,fontSize: 21),),),
          ),
        ),
      ),
    );
  }
}
