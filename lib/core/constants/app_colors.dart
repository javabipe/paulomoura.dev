import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium Light Theme Backgrounds
  static const Color background = Color(0xFFFCFBF7);       // Soft Off-White/Cream
  static const Color bgDarkGradientStart = Color(0xFFFFFFFF); // Pure White
  static const Color bgDarkGradientEnd = Color(0xFFF4F3EF);   // Soft Grey Cream
  
  // Premium Forest Green & Warm Amber Accents (Based on reference image)
  static const Color primary = Color(0xFF133C30);    // Deep Forest Green
  static const Color secondary = Color(0xFFE8A210);  // Warm Amber / Mustard Yellow
  static const Color accent = Color(0xFF2E6F40);     // Olive Green
  static const Color success = Color(0xFF2A9D8F);    // Teal
  
  // Text Colors (Dark Gray/Charcoal for Light Theme readability)
  static const Color textPrimary = Color(0xFF1E2522);   // Deep Charcoal
  static const Color textSecondary = Color(0xFF4E5A56); // Medium Slate
  static const Color textMuted = Color(0xFF82908B);     // Light Sage Muted
  
  // Glassmorphic Light Constants
  static const Color glassBg = Color(0xD9FFFFFF);       // Frosted white glass
  static const Color glassBorder = Color(0x24133C30);   // Forest Green opacity
  static const Color glassBorderBlue = Color(0x24E8A210); // Amber Yellow opacity
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyberGradient = LinearGradient(
    colors: [primary, accent, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [bgDarkGradientStart, background, bgDarkGradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0xF0FFFFFF),
      Color(0xC0FAF9F5),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
