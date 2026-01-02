import 'package:ecommmers_store/features/controllers/auth_controller.dart';
import 'package:ecommmers_store/features/screens/sign_up/sign_up_constants.dart';
import 'package:ecommmers_store/features/validators/auth_validators.dart';
import 'package:ecommmers_store/features/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Form fields for SignUpScreen
class SignUpFormFields {
  /// Username field
  static Widget usernameField(AuthController controller) {
    return CustomTextField(
      label: "User Name",
      hint: "Enter your name",
      hight_of_field: SignUpConstants.fieldHeight,
      icon: SignUpConstants.userIcon,
      controller: controller.signupNameController,
      validator: AuthValidators.validateUsername,
    );
  }

  /// Email field
  static Widget emailField(AuthController controller) {
    return CustomTextField(
      label: "Email",
      hint: "Enter your email",
      hight_of_field: SignUpConstants.fieldHeight,
      icon: SignUpConstants.emailIcon,
      controller: controller.signupEmailController,
      validator: AuthValidators.validateEmail,
      keyboardType: TextInputType.emailAddress,
    );
  }

  /// Password field
  static Widget passwordField(
    AuthController controller,
    bool obscurePassword,
    VoidCallback onToggleVisibility,
  ) {
    return CustomTextField(
      label: "Password",
      hint: "Enter your password",
      hight_of_field: SignUpConstants.fieldHeight,
      icon: SignUpConstants.lockIcon,
      controller: controller.signupPasswordController,
      obscureText: obscurePassword,
      validator: AuthValidators.validatePassword,
      showPasswordStrength: true,
      suffixIcon: IconButton(
        icon: Icon(
          obscurePassword
              ? FontAwesomeIcons.eye
              : FontAwesomeIcons.eyeLowVision,
          color: Colors.black,
        ),
        onPressed: onToggleVisibility,
      ),
    );
  }

  /// Confirm password field
  static Widget confirmPasswordField(
    AuthController controller,
    bool obscureConfirm,
    VoidCallback onToggleVisibility,
  ) {
    return CustomTextField(
      label: "Confirm Password",
      hint: "Re-enter your password",
      hight_of_field: SignUpConstants.fieldHeight,
      icon: SignUpConstants.lockIcon,
      controller: controller.signupConfirmPasswordController,
      obscureText: obscureConfirm,
      validator: (value) => AuthValidators.validateConfirmPassword(
        value,
        controller.signupPasswordController.text,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          obscureConfirm
              ? FontAwesomeIcons.eye
              : FontAwesomeIcons.eyeLowVision,
          color: Colors.black,
        ),
        onPressed: onToggleVisibility,
      ),
    );
  }

  /// Phone field
  static Widget phoneField(AuthController controller) {
    return CustomTextField(
      label: "Phone",
      hint: "Enter your phone number",
      hight_of_field: SignUpConstants.fieldHeight,
      icon: SignUpConstants.phoneIcon,
      controller: controller.signupPhoneController,
      validator: (value) => AuthValidators.validatePhone(
        value,
        isRequired: false,
      ),
      keyboardType: TextInputType.phone,
    );
  }
}

