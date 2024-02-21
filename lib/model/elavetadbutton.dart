import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color color;
 final Color colors;
 final double width;
  const MyElevatedButton({
    required this.buttonText,
    required this.onPressed,
    required this.color,
    required this.colors, 
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
    primary: color,
  ),
        onPressed: onPressed,
        child: Text(buttonText,style: TextStyle(color: colors,fontSize: 20),),
      ),
    );
  }
}