import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/widgets/section_header.dart';
import '../../core/animations/glass_box.dart';
import '../../core/l10n/locale_scope.dart';
import '../../data/portfolio_data.dart';
import '../../models/portfolio_models.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveLayout.isMobile(context) ? 30 : 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: S.t(context, 'expTitle'),
            subtitle: S.t(context, 'expEyebrow'),
          ),
          const SizedBox(height: 60),

          // Experience timeline tree
          Column(
            children: List.generate(
              PortfolioData.experience(LocaleScope.isFr(context)).length,
              (index) {
                final exp = PortfolioData.experience(LocaleScope.isFr(context))[index];
                return _TimelineNode(
                  exp: exp,
                  isLast: index == PortfolioData.experience(LocaleScope.isFr(context)).length - 1,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineNode extends StatefulWidget {
  final TimelineExperience exp;
  final bool isLast;
  final int index;

  const _TimelineNode({
    required this.exp,
    required this.isLast,
    required this.index,
  });

  @override
  State<_TimelineNode> createState() => _TimelineNodeState();
}

class _TimelineNodeState extends State<_TimelineNode> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Timeline indicator track (Positioned on the left)
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: 24,
          child: Column(
            children: [
              // Outer dot ring
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isHovered ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
                  border: Border.all(
                    color: _isHovered ? AppColors.primary : AppColors.secondary.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Center(
                  // Inner dot solid
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHovered ? AppColors.primary : AppColors.secondary,
                    ),
                  ),
                ),
              ),
              // Thread vertical line
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: AppColors.secondary.withOpacity(0.15),
                  ),
                ),
            ],
          ),
        ),
        // Timeline Content Card (padded on the left to make room for track)
        Padding(
          padding: const EdgeInsets.only(left: 48),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: GlassBox(
                animateHover: true,
                borderColor: _isHovered ? AppColors.primary : AppColors.glassBorderBlue,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Role & Company Row
                    ResponsiveLayout(
                      desktop: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SelectableText(
                              '${widget.exp.role} @ ${widget.exp.company}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            widget.exp.period,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      mobile: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            '${widget.exp.role} @ ${widget.exp.company}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.exp.period,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          widget.exp.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Accomplishment Highlights
                    ...widget.exp.highlights.map((highlight) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.arrow_right, size: 18, color: AppColors.primary),
                            const SizedBox(width: 6),
                            Expanded(
                              child: SelectableText(
                                highlight,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: (widget.index * 150).ms).slideX(begin: 0.05);
  }
}
