import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  TextEditingController controller;
  String name;
  Color color;
   textfield({super.key,required this.controller,required this.name,required this.color});

  @override
  Widget build(BuildContext context) {
    
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          
          controller:controller ,
          decoration: InputDecoration(
          
            fillColor: Colors.white,
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0)
            ),
            labelText: name,
        
          ),
        ),
      );
    
  }
}