import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Constants for SignUpScreen
class SignUpConstants {
  // Colors
  static const Color backgroundColor = Color(0xFFF0EFEF);
  static const Color primaryButtonColor = Color(0xFFDB3022);
  static const Color textButtonColor = Color(0xFFFF4B0F);
  static const Color successColor = Colors.green;
  static const Color errorColor = Colors.red;

  // Spacing
  static const double horizontalPadding = 16.0;
  static const double fieldSpacing = 16.0;
  static const double titleBottomSpacing = 20.0;
  static const double buttonTopSpacing = 20.0;

  // Sizes
  static const double titleFontSize = 45.0;
  static const double fieldHeight = 20.0;
  static const double buttonWidth = 300.0;
  static const double buttonHeight = 50.0;
  static const double buttonBorderRadius = 100.0;
  static const double socialButtonWidth = 75.0;
  static const double socialButtonBorderRadius = 17.0;

  // Durations
  static const Duration snackbarDuration = Duration(seconds: 3);
  static const Duration errorSnackbarDuration = Duration(seconds: 4);
  static const Duration navigationDelay = Duration(seconds: 1);

  // Text
  static const String title = "Sign Up";
  static const String signUpButtonText = "Sign Up";
  static const String signingUpButtonText = "Signing up...";
  static const String alreadyHaveAccountText = "Already have an account?";
  static const String socialLoginText = "Or login with social accounts";
  static const String successMessage = "Account created successfully!";
  static const String defaultErrorMessage = "Signup failed. Please try again.";

  // Icons
  static const IconData userIcon = FontAwesomeIcons.user;
  static const IconData emailIcon = FontAwesomeIcons.envelope;
  static const IconData lockIcon = FontAwesomeIcons.lock;
  static const IconData phoneIcon = FontAwesomeIcons.phone;
  static const IconData arrowRightIcon = FontAwesomeIcons.arrowRightLong;
  static const IconData signUpIcon = FontAwesomeIcons.arrowRightToBracket;
  static const IconData facebookIcon = FontAwesomeIcons.facebookF;
  static const IconData googleIcon = FontAwesomeIcons.google;
  static const IconData successIcon = Icons.check_circle;
  static const IconData errorIcon = Icons.error_outline;

  // Social Button Colors
  static const Color facebookColor = Color(0xFF1877F2);
  static const Color googleColor = Color(0xFFFE0000);
}

