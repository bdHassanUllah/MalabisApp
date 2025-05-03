
import 'package:flutter/material.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/util/config/asset_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //Set duration for splash screen 
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, welcomescreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Get screen size
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        /*decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black, BlendMode.dstATop),
            fit: BoxFit.fill,
            image: const AssetImage(AssetConfig.kSplashLogo),
          ),
        ),*/
        child: Center(
          child: Image.asset(AssetConfig.kSignUpPageImage),
        ),
      ),
    );
  }
}