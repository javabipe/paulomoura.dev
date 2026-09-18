import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/widgets/section_header.dart';
import '../../core/l10n/locale_scope.dart';
import '../../core/animations/glass_box.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            title: S.t(context, 'aboutTitle'),
            subtitle: S.t(context, 'aboutEyebrow'),
          ),
          const SizedBox(height: 50),
          ResponsiveLayout(
            desktop: _buildDesktop(context),
            mobile: _buildMobile(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Biography
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                S.t(context, 'aboutHeadline'),
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SelectableText(
                S.t(context, 'about1'),
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              SelectableText(
                S.t(context, 'about2'),
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(width: 50),
        // Focus Cards
        Expanded(
          flex: 6,
          child: _buildCompetencyGrid(context),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          S.t(context, 'aboutHeadline'),
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SelectableText(
          S.t(context, 'about1'),
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        SelectableText(
          S.t(context, 'about2'),
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 40),
        _buildCompetencyGrid(context),
      ],
    );
  }

  Widget _buildCompetencyGrid(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final list = [
      _CompetencyData(
        title: S.t(context, 'comp1t'),
        desc: S.t(context, 'comp1d'),
        icon: Icons.hub,
      ),
      _CompetencyData(
        title: S.t(context, 'comp2t'),
        desc: S.t(context, 'comp2d'),
        icon: Icons.manage_search,
      ),
      _CompetencyData(
        title: S.t(context, 'comp3t'),
        desc: S.t(context, 'comp3d'),
        icon: Icons.fact_check,
      ),
      _CompetencyData(
        title: S.t(context, 'comp4t'),
        desc: S.t(context, 'comp4d'),
        icon: Icons.bolt,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isMobile ? 2.5 : 2.0,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return GlassBox(
          animateHover: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          borderColor: AppColors.glassBorderBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: AppColors.primary, size: 24),
              const SizedBox(height: 8),
              SelectableText(
                item.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                item.desc,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: (index * 100).ms, duration: 500.ms).slideY(begin: 0.1);
      },
    );
  }
}

class _CompetencyData {
  final String title;
  final String desc;
  final IconData icon;

  _CompetencyData({
    required this.title,
    required this.desc,
    required this.icon,
  });
}
