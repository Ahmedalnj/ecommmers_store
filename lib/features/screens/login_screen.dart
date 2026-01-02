import 'package:ecommmers_store/features/controllers/auth_controller.dart';
import 'package:ecommmers_store/features/screens/forgot_password.dart';
import 'package:ecommmers_store/features/widgets/custom_button.dart';
import 'package:ecommmers_store/features/widgets/UniversalTextButton.dart';
import 'package:ecommmers_store/features/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_text_field.dart';
import 'sign_up_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = AuthController();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // ✅ Login function
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    if (controller.isLoading) return;

    setState(() => controller.isLoading = true);
    
    final success = await controller.login();
    
    setState(() => controller.isLoading = false);

    if (!mounted) return;

    if (success) {
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Login successful!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Navigate to home screen
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
      });
    } else {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  controller.errorMessage ?? 'Login failed. Please try again.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0EFEF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF0EFEF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // 🔹 Main Content
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      fontSize: 45,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Email or Phone
                                  CustomTextField(
                                    label: "Email or Phone",
                                    hint: "Enter email or phone",
                                    hight_of_field: 20,
                                    icon: FontAwesomeIcons.envelope,
                                    controller: controller.loginEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 16),

                                  // Password
                                  CustomTextField(
                                    label: "Password",
                                    hint: "Enter password",
                                    hight_of_field: 20,
                                    icon: FontAwesomeIcons.lock,
                                    controller:
                                        controller.loginPasswordController,
                                    obscureText: obscurePassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        obscurePassword
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeLowVision,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () => obscurePassword =
                                              !obscurePassword,
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: UniversalTextButton(
                                      onPressed: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const ForgotPassword(),
                                          ),
                                        )
                                      },
                                      text: "Forgot Password?",
                                      suffixIcon: Icon(
                                        FontAwesomeIcons.arrowRightLong,
                                        size: 15,
                                        color: const Color.fromARGB(
                                          255,
                                          255,
                                          75,
                                          15,
                                        ),
                                      ),
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Login Button
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomButton(
                                      text: controller.isLoading
                                          ? "Logging in..."
                                          : "Login",
                                      onPressed: _login,
                                      backgroundColor: const Color(0xFFDB3022),
                                      textColor: Colors.white,
                                      isFullWidth: false,
                                      width: 300,
                                      borderRadius: 100,
                                      height: 50,
                                      suffixIcon: const Icon(
                                        FontAwesomeIcons.arrowRightToBracket,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Navigate to Sign Up
                                  Align(
                                    alignment: Alignment.center,
                                    child: UniversalTextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const SignUpScreen(),
                                          ),
                                        );
                                      },
                                      text: "Don't have an account? Sign Up",
                                      suffixIcon: const Icon(
                                        FontAwesomeIcons.arrowRightLong,
                                        size: 15,
                                        color: Color.fromARGB(255, 255, 75, 15),
                                      ),
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 🔹 Social login
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Column(
                          children: [
                            const Text(
                              "Or login with social accounts",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialButton(
                                  faIcon: FontAwesomeIcons.facebookF,
                                  onTap: () => print('Facebook tapped'),
                                  iconColor: const Color(0xFF1877F2),
                                  width: 75,
                                  borderRadius: 17,
                                ),
                                const SizedBox(width: 16),
                                SocialButton(
                                  faIcon: FontAwesomeIcons.google,
                                  onTap: () => print('Google Login'),
                                  iconColor: const Color(0xFFFE0000),
                                  width: 75,
                                  borderRadius: 17,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
