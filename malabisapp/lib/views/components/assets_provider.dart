import 'package:flutter/material.dart';

class AssetProvider extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  const AssetProvider({super.key, required this.asset, this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
