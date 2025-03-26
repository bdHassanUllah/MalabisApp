/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:malabis_app/logic/cubit/authentication_cubit.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/util/config/asset_config.dart';
import 'package:malabis_app/views/authentication/components/Skip_button.dart';
import 'package:malabis_app/views/components/assets_provider.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:kIsWeb ? CrossAxisAlignment.center: CrossAxisAlignment.start,
                    children: [
                      SkipBtn(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, bottomNavBar, (route) => false),
                      ),
                      const Center(
                        child: AssetProvider(
                          asset: AssetConfig.kSignUpPageImage,
                          height: 250,
                          width: 250,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xffFE8086),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Phone",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: kIsWeb ? 500 : double.infinity,
                        child: Form(
                          key: key,
                          child: Column(
                            // crossAxisAlignment: kIsWeb ? CrossAxisAlignment.center: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Phone is required";
                                  }
                                  return null;
                                },
                                onChanged: (val) => context
                                    .read<AuthenticationCubit>()
                                    .phoneNumber(val),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xffE4F9E8),
                                      width: 2,
                                    ),
                                  ),
                                  focusColor: const Color(0xffE4F9E8),
                                  // border: InputBorder.none,
                                  fillColor: const Color(0xffE4F9E8),
                                  filled: true,
                                  hintText: "Enter your Phone Number",
                                  prefixIcon: const Icon(
                                    Icons.phone_android,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minWidth: double.infinity,
                                color: const Color(0xffFE8086),
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    context
                                        .read<AuthenticationCubit>()
                                        .registerPhone();
                                    Navigator.pushNamed(context, verifyEmail);
                                  }
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: kIsWeb ? 500 : double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.black,
                            ),
                            const Text("Or login with"),
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: kIsWeb ? 500 : double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                AssetConfig.kGoogleLogo,
                                height: 20,
                              ),
                              const Text("Google"),
                              Container(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:malabis_app/Screens/login_screen.dart';
import 'package:malabis_app/Screens/signup_screen.dart';
import 'package:malabis_app/Widgets/Social_Media_Button_Widget.dart';
import 'package:malabis_app/Widgets/button_widgets.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/util/config/asset_config.dart';

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
                      MaterialPageRoute(builder: (context) => signUp()),
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
              SizedBox(
                        width: kIsWeb ? 500 : double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                AssetConfig.kGoogleLogo,
                                height: 20,
                              ),
                              const Text("Google"),
                              Container(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false; // Checkbox state
  bool _isFormValid = false; // Form validation state
  bool _isSubmitting = false; // Submission state

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Up Your Profile Screen")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            onChanged: verifyEmail, // Revalidate form on input change
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create an account so you can manage your donation even faster",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                _signupFunctions.buildTextField(
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: _signupFunctions.validateEmail,
                ),
                const SizedBox(height: 16),

                _signupFunctions.buildTextField(
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: _signupFunctions.validatePhoneNumber,
                ),
                const SizedBox(height: 16),

                _signupFunctions.buildPasswordField(
                  label: "Password",
                  controller: _signupFunctions.passwordController,
                  setStateCallback: setState, 
                ),

                const SizedBox(height: 16),

                _signupFunctions.buildPasswordField(
                  label: "Confirm Password",
                  controller: _signupFunctions.confirmPasswordController,
                  validateConfirmPassword: true,
                  setStateCallback: setState,
                ),


                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "By signing in, you agree to our Privacy Policy, which explains how we collect, use, and protect your data.",
                  ),
                ),

                // Checkbox for Privacy Policy Agreement
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                          _validateForm(); // Recheck form validity
                        });
                      },
                    ),
                    const Text(
                      "I agree to the Privacy Policy",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                CustomButtonWidget(
                  text: _isSubmitting ? "Creating Account..." : "Create an account",
                  color: (_isFormValid && !_isSubmitting) ? Colors.amber.shade700 : Colors.grey,
                  onPressed: (_isFormValid && !_isSubmitting) ? _handleSignup : () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}