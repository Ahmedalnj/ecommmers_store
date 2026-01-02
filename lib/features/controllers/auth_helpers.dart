

abstract class AuthBaseController {
  bool isLoading = false;
  String? errorMessage;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email.trim());
  }

  bool isValidPhone(String phone) {
    final cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleanedPhone.length < 10) return false;
    if (cleanedPhone.length > 15) return false;
    return true;
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

  void dispose();
}
