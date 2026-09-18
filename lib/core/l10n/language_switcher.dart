import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'locale_scope.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = LocaleScope.of(context);
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        color: AppColors.primary.withOpacity(0.04),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FlagChip(code: 'en', emoji: '🇬🇧', label: 'EN', selected: lang == 'en'),
          _FlagChip(code: 'fr', emoji: '🇫🇷', label: 'FR', selected: lang == 'fr'),
        ],
      ),
    );
  }
}

class _FlagChip extends StatelessWidget {
  final String code;
  final String emoji;
  final String label;
  final bool selected;

  const _FlagChip({
    required this.code,
    required this.emoji,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => LocaleScope.controller(context).value = code,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary.withOpacity(0.16) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 13, height: 1)),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  color: selected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
