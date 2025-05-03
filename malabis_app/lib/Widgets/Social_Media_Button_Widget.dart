import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Social Login Button Widget
class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;

  const SocialLoginButton({required this.icon, required this.iconColor,required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: FaIcon(icon, color: iconColor ?? Colors.black),
        label: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: const BorderSide(color: Colors.black26),
        ),
      ),
    );
  }
}
