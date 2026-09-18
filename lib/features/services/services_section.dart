import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/widgets/section_header.dart';
import '../../core/animations/glass_box.dart';
import '../../core/l10n/locale_scope.dart';
import '../../data/portfolio_data.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveLayout.isMobile(context) ? 30 : 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: S.t(context, 'servicesTitle'),
            subtitle: S.t(context, 'servicesEyebrow'),
          ),
          const SizedBox(height: 40),

          // Grid of Services
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 2.5 : 1.7,
            ),
            itemCount: PortfolioData.services(LocaleScope.isFr(context)).length,
            itemBuilder: (context, index) {
              final service = PortfolioData.services(LocaleScope.isFr(context))[index];
              return _ServiceCard(
                title: service.title,
                description: service.description,
                icon: service.icon,
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final int index;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.index,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GlassBox(
            animateHover: true,
            padding: const EdgeInsets.all(24),
            borderColor:
                _isHovered ? AppColors.primary : AppColors.glassBorderBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (_isHovered
                            ? AppColors.primary
                            : AppColors.secondary)
                        .withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: (_isHovered
                              ? AppColors.primary
                              : AppColors.secondary)
                          .withOpacity(0.2),
                    ),
                  ),
                  child: Icon(
                        widget.icon,
                        color:
                            _isHovered
                                ? AppColors.primary
                                : AppColors.textPrimary,
                        size: 22,
                      )
                      .animate(target: _isHovered ? 1.0 : 0.0)
                      .scale(
                        end: const Offset(1.1, 1.1),
                        duration: 200.ms,
                        curve: Curves.easeInOut,
                      ),
                ),
                const SizedBox(height: 14),
                // Title
                SelectableText(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                // Description
                SelectableText(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(duration: 500.ms, delay: (widget.index * 80).ms)
          .slideY(begin: 0.1),
    );
  }
}
