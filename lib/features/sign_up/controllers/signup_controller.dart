import 'package:ecommmers_store/features/controllers/auth_helpers.dart';
import 'package:ecommmers_store/services/database_connection.dart';
import 'package:ecommmers_store/utils/date_formatter.dart';
import 'package:flutter/material.dart';


class SignupController extends AuthBaseController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? userName;
  String? userEmail;
  String? userPhone;
  String? userCreatedAt;
  String? userCreatedAtFormatted;

  bool validate({bool requirePhone = false}) {
    errorMessage = null;

    if (nameController.text.length < 2) {
      errorMessage = 'Name must be at least 2 characters';
      return false;
    }

    if (!isValidEmail(emailController.text)) {
      errorMessage = 'Please enter a valid email';
      return false;
    }

    if (requirePhone && phoneController.text.isNotEmpty) {
      if (!isValidPhone(phoneController.text)) {
        errorMessage = 'Please enter a valid phone number';
        return false;
      }
    }

    if (passwordController.text.length < 6) {
      errorMessage = 'Password must be at least 6 characters';
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      errorMessage = 'Passwords do not match';
      return false;
    }

    return true;
  }

  Future<bool> signup({bool requirePhone = false}) async {
    if (!validate(requirePhone: requirePhone)) return false;

    isLoading = true;

    try {
      final userData = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim().toLowerCase(),
        'password': passwordController.text,
        'is_active': true,
      };

      if (phoneController.text.trim().isNotEmpty) {
        userData['phone'] = phoneController.text.trim();
      }

      await DatabaseConnection.instance.client
          .from('users')
          .insert(userData);

      userName = userData['name'] as String?;
      userEmail = userData['email'] as String?;
      userPhone = userData['phone'] as String?;

      final now = DateTime.now().toUtc().toIso8601String();
      userCreatedAt = now;
      userCreatedAtFormatted = DateFormatter.formatDateTime(now);

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
