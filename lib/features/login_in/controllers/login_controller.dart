import 'package:ecommmers_store/services/database_connection.dart';
import 'package:ecommmers_store/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import '../../controllers/auth_helpers.dart';

class LoginController extends AuthBaseController {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? userName;
  String? userEmail;
  String? userPhone;
  String? userCreatedAt;
  String? userCreatedAtFormatted;

  bool validate() {
    errorMessage = null;

    if (emailOrPhoneController.text.isEmpty) {
      errorMessage = 'Please enter email or phone';
      return false;
    }

    if (passwordController.text.isEmpty) {
      errorMessage = 'Please enter password';
      return false;
    }

    return true;
  }

  Future<bool> login() async {
    if (!validate()) return false;

    isLoading = true;

    try {
      final input = emailOrPhoneController.text.trim();
      final isEmail = isValidEmail(input);

      final user = await DatabaseConnection.instance.client
          .from('users')
          .select()
          .eq(isEmail ? 'email' : 'phone', isEmail ? input.toLowerCase() : input)
          .eq('is_active', true)
          .maybeSingle();

      if (user == null) {
        errorMessage = 'User not found';
        return false;
      }

      if (user['password'] != passwordController.text) {
        errorMessage = 'Incorrect password';
        return false;
      }

      userName = user['name'];
      userEmail = user['email'];
      userPhone = user['phone'];
      userCreatedAt = user['created_at'];
      userCreatedAtFormatted =
          DateFormatter.formatDateTime(userCreatedAt);

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
    emailOrPhoneController.dispose();
    passwordController.dispose();
  }
}
