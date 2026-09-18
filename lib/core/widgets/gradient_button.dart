import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final LinearGradient? gradient;
  final bool isSecondary;
  final bool isTertiary;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.gradient,
    this.isSecondary = false,
    this.isTertiary = false,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isHovered ? 1.03 : 1.0;
    
    Color textColor;
    BoxDecoration decoration;
    List<BoxShadow> boxShadows = [];

    if (widget.isTertiary) {
      // Tertiary style: Neutral muted capsule with soft hover highlight
      textColor = AppColors.textPrimary;
      decoration = BoxDecoration(
        color: _isHovered 
            ? AppColors.textSecondary.withOpacity(0.14) 
            : AppColors.textSecondary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
    } else if (widget.isSecondary) {
      // Secondary style: Elegant outline with transparent back and light tint hover
      textColor = AppColors.primary;
      decoration = BoxDecoration(
        color: _isHovered 
            ? AppColors.primary.withOpacity(0.06) 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: _isHovered ? AppColors.primary : AppColors.primary.withOpacity(0.35),
          width: 1.5,
        ),
      );
    } else {
      // Primary style: Sophisticated solid gradient with neon drop shadow
      textColor = Colors.white;
      final activeGradient = widget.gradient ?? const LinearGradient(
        colors: [AppColors.primary, Color(0xFF1C4F40)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
      decoration = BoxDecoration(
        gradient: activeGradient,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
      if (_isHovered) {
        boxShadows = [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.24),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ];
      }
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuad,
          transform: Matrix4.identity()..scale(scale),
          decoration: decoration.copyWith(boxShadow: boxShadows),
          padding: widget.padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  transform: Matrix4.translationValues(
                    (_isHovered && !widget.isTertiary && !widget.isSecondary) ? 2.0 : 0.0, 
                    0.0, 
                    0.0
                  ),
                  child: Icon(
                    widget.icon,
                    size: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  letterSpacing: 0.3,
                  fontFamily: 'Outfit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
