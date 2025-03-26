import 'package:flutter/material.dart';

class AssetProvider extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  const AssetProvider({Key? key, required this.asset, this.height, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
