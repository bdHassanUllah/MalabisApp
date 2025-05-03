import 'package:flutter/material.dart';
import 'package:malabis_app/Screens/login_screen.dart';

class SignupFunctions {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String passwordStrength = ""; // Track password strength

   // Function to build TextFormFields
  Widget buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      keyboardType: keyboardType,
      validator: validator ?? (value) => value!.isEmpty ? "$label is required" : null,
    );
  }

  // Email Validation
  String? validateEmail(String? value) {
    if (value!.isEmpty) return "Email is required";
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  // Phone Number Validation
  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) return "Phone number is required";
    final phoneRegex = RegExp(r"^\d{10,15}$");
    if (!phoneRegex.hasMatch(value)) return "Enter a valid phone number";
    return null;
  }

  // Function to build Password Fields with strength indicator
Widget buildPasswordField({
  required String label,
  required TextEditingController controller,
  required Function(void Function()) setStateCallback,
  bool validateConfirmPassword = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      StatefulBuilder(
        builder: (context, setState) {
          return TextFormField(
            controller: controller,
            obscureText: label == "Password" ? obscurePassword : obscureConfirmPassword,
            onChanged: (value) {
              setState(() {}); // Update local UI
              setStateCallback(() {}); // Trigger UI update in the parent widget
            },
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              suffixIcon: IconButton(
                icon: Icon(
                  (label == "Password" ? obscurePassword : obscureConfirmPassword)
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    if (label == "Password") {
                      obscurePassword = !obscurePassword;
                    } else {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    }
                  });
                },
              ),
            ),
            validator: validateConfirmPassword
                ? (value) {
                    if (value!.isEmpty) return "Confirm Password is required";
                    if (value != passwordController.text) return "Passwords do not match";
                    return null;
                  }
                : validatePassword,
          );
        },
      ),
      const SizedBox(height: 10),
      if (label == "Password")
        PasswordStrengthIndicator(password: controller.text), // ✅ Ensure updates properly
    ],
  );
}

  // Password Validation with Strength Check
  String? validatePassword(String? value) {
    if (value!.isEmpty) return "Password is required";
    
    final passwordRegex = RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    
    if (!passwordRegex.hasMatch(value)) {
      return "Password must be at least 8 characters, include:\n🔹 One uppercase letter\n🔹 One lowercase letter\n🔹 One number\n🔹 One special character (@, #, \$, etc.)";
    }
    return null;
  }

  // Form Submission Logic
  Future<void> handleSignup(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully!")),
      );

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}

class PasswordStrengthIndicator extends StatefulWidget {
  final String password;

  const PasswordStrengthIndicator({Key? key, required this.password}) : super(key: key);

  @override
  State<PasswordStrengthIndicator> createState() => _PasswordStrengthIndicatorState();
}

class _PasswordStrengthIndicatorState extends State<PasswordStrengthIndicator> {
  double calculateStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'\d'))) score++;
    if (password.contains(RegExp(r'[@$!%*?&]'))) score++;
    return score / 5; // Normalize between 0.0 - 1.0
  }

  Color getStrengthColor(double strength) {
    if (strength <= 0.3) return Colors.red;
    if (strength <= 0.6) return Colors.orange;
    return Colors.green;
  }

  String getStrengthLabel(double strength) {
    if (strength <= 0.3) return "Weak";
    if (strength <= 0.6) return "Medium";
    return "Strong";
  }

  @override
  Widget build(BuildContext context) {
    double strength = calculateStrength(widget.password); // Calculate strength dynamically

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: strength,
          backgroundColor: Colors.grey[300],
          color: getStrengthColor(strength),
          minHeight: 8,
        ),
        const SizedBox(height: 5),
        Text(
          "Password Strength: ${getStrengthLabel(strength)}",
          style: TextStyle(color: getStrengthColor(strength), fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
