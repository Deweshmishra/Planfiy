import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planify/common/utils.dart';
import 'package:planify/features/login/login.dart';

import '../../common/app_colors.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isTermsAccepted = false;

  // ================= VALIDATION =================

  String? validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return "Password not match";
    }
    return null;
  }


  void onCreateAccountClick() async {

    if (_formKey.currentState!.validate() && _isTermsAccepted) {

      var box = Hive.box("userBox");

      // Save User Data in Hive
      box.put("name", _nameController.text);
      box.put("email", _emailController.text);
      box.put("mobile", _mobileController.text);
      box.put("password", _passwordController.text);

      // Auto Login Flag
      box.put("isLogin", true);
      print("Saved Data => Name: ${box.get("name")}, Email: ${box.get("email")}, Mobile: ${box.get("mobile")}, Login: ${box.get("isLogin")}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully")),
      );

      // Navigate to Profile OR Dashboard
      Navigator.pushNamedAndRemoveUntil(
          context,
          "/profile",    // your profile route name
              (route) => false);
    }
  }

  // ================= INPUT FIELD =================

  Widget buildInputField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool isConfirm = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword
          ? (isConfirm ? _isConfirmPasswordHidden : _isPasswordHidden)
          : false,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.white54),
        prefixIcon: Icon(icon, color: AppColors.white70),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            (isConfirm
                ? _isConfirmPasswordHidden
                : _isPasswordHidden)
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.white70,
          ),
          onPressed: () {
            setState(() {
              if (isConfirm) {
                _isConfirmPasswordHidden =
                !_isConfirmPasswordHidden;
              } else {
                _isPasswordHidden = !_isPasswordHidden;
              }
            });
          },
        )
            : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= BUTTON =================

  Widget buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onCreateAccountClick,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
          AppColors.btnGradient1,
           AppColors.btnGradient2,

              ],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text(
              "Create Account →",
              style: TextStyle(fontSize: 16, color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }

  // ================= MAIN UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: AppColors.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.bgGradient1,
              AppColors.bgGradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [

                  const SizedBox(height: 10),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 26,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Join Planfiy Premium for advanced document management.",
                    style: TextStyle(color: AppColors.white54),
                  ),

                  const SizedBox(height: 20),

                  buildInputField(
                    hintText: "John Doe",
                    icon: Icons.person_outline,
                    controller: _nameController,
                    validator: validateName,
                  ),

                  const SizedBox(height: 15),

                  buildInputField(
                    hintText: "email@example.com",
                    icon: Icons.mail_outline,
                    controller: _emailController,
                    validator: validateEmail,
                  ),

                  const SizedBox(height: 15),

                  buildInputField(
                    hintText: "+91 9876543210",
                    icon: Icons.phone_android,
                    controller: _mobileController,
                    validator: validateMobile,
                  ),

                  const SizedBox(height: 15),

                  buildInputField(
                    hintText: "Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    controller: _passwordController,
                    validator: validatePassword,
                  ),

                  const SizedBox(height: 15),

                  buildInputField(
                    hintText: "Confirm Password",
                    icon: Icons.security,
                    isPassword: true,
                    isConfirm: true,
                    controller: _confirmPasswordController,
                    validator: validateConfirmPassword,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: AppColors.white,
                        ),
                        child: Checkbox(
                          value: _isTermsAccepted,
                          activeColor: AppColors.blueAccent,     // when checked
                          checkColor: AppColors.white,           // tick color
                          side: const BorderSide(
                            color: AppColors.white,              // border color
                            width: 1.5,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isTermsAccepted = value!;
                            });
                          },
                        ),
                      ),

                      const SizedBox(width: 8),

                      const Expanded(
                        child: Text(
                          "I agree to the Terms of Service and Privacy Policy",
                          style: TextStyle(
                            color: AppColors.white70,
                          ),
                        ),
                      ),

                    ],
                  ),


                  const SizedBox(height: 10),

                  buildSignupButton(),

                  const SizedBox(height: 15),

                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(color: AppColors.white54),
                        children: [

                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
                              color: AppColors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreenPage(),
                                  ),
                                );
                              },
                          ),

                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
