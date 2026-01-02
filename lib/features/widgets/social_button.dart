import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  // أنواع الأيقونات المدعومة
  final IconData? icon;            // Material Icons
  final IconData? faIcon;          // FontAwesome Icons
  final String? asset;             // مسار الصورة
  final Widget? customIcon;        // أيقونة مخصصة
  final VoidCallback onTap;
  
  // الخيارات العامة
  final double? width;             // ← إضافة عرض مخصص (اختياري)
  final double? height;            // ← إضافة ارتفاع مخصص (اختياري)
  final double size;               // الحجم (للدائري/المربع)
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final bool hasShadow;
  final EdgeInsets padding;
  final bool isLoading;

  const SocialButton({
    super.key,
    this.icon,
    this.faIcon,
    this.asset,
    this.customIcon,
    required this.onTap,
    this.width,                    // ← معلمة جديدة
    this.height,                   // ← معلمة جديدة
    this.size = 52,
    this.iconSize = 24,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderRadius = 12,
    this.hasShadow = false,
    this.padding = EdgeInsets.zero,
    this.isLoading = false,
  }) : assert(
          icon != null || faIcon != null || asset != null || customIcon != null,
          'يجب توفير نوع واحد على الأقل من الأيقونات',
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? size,       // ← استخدام العرض المخصص أو الحجم الافتراضي
        height: height ?? size,     // ← استخدام الارتفاع المخصص أو الحجم الافتراضي
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        padding: padding,
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(iconColor),
                  ),
                )
              : _buildIcon(),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (isLoading) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(iconColor),
        ),
      );
    }

    if (customIcon != null) return customIcon!;
    
    if (faIcon != null) {
      return FaIcon(
        faIcon,
        size: iconSize,
        color: iconColor,
      );
    } else if (icon != null) {
      return Icon(
        icon,
        size: iconSize,
        color: iconColor,
      );
    } else if (asset != null) {
      return Image.asset(
        asset!,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
        color: iconColor != Colors.black ? iconColor : null,
      );
    }
    
    return const SizedBox.shrink();
  }
}

