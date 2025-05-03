import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:malabis_app/Screens/login_screen.dart';
import 'package:malabis_app/Screens/signup_screen.dart';
import 'package:malabis_app/Widgets/Social_Media_Button_Widget.dart';
import 'package:malabis_app/Widgets/button_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // ✅ Ensure keyboard is dismissed
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Log in or Sign up to continue",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Login Button
              Center(
                child: CustomButtonWidget(
                  text: "Login",
                  color: Colors.amber.shade700,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),

              // Sign Up Button
              Center(
                child: CustomButtonWidget(
                  text: "Sign Up",
                  textColor: Colors.amber.shade700,
                  borderColor: Colors.amber.shade700,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // OR Divider
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.black26)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("or", style: TextStyle(color: Colors.black54)),
                  ),
                  Expanded(child: Divider(color: Colors.black26)),
                ],
              ),
              const SizedBox(height: 20),

              // Social Login Buttons
              SocialLoginButton(
                icon: FontAwesomeIcons.apple,
                iconColor: Colors.black,
                text: "Continue With iCloud",
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                icon: FontAwesomeIcons.facebook,
                iconColor: Color(0xFF1877F2),
                text: "Continue With Facebook",
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                icon: FontAwesomeIcons.envelope,
                iconColor: Color(0xFFD93025),
                text: "Continue With E-mail",
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                icon: FontAwesomeIcons.google,
                iconColor: Color(0xFFD4285F4),
                text: "Continue With Google",
              ),
            ],
          ),
        ),
      ),
    );
  }
}