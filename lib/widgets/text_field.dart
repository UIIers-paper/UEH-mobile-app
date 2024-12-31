import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final Color color;
  final VoidCallback onButtonPressed;
  final TextInputType keyboardType;

  TextFieldWidget({
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.color,
    required this.onButtonPressed,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: color, size: 20),
                labelText: labelText,
                labelStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: onButtonPressed,
            icon: Icon(FontAwesomeIcons.link, size: 18, color: Colors.grey),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

