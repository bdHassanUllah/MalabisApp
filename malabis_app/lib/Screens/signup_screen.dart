import 'package:flutter/material.dart';
import 'package:malabis_app/Widgets/SignUpFunctions_widget.dart';
import 'package:malabis_app/Widgets/button_widgets.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignupFunctions _signupFunctions = SignupFunctions();
  bool _isChecked = false; // Checkbox state
  bool _isFormValid = false; // Form validation state
  bool _isSubmitting = false; // Submission state

  void _validateForm() {
    setState(() {
      _isFormValid = (_formKey.currentState?.validate() ?? false) && _isChecked;
    });
  }

  void _handleSignup() async {
  if (_isFormValid && !_isSubmitting) {
    setState(() => _isSubmitting = true);

    await _signupFunctions.handleSignup(_formKey, context); // Navigation handled inside

    setState(() => _isSubmitting = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Up Your Profile Screen")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            onChanged: _validateForm, // Revalidate form on input change
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
