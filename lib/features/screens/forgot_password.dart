import 'package:ecommmers_store/features/controllers/auth_controller.dart';
import 'package:ecommmers_store/features/validators/auth_validators.dart';
import 'package:ecommmers_store/features/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommmers_store/features/widgets/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final controller = AuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Forgot password',
                style: GoogleFonts.poppins(
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Please, enter your email address. You will receive a link to create a new password via email.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Email',
                      hint: 'email@example.com',
                      icon: FontAwesomeIcons.envelope,
                      controller: controller.loginEmailController,
                      validator: AuthValidators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      hight_of_field: 20.0,
                    ),
                    const SizedBox(height: 18),
                    CustomButton(
                      text: 'SEND',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // controller.forgotPassword?.call(controller.loginEmailController.text);
                        }
                      },
                      backgroundColor: const Color(0xFFDB3022),
                      textColor: Colors.white,
                      isFullWidth: false,
                      width: 300,
                      borderRadius: 100,
                      height: 50,
                      suffixIcon: const Icon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
