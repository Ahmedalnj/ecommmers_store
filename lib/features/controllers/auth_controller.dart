import 'package:ecommmers_store/services/database_connection.dart';
import 'package:ecommmers_store/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class AuthController {
  // Controllers for Login
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController loginPhoneController = TextEditingController();

  // Controllers for Signup
  final TextEditingController signupNameController = TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPhoneController = TextEditingController();
  final TextEditingController signupPasswordController = TextEditingController();
  final TextEditingController signupConfirmPasswordController = TextEditingController();

  // Authentication State
  bool isLoading = false;
  String? errorMessage;

  // User Data
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userCreatedAt; // Raw timestamp from database
  String? userCreatedAtFormatted; // Formatted date and time (Example: "January 1, 2026 at 10:56 PM")

  // Getters
  String get loginPhone => loginPhoneController.text.trim();
  String get signupPhone => signupPhoneController.text.trim();

  // ------------------------
  // Validation methods
  // ------------------------
  bool validateLogin({bool usePhone = false}) {
    errorMessage = null;
    if (usePhone) {
      if (loginPhoneController.text.isEmpty) {
        errorMessage = 'Please enter your phone number';
        return false;
      }
      if (!_isValidPhone(loginPhoneController.text)) {
        errorMessage = 'Please enter a valid phone number';
        return false;
      }
    } else {
      if (loginEmailController.text.isEmpty) {
        errorMessage = 'Please enter your email';
        return false;
      }
      if (!_isValidEmail(loginEmailController.text)) {
        errorMessage = 'Please enter a valid email';
        return false;
      }
    }

    if (loginPasswordController.text.isEmpty) {
      errorMessage = 'Please enter your password';
      return false;
    }

    if (loginPasswordController.text.length < 6) {
      errorMessage = 'Password must be at least 6 characters';
      return false;
    }

    return true;
  }

  bool validateSignup({bool requirePhone = false}) {
    errorMessage = null;

    if (signupNameController.text.length < 2) {
      errorMessage = 'Name must be at least 2 characters';
      return false;
    }

    if (signupEmailController.text.isEmpty) {
      errorMessage = 'Please enter your email';
      return false;
    }

    if (!_isValidEmail(signupEmailController.text)) {
      errorMessage = 'Please enter a valid email';
      return false;
    }

    if (requirePhone && signupPhoneController.text.isNotEmpty) {
      if (!_isValidPhone(signupPhoneController.text)) {
        errorMessage = 'Please enter a valid phone number';
        return false;
      }
    }

    if (signupPasswordController.text.length < 6) {
      errorMessage = 'Password must be at least 6 characters';
      return false;
    }

    if (signupPasswordController.text != signupConfirmPasswordController.text) {
      errorMessage = 'Passwords do not match';
      return false;
    }

    return true;
  }

  // ------------------------
  // Helpers
  // ------------------------
  bool _isValidPhone(String phone) {
    final cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleanedPhone.length < 10) return false;
    if (cleanedPhone.length > 15) return false;
    return true;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$', caseSensitive: false);
    return emailRegex.hasMatch(email.trim());
  }

  String formatPhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    return phone;
  }

  // ------------------------
  // Signup
  // ------------------------
  Future<bool> signup({bool requirePhone = false}) async {
    if (!validateSignup(requirePhone: requirePhone)) return false;

    isLoading = true;
    errorMessage = null;

    try {
      final name = signupNameController.text.trim();
      final email = signupEmailController.text.trim().toLowerCase();
      final phone = signupPhoneController.text.trim().isNotEmpty
          ? signupPhoneController.text.trim()
          : null;
      final password = signupPasswordController.text;

      // Prepare data for insertion
      final userData = <String, dynamic>{
        'name': name,
        'email': email,
        'password': password, // Note: In production, passwords should be hashed
        'is_active': true,
      };
      
      // Only include phone if it's not empty
      if (phone != null && phone.isNotEmpty) {
        userData['phone'] = phone;
      }
      
      // Insert user into the users table
      // Insert without select to avoid triggering recursive database functions
      bool insertSucceeded = false;
      try {
        await DatabaseConnection.instance.client
            .from('users')
            .insert(userData);
        insertSucceeded = true;
      } catch (insertError) {
        // Check if the error is a stack depth error
        final errorStr = insertError.toString().toLowerCase();
        if (errorStr.contains('stack depth') || errorStr.contains('54001')) {
          // Stack depth error might occur even if insert succeeds
          // Wait a moment for the insert to complete, then verify
          await Future.delayed(const Duration(milliseconds: 500));
          
          // Try to verify user was created (using a simple count query to avoid recursion)
          try {
            final userCheck = await DatabaseConnection.instance.client
                .from('users')
                .select('id')
                .eq('email', email)
                .limit(1);
            
            if (userCheck.isNotEmpty) {
              // User was created successfully despite the error
              insertSucceeded = true;
              print('User created successfully (stack depth error occurred but insert succeeded)');
            } else {
              // User doesn't exist, the insert actually failed
              rethrow;
            }
          } catch (checkError) {
            // If verification also fails, assume insert failed
            throw insertError;
          }
        } else {
          // For other errors, re-throw them
          rethrow;
        }
      }
      
      // If insert didn't succeed, throw an error
      if (!insertSucceeded) {
        throw Exception('Failed to create user account');
      }

      // Store user data
      userName = name;
      userEmail = email;
      userPhone = phone;
      
      // Format the current date/time (since we just created the user)
      // The database will store created_at automatically, but we format current time for display
      final now = DateTime.now().toUtc();
      userCreatedAt = now.toIso8601String();
      userCreatedAtFormatted = DateFormatter.formatDateTime(userCreatedAt);
      
      // Print formatted date for verification (remove in production)
      print('User created at: $userCreatedAtFormatted');

      return true;
    } catch (e) {
      // Handle database errors - show actual error for debugging
      final errorString = e.toString().toLowerCase();
      final fullError = e.toString();
      
      // Print full error for debugging (remove in production)
      print('Signup Error: $fullError');
      
      // Check for unique constraint violations
      if (errorString.contains('unique') || 
          errorString.contains('duplicate') ||
          errorString.contains('duplicate key') ||
          errorString.contains('already exists')) {
        if (errorString.contains('email')) {
          errorMessage = 'Email already exists. Please use a different email.';
        } else if (errorString.contains('phone')) {
          errorMessage = 'Phone number already exists. Please use a different phone number.';
        } else {
          errorMessage = 'This information is already registered.';
        }
      } else if (errorString.contains('violates') || errorString.contains('constraint')) {
        // Show more specific error message
        if (errorString.contains('not null') || errorString.contains('null value')) {
          errorMessage = 'Please fill in all required fields.';
        } else if (errorString.contains('check constraint')) {
          errorMessage = 'Invalid data format. Please check your information.';
        } else {
          // Show the actual constraint error
          final constraintMatch = RegExp(r'constraint "?(\w+)"?').firstMatch(fullError);
          if (constraintMatch != null) {
            errorMessage = 'Invalid data: ${constraintMatch.group(1)}. Please check your information.';
          } else {
            errorMessage = 'Invalid data provided: $fullError';
          }
        }
      } else if (errorString.contains('permission') || errorString.contains('policy') || errorString.contains('row-level security')) {
        errorMessage = 'Permission denied. Please check your database permissions.';
      } else if (errorString.contains('stack depth') || errorString.contains('54001')) {
        errorMessage = 'Database error: Stack depth limit exceeded. This usually means there\'s a recursive trigger or function on the users table. Please check your database triggers.';
      } else {
        // Extract meaningful error message
        final truncatedMsg = fullError.length > 200 
            ? '${fullError.substring(0, 200)}...' 
            : fullError;
        errorMessage = 'Signup failed: $truncatedMsg';
      }
      return false;
    } finally {
      isLoading = false;
    }
  }

  // ------------------------
  // Login
  // ------------------------
  Future<bool> login({bool usePhone = false}) async {
    // Validate input (email or phone)
    final emailOrPhone = loginEmailController.text.trim();
    final password = loginPasswordController.text;

    if (emailOrPhone.isEmpty) {
      errorMessage = 'Please enter your email or phone number';
      return false;
    }

    if (password.isEmpty) {
      errorMessage = 'Please enter your password';
      return false;
    }

    isLoading = true;
    errorMessage = null;

    try {
      // Determine if input is email or phone
      final isEmail = _isValidEmail(emailOrPhone);
      final emailLower = emailOrPhone.toLowerCase();

      // Query user from database
      Map<String, dynamic>? user;
      bool querySucceeded = false;
      
      try {
        if (isEmail) {
          // Login with email
          final response = await DatabaseConnection.instance.client
              .from('users')
              .select()
              .eq('email', emailLower)
              .eq('is_active', true)
              .maybeSingle();
          
          user = response;
          querySucceeded = true;
        } else {
          // Try login with phone
          final response = await DatabaseConnection.instance.client
              .from('users')
              .select()
              .eq('phone', emailOrPhone)
              .eq('is_active', true)
              .maybeSingle();
          
          user = response;
          querySucceeded = true;
        }
      } catch (queryError) {
        // Check if the error is a stack depth error
        final errorStr = queryError.toString().toLowerCase();
        if (errorStr.contains('stack depth') || errorStr.contains('54001')) {
          // Stack depth error might occur even if query succeeds
          // Wait a moment, then try a simpler query to verify user exists
          await Future.delayed(const Duration(milliseconds: 500));
          
          try {
            // Try a simpler query to check if user exists
            List<dynamic> userList;
            if (isEmail) {
              userList = await DatabaseConnection.instance.client
                  .from('users')
                  .select('id, email, password, name, phone, created_at, is_active')
                  .eq('email', emailLower)
                  .limit(1);
            } else {
              userList = await DatabaseConnection.instance.client
                  .from('users')
                  .select('id, email, password, name, phone, created_at, is_active')
                  .eq('phone', emailOrPhone)
                  .limit(1);
            }
            
            if (userList.isNotEmpty) {
              user = userList.first as Map<String, dynamic>;
              querySucceeded = true;
            }
          } catch (checkError) {
            // If verification also fails, assume query failed
            querySucceeded = false;
          }
        } else {
          // For other errors, re-throw them
          rethrow;
        }
      }

      // Check if user exists
      if (!querySucceeded || user == null) {
        errorMessage = 'User not found. Please check your email/phone or sign up.';
        return false;
      }

      // Verify password (in production, passwords should be hashed and compared securely)
      if (user['password'] != password) {
        errorMessage = 'Incorrect password. Please try again.';
        return false;
      }

      // Store user data
      userName = user['name']?.toString() ?? 'User';
      userEmail = user['email']?.toString();
      userPhone = user['phone']?.toString();
      userCreatedAt = user['created_at']?.toString();
      userCreatedAtFormatted = DateFormatter.formatDateTime(userCreatedAt);

      return true;
    } catch (e) {
      final errorString = e.toString().toLowerCase();
      
      if (errorString.contains('permission') || errorString.contains('policy')) {
        errorMessage = 'Permission denied. Please check your database permissions.';
      } else {
        errorMessage = 'Login failed: ${e.toString()}';
      }
      return false;
    } finally {
      isLoading = false;
    }
  }

  // ------------------------
  // Dispose
  // ------------------------
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    loginPhoneController.dispose();

    signupNameController.dispose();
    signupEmailController.dispose();
    signupPhoneController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
  }
}
