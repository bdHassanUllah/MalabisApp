import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color; // Button background color
  final Color? borderColor; // Border color
  final Color? textColor; // Text color
  final IconData? icon; // Accept icon

  const CustomButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.borderColor,
    this.textColor,
    this.icon, // Default is null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon( // Using ElevatedButton.icon to support icons
        onPressed: onPressed,
        icon: icon != null ? FaIcon(icon, color: textColor ?? Colors.white) : const SizedBox(), // Show icon if provided
        label: Text(
          text,
          style: TextStyle(fontSize: 16, color: textColor ?? Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.white, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: borderColor ?? Colors.transparent, // Border color
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
