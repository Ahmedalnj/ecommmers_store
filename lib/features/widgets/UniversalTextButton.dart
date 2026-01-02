import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversalTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final TextDecoration? decoration;
  final Color? backgroundColor;
  final double borderRadius;
  final bool enabled;
  final MainAxisAlignment mainAxisAlignment;

  const UniversalTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.color = Colors.purple,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.decoration,
    this.backgroundColor,
    this.borderRadius = 6,
    this.enabled = true,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: fontSize * 0.4),
              ],
              
              Text(
                text,
                style: GoogleFonts.nunitoSans(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: enabled ? color : color.withOpacity(0.5),
                  decoration: decoration,
                  decorationColor: color,
                  height: 1.2,
                ),
              ),
              
              if (suffixIcon != null) ...[
                SizedBox(width: fontSize * 0.4),
                suffixIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}