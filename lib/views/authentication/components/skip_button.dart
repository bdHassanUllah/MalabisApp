import 'package:flutter/material.dart';

class SkipBtn extends StatelessWidget {
  final VoidCallback onTap;
  const SkipBtn({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: const Text("Skip"),
        ),
      ],
    );
  }
}
