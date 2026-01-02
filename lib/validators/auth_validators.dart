class AuthValidators {
  // Name validator - متطور
  static String? validateUsername(String? value, {bool isRequired = true}) {
  if (isRequired && (value == null || value.trim().isEmpty)) {
    return 'Username is required';
  }
  
  if (value != null && value.trim().isNotEmpty) {
    final trimmedValue = value.trim();
    final lowercaseValue = trimmedValue.toLowerCase();
    
    // التحقق من الطول
    if (trimmedValue.length < 3) {
      return 'Username must be at least 3 characters';
    }
    
    if (trimmedValue.length > 20) {
      return 'Username cannot exceed 20 characters';
    }
    
    // عدم السماح بالمسافات
    if (trimmedValue.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    
    // السماح فقط بالحروف الإنجليزية والأرقام و underscores ونقاط
    final usernameRegex = RegExp(r'^[a-zA-Z0-9._]+$');
    if (!usernameRegex.hasMatch(trimmedValue)) {
      return 'Username can only contain letters, numbers, dots, and underscores';
    }
    
    // يجب أن يبدأ بحرف أو رقم (ليس underscore أو dot)
    if (!RegExp(r'^[a-zA-Z0-9]').hasMatch(trimmedValue)) {
      return 'Username must start with a letter or number';
    }
    
    // يجب أن ينتهي بحرف أو رقم (ليس underscore أو dot)
    if (!RegExp(r'[a-zA-Z0-9]$').hasMatch(trimmedValue)) {
      return 'Username must end with a letter or number';
    }
    
    // لا يسمح بنقطتين متتاليتين أو underscores متتالية
    if (trimmedValue.contains('..') || trimmedValue.contains('__')) {
      return 'Username cannot have consecutive dots or underscores';
    }
    
    // لا يسمح ب underscore أو dot في البداية والنهاية معاً
    if ((trimmedValue.startsWith('_') && trimmedValue.endsWith('_')) ||
        (trimmedValue.startsWith('.') && trimmedValue.endsWith('.'))) {
      return 'Username cannot start and end with the same special character';
    }
    
    // تجنب الأسماء المحجوزة
    final reservedUsernames = [
      'admin', 'administrator', 'root', 'system', 'user', 'users',
      'test', 'demo', 'guest', 'owner', 'moderator', 'support',
      'help', 'info', 'contact', 'service', 'official',
    ];
    
    if (reservedUsernames.contains(lowercaseValue)) {
      return 'This username is reserved';
    }
    
    // تجنب الكلمات المسيئة
    final offensiveWords = [
      'fuck', 'shit', 'ass', 'bitch', 'bastard', 'damn',
      // أضف المزيد حسب الحاجة
    ];
    
    if (offensiveWords.any((word) => lowercaseValue.contains(word))) {
      return 'Username contains inappropriate language';
    }
    
    // تجنب الأسماء المشابهة للروابط
    if (lowercaseValue.contains('http') || 
        lowercaseValue.contains('www') || 
        lowercaseValue.endsWith('.com') ||
        lowercaseValue.endsWith('.net') ||
        lowercaseValue.endsWith('.org')) {
      return 'Username cannot resemble a website URL';
    }
    
    // تجنب الأرقام فقط
    if (RegExp(r'^\d+$').hasMatch(trimmedValue)) {
      return 'Username cannot be only numbers';
    }
  }
  
  return null;
}
  
  // Email validator - متطور
  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return 'Please enter your email address';
    }
    
    if (value != null && value.trim().isNotEmpty) {
      final trimmedValue = value.trim().toLowerCase();
      
      // التحقق من الطول
      if (trimmedValue.length > 254) {
        return 'Email address is too long';
      }
      
      // تحقق متقدم من صيغة الإيميل
      final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        caseSensitive: false,
      );
      
      if (!emailRegex.hasMatch(trimmedValue)) {
        return 'Please enter a valid email address (e.g., name@example.com)';
      }
      
      // التحقق من المجالات المعروفة
      if (_isDisposableEmail(trimmedValue)) {
        return 'Please use a permanent email address';
      }
      
      // التحقق من المجالات المحظورة
      if (_isBlockedDomain(trimmedValue)) {
        return 'This email domain is not allowed';
      }
      
      // التحقق من صيغة الاسم قبل @
      final localPart = trimmedValue.split('@')[0];
      if (localPart.length > 64) {
        return 'Email username is too long';
      }
    }
    
    return null;
  }
  
  // Password validator - متطور
  static String? validatePassword(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return null;
    }
    
    if (value != null && value.isNotEmpty) {
      // التحقق من الطول
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
      
      if (value.length > 128) {
        return 'Password cannot exceed 128 characters';
      }
      
      // التحقق من الأحرف الكبيرة
      if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain at least one uppercase letter';
      }
      
      // التحقق من الأحرف الصغيرة
      if (!value.contains(RegExp(r'[a-z]'))) {
        return 'Password must contain at least one lowercase letter';
      }
      
      // التحقق من الأرقام
      if (!value.contains(RegExp(r'[0-9]'))) {
        return 'Password must contain at least one number';
      }
      
      // التحقق من الرموز الخاصة
      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return 'Password must contain at least one special character (!@#\$%^&* etc.)';
      }
      
      // التحقق من المسافات
      if (value.contains(' ')) {
        return 'Password cannot contain spaces';
      }
      
      // التحقق من كلمات المرور الشائعة
      if (_isCommonPassword(value)) {
        return 'This password is too common. Please choose a stronger one';
      }
      
      // التحقق من التكرارات
      if (_hasRepeatingChars(value)) {
        return 'Password contains too many repeating characters';
      }
    }
    
    return null;
  }

   static String? emailOrPhoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Enter email or phone';
    if (AuthValidators.validateEmail(value) == null ||
        AuthValidators.validatePhone(value) == null) {
      return null; // valid
    }
    return 'Enter valid email or phone';
  }
  
  // Confirm Password validator
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  // Phone Number validator - متطور
  static String? validatePhone(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return 'Please enter your phone number';
    }
    
    if (value != null && value.trim().isNotEmpty) {
      final cleanedValue = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
      
      // التحقق من الأرقام فقط
      if (!RegExp(r'^09[1-5][0-9]{7}$').hasMatch(cleanedValue)) {
        return 'Phone number must start with 09 and be 10 digits';
      }
      
      // التحقق من الطول
      if (cleanedValue.length < 10) {
        return 'Phone number must be at least 10 digits';
      }
      
      if (cleanedValue.length > 15) {
        return 'Phone number is too long';
      }
      
      // التحقق من الأرقام الدولية
      if (cleanedValue.startsWith('00') || cleanedValue.startsWith('+')) {
        // التحقق من رمز الدولة
        if (!_isValidCountryCode(cleanedValue)) {
          return 'Invalid country code';
        }
      }
    }
    
    return null;
  }
  
  
  
  static bool _isDisposableEmail(String email) {
    final disposableDomains = [
      'tempmail.com', 'throwaway.com', 'fake.com', 'trashmail.com',
      'guerrillamail.com', 'mailinator.com', 'yopmail.com'
    ];
    
    final domain = email.split('@')[1].toLowerCase();
    return disposableDomains.any((d) => domain.contains(d));
  }
  
  static bool _isBlockedDomain(String email) {
    final blockedDomains = ['example.com', 'test.com', 'domain.com'];
    final domain = email.split('@')[1].toLowerCase();
    return blockedDomains.contains(domain);
  }
  
  static bool _isCommonPassword(String password) {
    final commonPasswords = [
      'password', '12345678', 'qwerty', 'admin', 'welcome',
      '123456789', 'password1', '123456', '1234567890'
    ];
    return commonPasswords.contains(password.toLowerCase());
  }
  
  static bool _hasRepeatingChars(String password) {
    final repeatingRegex = RegExp(r'(.)\1{2,}');
    return repeatingRegex.hasMatch(password);
  }
  
  static bool _isValidCountryCode(String phone) {
    final validCountryCodes = ['1', '20', '44', '33', '49', '81', '86', '971'];
    
    // استخراج رمز الدولة
    String countryCode = '';
    if (phone.startsWith('00')) {
      countryCode = phone.substring(2, 4);
    } else if (phone.startsWith('+')) {
      countryCode = phone.substring(1, 3);
    }
    
    return validCountryCodes.contains(countryCode);
  }
  
  // Validation with strength meter for passwords
  static Map<String, dynamic> validatePasswordWithStrength(String? value) {
    if (value == null || value.isEmpty) {
      return {
        'valid': false,
        'message': 'Please enter your password',
        'strength': 0,
        'requirements': {
          'length': false,
          'uppercase': false,
          'lowercase': false,
          'number': false,
          'special': false,
        }
      };
    }
    
    final requirements = {
      'length': value.length >= 8,
      'uppercase': value.contains(RegExp(r'[A-Z]')),
      'lowercase': value.contains(RegExp(r'[a-z]')),
      'number': value.contains(RegExp(r'[0-9]')),
      'special': value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      'noSpaces': !value.contains(' '),
    };
    
    final metCount = requirements.values.where((v) => v).length;
    final strength = (metCount / requirements.length * 100).round();
    
    String? message;
    if (strength < 60) {
      message = 'Weak password';
    } else if (strength < 80) {
      message = 'Fair password';
    } else if (strength < 95) {
      message = 'Good password';
    } else {
      message = 'Strong password';
    }
    
    return {
      'valid': metCount == requirements.length,
      'message': message,
      'strength': strength,
      'requirements': requirements,
    };
  }
  
  // Validate multiple fields at once
  static Map<String, String?> validateSignupForm({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
  }) {
    return {
      'name': validateUsername(name),
      'email': validateEmail(email),
      'password': validatePassword(password),
      'confirmPassword': validateConfirmPassword(confirmPassword, password ?? ''),
      'phone': validatePhone(phone, isRequired: false),
    };
  }
}