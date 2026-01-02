
import 'package:ecommmers_store/features/sign_up/views/widgets/sign_up_constants.dart';
import 'package:ecommmers_store/features/sign_up/views/widgets/sign_up_form_fields.dart';
import 'package:ecommmers_store/features/sign_up/views/widgets/sign_up_helpers.dart';
import 'package:ecommmers_store/features/sign_up/controllers/signup_controller.dart';
import 'package:ecommmers_store/features/widgets/custom_button.dart';
import 'package:ecommmers_store/features/widgets/social_button.dart';
import 'package:ecommmers_store/features/widgets/UniversalTextButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _controller = SignupController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handle signup button press
  Future<void> _handleSignup() async {
    if (_controller.isLoading) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _controller.isLoading = true);

    final success = await _controller.signup();

    setState(() => _controller.isLoading = false);

    if (!mounted) return;

    if (success) {
      await SignUpHelpers.handleSignupSuccess(context, _controller);
    } else {
      SignUpHelpers.handleSignupFailure(context, _controller);
    }
  }

  /// Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  /// Toggle confirm password visibility
  void _toggleConfirmPasswordVisibility() {
    setState(() => _obscureConfirm = !_obscureConfirm);
  }

  /// Navigate to login screen
  void _navigateToLogin() {
    SignUpHelpers.navigateToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SignUpConstants.backgroundColor,
      resizeToAvoidBottomInset: true,
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
                      _buildMainContent(),
                      _buildSocialLoginSection(),
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

  /// Build main content section
  Widget _buildMainContent() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SignUpConstants.horizontalPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                SizedBox(height: SignUpConstants.titleBottomSpacing),
                _buildFormFields(),
                _buildAlreadyHaveAccountButton(),
                SizedBox(height: SignUpConstants.buttonTopSpacing),
                _buildSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build title
  Widget _buildTitle() {
    return Text(
      SignUpConstants.title,
      style: GoogleFonts.poppins(
        fontSize: SignUpConstants.titleFontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Build form fields
  Widget _buildFormFields() {
    return Column(
      children: [
        SignUpFormFields.usernameField(_controller),
        SizedBox(height: SignUpConstants.fieldSpacing),
        SignUpFormFields.emailField(_controller),
        SizedBox(height: SignUpConstants.fieldSpacing),
        SignUpFormFields.passwordField(
          _controller,
          _obscurePassword,
          _togglePasswordVisibility,
        ),
        const SizedBox(height: 8),
        SignUpFormFields.confirmPasswordField(
          _controller,
          _obscureConfirm,
          _toggleConfirmPasswordVisibility,
        ),
        SizedBox(height: SignUpConstants.fieldSpacing),
        SignUpFormFields.phoneField(_controller),
      ],
    );
  }

  /// Build "Already have an account" button
  Widget _buildAlreadyHaveAccountButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: UniversalTextButton(
        onPressed: _navigateToLogin,
        text: SignUpConstants.alreadyHaveAccountText,
        suffixIcon: Icon(
          SignUpConstants.arrowRightIcon,
          size: 15,
          color: SignUpConstants.textButtonColor,
        ),
        color: Colors.black,
      ),
    );
  }

  /// Build sign up button
  Widget _buildSignUpButton() {
    return Align(
      alignment: Alignment.center,
      child: CustomButton(
        text: _controller.isLoading
            ? SignUpConstants.signingUpButtonText
            : SignUpConstants.signUpButtonText,
        onPressed: _handleSignup,
        backgroundColor: SignUpConstants.primaryButtonColor,
        textColor: Colors.white,
        isFullWidth: false,
        width: SignUpConstants.buttonWidth,
        borderRadius: SignUpConstants.buttonBorderRadius,
        height: SignUpConstants.buttonHeight,
        isLoading: _controller.isLoading,
        suffixIcon: _controller.isLoading
            ? null
            : const Icon(
                SignUpConstants.signUpIcon,
                color: Colors.white,
              ),
      ),
    );
  }

  /// Build social login section
  Widget _buildSocialLoginSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SignUpConstants.horizontalPadding,
        8,
        SignUpConstants.horizontalPadding,
        SignUpConstants.horizontalPadding,
      ),
      child: Column(
        children: [
          const Text(
            SignUpConstants.socialLoginText,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButton(
                faIcon: SignUpConstants.facebookIcon,
                onTap: () => _handleSocialLogin('Facebook'),
                iconColor: SignUpConstants.facebookColor,
                width: SignUpConstants.socialButtonWidth,
                borderRadius: SignUpConstants.socialButtonBorderRadius,
              ),
              const SizedBox(width: 16),
              SocialButton(
                faIcon: SignUpConstants.googleIcon,
                onTap: () => _handleSocialLogin('Google'),
                iconColor: SignUpConstants.googleColor,
                width: SignUpConstants.socialButtonWidth,
                borderRadius: SignUpConstants.socialButtonBorderRadius,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Handle social login
  void _handleSocialLogin(String provider) {
    // TODO: Implement social login
    debugPrint('$provider login tapped');
  }
}
