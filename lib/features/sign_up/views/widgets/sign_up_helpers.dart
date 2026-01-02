
import 'package:ecommmers_store/features/login_in/screens/login_screen.dart';
import 'package:ecommmers_store/features/sign_up/views/widgets/sign_up_constants.dart';
import 'package:ecommmers_store/features/sign_up/controllers/signup_controller.dart';
import 'package:flutter/material.dart';

/// Helper methods for SignUpScreen
class SignUpHelpers {
  /// Show success snackbar
  static void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(
              SignUpConstants.successIcon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                SignUpConstants.successMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: SignUpConstants.successColor,
        behavior: SnackBarBehavior.floating,
        duration: SignUpConstants.snackbarDuration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Show error snackbar
  static void showErrorSnackbar(BuildContext context, String? errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              SignUpConstants.errorIcon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                errorMessage ?? SignUpConstants.defaultErrorMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: SignUpConstants.errorColor,
        behavior: SnackBarBehavior.floating,
        duration: SignUpConstants.errorSnackbarDuration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Navigate to login screen
  static void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  /// Handle signup success
  static Future<void> handleSignupSuccess(
    BuildContext context,
    SignupController controller,
  ) async {
    showSuccessSnackbar(context);
    await Future.delayed(SignUpConstants.navigationDelay);
    if (context.mounted) {
      navigateToLogin(context);
    }
  }

  /// Handle signup failure
  static void handleSignupFailure(
    BuildContext context,
    SignupController controller,
  ) {
    showErrorSnackbar(context, controller.errorMessage);
  }
}

