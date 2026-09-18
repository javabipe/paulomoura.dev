import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GlassBox extends StatefulWidget {
  final Widget child;
  final double blurX;
  final double blurY;
  final double borderRadius;
  final Color borderColor;
  final LinearGradient? backgroundGradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool animateHover;

  const GlassBox({
    super.key,
    required this.child,
    this.blurX = 15.0,
    this.blurY = 15.0,
    this.borderRadius = 16.0,
    this.borderColor = AppColors.glassBorder,
    this.backgroundGradient,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.animateHover = false,
  });

  @override
  State<GlassBox> createState() => _GlassBoxState();
}

class _GlassBoxState extends State<GlassBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeBorderColor = widget.animateHover && _isHovered
        ? AppColors.primary
        : widget.borderColor;

    final activeGradient = widget.backgroundGradient ?? AppColors.glassGradient;

    final scale = widget.animateHover && _isHovered ? 1.02 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(scale),
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: widget.animateHover && _isHovered
                  ? AppColors.primary.withOpacity(0.08)
                  : Colors.black.withOpacity(0.2),
              blurRadius: widget.animateHover && _isHovered ? 24 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: widget.blurX, sigmaY: widget.blurY),
            child: Container(
              padding: widget.padding ?? const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                gradient: activeGradient,
                border: Border.all(
                  color: activeBorderColor,
                  width: 1.2,
                ),
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
