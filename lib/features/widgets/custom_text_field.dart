import 'package:ecommmers_store/features/validators/auth_validators.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Make sure you import your AuthValidators class

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool autovalidate;
  final FocusNode? focusNode;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color fillColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool showBorder;
  final Color focusedColor;
  final double labelFontSize;
  final double hintFontSize;
  final bool showPasswordStrength;
  final double hight_of_field;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autovalidate = true,
    this.focusNode,
    this.readOnly = false,
    this.onTap,
    this.fillColor = Colors.white,
    this.borderRadius = 4,
    this.contentPadding,
    this.showBorder = false,
    this.focusedColor = const Color.fromARGB(255, 255, 75, 15),
    this.labelFontSize = 14,
    this.hintFontSize = 14,
    this.showPasswordStrength = false,
    this.hight_of_field = 16.0,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isValid = false;
  double _passwordStrength = 0;
  String _passwordMessage = '';

  void _handleChange(String value) {
    if (widget.validator != null) {
      final result = widget.validator!(value);
      setState(() {
        _isValid = result == null && value.trim().isNotEmpty;
      });
    }

    if (widget.showPasswordStrength) {
      final result = AuthValidators.validatePasswordWithStrength(value);
      setState(() {
        _passwordStrength = (result['strength'] as int) / 100;
        _passwordMessage = result['message'] as String;
      });
    }
  }

  Color get _strengthColor {
    if (_passwordStrength < 0.6) return const Color.fromARGB(255, 255, 0, 0);
    if (_passwordStrength < 0.8) return Colors.orange;
    if (_passwordStrength < 0.95) return const Color.fromARGB(255, 251, 177, 57);
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: _handleChange,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          autovalidateMode: widget.autovalidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: GoogleFonts.nunitoSans(
              fontSize: widget.labelFontSize,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.nunitoSans(
              fontSize: widget.hintFontSize,
              color: Colors.grey,
            ),
            prefixIcon: Icon(widget.icon, color: Colors.black),
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: widget.fillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: widget.showBorder
                  ? BorderSide(color: Colors.grey[300]!)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: _isValid ? Colors.green : widget.focusedColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 0, 0),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: widget.hight_of_field,
                ),
            errorStyle: GoogleFonts.nunitoSans(
              fontSize: 12,
              color: const Color.fromARGB(255, 255, 0, 0),
              height: 1,
            ),
            errorMaxLines: 2,
          ),
        ),
        if (widget.showPasswordStrength)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: _passwordStrength,
                  backgroundColor: Colors.grey[300],
                  color: _strengthColor,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(15),
                ),
                const SizedBox(height: 1),
                Text(
                  _passwordMessage,
                  style: TextStyle(color: _strengthColor, fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
