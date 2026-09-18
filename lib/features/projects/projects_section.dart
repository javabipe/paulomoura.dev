import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_assets.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/widgets/section_header.dart';
import '../../core/animations/glass_box.dart';
import '../../core/widgets/gradient_button.dart';
import '../../core/l10n/locale_scope.dart';
import '../../models/portfolio_models.dart';
import '../../data/portfolio_data.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
            title: S.t(context, 'projectsTitle'),
            subtitle: S.t(context, 'projectsEyebrow'),
          ),
          const SizedBox(height: 60),

          // Projects List (Alternating on Desktop)
          Column(
            children: List.generate(
              PortfolioData.projects(LocaleScope.isFr(context)).length,
              (index) {
                final project = PortfolioData.projects(LocaleScope.isFr(context))[index];
                return _ProjectRow(project: project, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  final Project project;
  final int index;

  const _ProjectRow({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isAlternate = index % 2 == 1;
    final isLast = index == PortfolioData.projects(LocaleScope.isFr(context)).length - 1;

    if (!isDesktop) {
      return _buildMobileLayout(context);
    }

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 20 : 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: isAlternate
            ? [
                Expanded(flex: 5, child: _buildProjectDetails(context)),
                const SizedBox(width: 50),
                Expanded(flex: 5, child: _buildProjectVisual(context)),
              ]
            : [
                Expanded(flex: 5, child: _buildProjectVisual(context)),
                const SizedBox(width: 50),
                Expanded(flex: 5, child: _buildProjectDetails(context)),
              ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 100.ms).slideY(begin: 0.1);
  }

  Widget _buildMobileLayout(BuildContext context) {
    final isLast = index == PortfolioData.projects(LocaleScope.isFr(context)).length - 1;
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 20 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectVisual(context),
          const SizedBox(height: 24),
          _buildProjectDetails(context),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1);
  }

  // A programmatically drawn mobile preview frame for the app visuals
  Widget _buildProjectVisual(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final double deviceWidth = isMobile ? double.infinity : 380;
    final double deviceHeight = isMobile ? 360 : 460;

    if (project.title.contains('Fatigue')) {
      return _buildFatigueVisual(context, deviceWidth, deviceHeight);
    } else if (project.title.contains('Tempo')) {
      return _buildTempoVisual(context, deviceWidth, deviceHeight);
    } else if (project.title.contains('Edzee')) {
      return _buildEdzeeVisual(context, deviceWidth, deviceHeight);
    } else if (project.title.contains('Phonoverse')) {
      return _buildPhonoverseVisual(context, deviceWidth, deviceHeight);
    } else if (project.title.contains('Zombie')) {
      return _buildZombieVisual(context, deviceWidth, deviceHeight);
    }

    // Get color accents based on title to keep visual branding unique
    Color primaryColor = AppColors.primary;
    Color secondaryColor = AppColors.secondary;
    IconData visualIcon = Icons.smartphone;

    if (project.title.contains('Tempo')) {
      primaryColor = Colors.tealAccent;
      secondaryColor = Colors.blueAccent;
      visualIcon = Icons.local_taxi;
    } else if (project.title.contains('Edzee')) {
      primaryColor = Colors.amberAccent;
      secondaryColor = Colors.deepOrangeAccent;
      visualIcon = Icons.school;
    } else if (project.title.contains('Phonoverse')) {
      primaryColor = Colors.purpleAccent;
      secondaryColor = Colors.indigoAccent;
      visualIcon = Icons.shopping_bag;
    } else if (project.title.contains('Dating')) {
      primaryColor = Colors.pinkAccent;
      secondaryColor = Colors.redAccent;
      visualIcon = Icons.favorite;
    }

    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GlassBox(
          animateHover: true,
          borderRadius: 24,
          borderColor: primaryColor.withOpacity(0.3),
          width: deviceWidth,
          height: deviceHeight,
          backgroundGradient: LinearGradient(
            colors: [
              primaryColor.withOpacity(0.12),
              secondaryColor.withOpacity(0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating glow background circle
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      primaryColor.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Mock phone screen skeleton layout
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(visualIcon, size: 56, color: primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    project.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Mock app UI lines
                  Container(
                    width: 120,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 80,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.textSecondary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),

              // Float badges indicating web/mobile targets
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, size: 10, color: AppColors.primary),
                      SizedBox(width: 4),
                      Text(
                        'PRODUCTION-READY',
                        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isFatigue = project.title.contains('Fatigue');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Number tag
                  Text(
                    '0${index + 1}.',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Green-to-yellow horizontal indicator line matching mockup
                  Container(
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.5),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF133C30), Color(0xFFE8A210)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  SelectableText(
                    project.title,
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // Shield badge for fatigue detection
            if (isFatigue)
              Container(
                margin: const EdgeInsets.only(left: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.08),
                  ),
                ),
                child: const Icon(
                  Icons.verified_user_rounded,
                  color: Color(0xFF133C30),
                  size: 28,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // Description
        SelectableText(
          project.description,
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        // Features list with dividers and icons
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(project.features.length, (featureIndex) {
            final feature = project.features[featureIndex];
            final featureIcon = _getFeatureIcon(feature);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.06),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          featureIcon,
                          size: 16,
                          color: const Color(0xFF133C30),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SelectableText(
                          feature,
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF4A5568),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Outfit',
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (featureIndex < project.features.length - 1)
                  Divider(
                    color: Colors.black.withOpacity(0.05),
                    thickness: 1.0,
                    height: 1,
                  ),
              ],
            );
          }),
        ),
        const SizedBox(height: 32),
        // Tech stack chips styled specifically per brand
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.techStack.map((tech) => _buildTechChip(tech)).toList(),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            GradientButton(
              text: 'Live Preview',
              icon: Icons.launch,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              onPressed: () async {
                final url = Uri.parse(project.liveUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            GradientButton(
              text: 'Source Code',
              icon: Icons.code,
              isSecondary: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              onPressed: () async {
                final url = Uri.parse(project.githubUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTechChip(String tech) {
    Color bgColor = const Color(0xFFF3F4F6);
    Color textColor = const Color(0xFF4B5563);
    Widget? icon;

    if (tech.toLowerCase() == 'flutter') {
      bgColor = const Color(0xFFE0F2FE);
      textColor = const Color(0xFF0369A1);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: FlutterLogo(size: 12),
      );
    } else if (tech.toLowerCase().contains('api')) {
      bgColor = const Color(0xFFF0FDF4);
      textColor = const Color(0xFF15803D);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.api_rounded, size: 12, color: Color(0xFF15803D)),
      );
    } else if (tech.toLowerCase() == 'getx') {
      bgColor = const Color(0xFFFDF2F8);
      textColor = const Color(0xFFBE185D);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.bolt_rounded, size: 12, color: Color(0xFFBE185D)),
      );
    } else if (tech.toLowerCase().contains('maps')) {
      bgColor = const Color(0xFFFFF7ED);
      textColor = const Color(0xFFC2410C);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.map_rounded, size: 12, color: Color(0xFFC2410C)),
      );
    } else if (tech.toLowerCase() == 'android') {
      bgColor = const Color(0xFFF0FDF4);
      textColor = const Color(0xFF16A34A);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.android_rounded, size: 12, color: Color(0xFF16A34A)),
      );
    } else if (tech.toLowerCase().contains('tensorflow') || tech.toLowerCase().contains('keras')) {
      bgColor = const Color(0xFFFFF7ED);
      textColor = const Color(0xFFC2410C);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.memory_rounded, size: 12, color: Color(0xFFC2410C)),
      );
    } else if (tech.toLowerCase().contains('opencv')) {
      bgColor = const Color(0xFFEEF2FF);
      textColor = const Color(0xFF4F46E5);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.remove_red_eye_rounded, size: 12, color: Color(0xFF4F46E5)),
      );
    } else if (tech.toLowerCase().contains('python')) {
      bgColor = const Color(0xFFFEF9C3);
      textColor = const Color(0xFF854D0E);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.code_rounded, size: 12, color: Color(0xFF854D0E)),
      );
    } else if (tech.toLowerCase().contains('getstorage')) {
      bgColor = const Color(0xFFF3E8FF);
      textColor = const Color(0xFF7C3AED);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.storage_rounded, size: 12, color: Color(0xFF7C3AED)),
      );
    } else if (tech.toLowerCase().contains('sharedpreferences') || tech.toLowerCase().contains('preferences')) {
      bgColor = const Color(0xFFECFEFF);
      textColor = const Color(0xFF0891B2);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.settings_suggest_rounded, size: 12, color: Color(0xFF0891B2)),
      );
    } else if (tech.toLowerCase().contains('flame')) {
      bgColor = const Color(0xFFFFF1F2);
      textColor = const Color(0xFFE11D48);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.local_fire_department_rounded, size: 12, color: Color(0xFFE11D48)),
      );
    } else if (tech.toLowerCase().contains('hive')) {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFFD97706);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.hive_rounded, size: 12, color: Color(0xFFD97706)),
      );
    } else if (tech.toLowerCase().contains('provider')) {
      bgColor = const Color(0xFFEEF2FF);
      textColor = const Color(0xFF4F46E5);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.hub_rounded, size: 12, color: Color(0xFF4F46E5)),
      );
    } else if (tech.toLowerCase().contains('painter') || tech.toLowerCase().contains('canvas')) {
      bgColor = const Color(0xFFFDF2F8);
      textColor = const Color(0xFFDB2777);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.brush_rounded, size: 12, color: Color(0xFFDB2777)),
      );
    } else if (tech.toLowerCase().contains('fonts') || tech.toLowerCase().contains('google fonts')) {
      bgColor = const Color(0xFFF0FDFA);
      textColor = const Color(0xFF0D9488);
      icon = const Padding(
        padding: EdgeInsets.only(right: 6),
        child: Icon(Icons.font_download_rounded, size: 12, color: Color(0xFF0D9488)),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: textColor.withOpacity(0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon,
          Text(
            tech,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'Outfit',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFatigueVisual(BuildContext context, double width, double height) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = height;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Car Image Background covering the entire container
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(
                      AppAssets.carDriving,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 2. White-to-transparent multi-stop gradient overlay to ensure text and scan overlays are highly readable
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.92), // Solid off-white at the top
                          Colors.white.withOpacity(0.35), // Semi-transparent in the middle to show car details
                          Colors.white.withOpacity(0.96), // Solid off-white at the bottom for text readability
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.48, 0.82],
                      ),
                    ),
                  ),
                ),

                // 3. Production Ready Badge
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E5631),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'PRODUCTION-READY',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E5631),
                            letterSpacing: 0.5,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. Driver Scanning Box (centered in upper area)
                Align(
                  alignment: const Alignment(0.0, -0.6),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            AppAssets.driverSleeping,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Bracket overlay
                      SizedBox(
                        width: 108,
                        height: 108,
                        child: CustomPaint(
                          painter: _ViewfinderPainter(
                            color: const Color(0xFF133C30).withOpacity(0.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 5. Side Indicators (Eye Closure & Fatigue Level) positioned to the right of scanning box
                Align(
                  alignment: const Alignment(0.85, -0.6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Eye closure indicator
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.visibility_rounded,
                              size: 14,
                              color: Color(0xFF133C30),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'EYE CLOSURE',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              Text(
                                '72%',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E2522),
                                  fontFamily: 'Outfit',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Fatigue level indicator
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.coffee_rounded,
                              size: 14,
                              color: Color(0xFFE8A210),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'FATIGUE LEVEL',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              Text(
                                'HIGH',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFE8A210),
                                  fontFamily: 'Outfit',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 6. Bottom Typography details
                Positioned(
                  bottom: 24,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'AI DRIVER FATIGUE\nDETECTION SYSTEM',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E2522),
                          letterSpacing: 1.2,
                          fontFamily: 'Outfit',
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 70,
                        height: 2.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF133C30), Color(0xFFE8A210)],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Stay Alert. Stay Safe.',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4E5A56),
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getFeatureIcon(String featureText) {
    if (featureText.contains('eye') || featureText.contains('blink')) {
      return Icons.visibility_rounded;
    } else if (featureText.contains('Offline') || featureText.contains('inference') || featureText.contains('device AI')) {
      return Icons.memory_rounded;
    } else if (featureText.contains('warning') || featureText.contains('alarm') || featureText.contains('siren')) {
      return Icons.notifications_active_rounded;
    } else if (featureText.contains('analytics') || featureText.contains('dashboard') || featureText.contains('history')) {
      if (featureText.contains('earnings') || featureText.contains('charts')) {
        return Icons.show_chart_rounded;
      }
      return Icons.bar_chart_rounded;
    }
    
    // Tempo101 Driver App icons
    if (featureText.contains('booking') || featureText.contains('trip management') || featureText.contains('live location')) {
      return Icons.navigation_rounded;
    } else if (featureText.contains('trip history') || featureText.contains('records') || featureText.contains('access to trip')) {
      return Icons.access_time_rounded;
    } else if (featureText.contains('star ratings') || featureText.contains('ratings')) {
      return Icons.star_outline_rounded;
    }

    // EdzeeSmart icons
    if (featureText.contains('attendance') || featureText.contains('dashboards')) {
      return Icons.dashboard_customize_rounded;
    } else if (featureText.contains('grade') || featureText.contains('awards') || featureText.contains('assignments')) {
      return Icons.emoji_events_rounded;
    } else if (featureText.contains('Push notification') || featureText.contains('announcements')) {
      return Icons.campaign_rounded;
    } else if (featureText.contains('Offline usability') || featureText.contains('local caching')) {
      return Icons.cached_rounded;
    }

    // Phonoverse icons
    if (featureText.contains('swipe') || featureText.contains('transitions') || featureText.contains('lists')) {
      return Icons.view_carousel_rounded;
    } else if (featureText.contains('state management') || featureText.contains('filter')) {
      return Icons.filter_alt_rounded;
    } else if (featureText.contains('MVVM') || featureText.contains('organization') || featureText.contains('structural')) {
      return Icons.layers_rounded;
    } else if (featureText.contains('images caching') || featureText.contains('rendering') || featureText.contains('performance')) {
      return Icons.speed_rounded;
    }

    // Zombie Survival Shooter icons
    if (featureText.contains('Campaign Levels') || featureText.contains('Infected Zones')) {
      return Icons.map_rounded;
    } else if (featureText.contains('Tactical Arsenal') || featureText.contains('Weapons')) {
      return Icons.upgrade_rounded;
    } else if (featureText.contains('Adaptive AI') || featureText.contains('Zombie Types')) {
      return Icons.psychology_alt_rounded;
    } else if (featureText.contains('Power-ups') || featureText.contains('Loot')) {
      return Icons.flash_on_rounded;
    } else if (featureText.contains('Offline Competitive') || featureText.contains('Achievements')) {
      return Icons.leaderboard_rounded;
    }

    return Icons.bolt_rounded;
  }

  Widget _buildTempoVisual(BuildContext context, double width, double height) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = height;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFFF4FAF8), Color(0xFFEAF5F1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: const Color(0xFF10B981).withOpacity(0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Transparent mockup graphic from user covering the card
                Align(
                  alignment: const Alignment(0.0, -0.15),
                  child: Image.asset(
                    AppAssets.tempoVisual,
                    height: cardHeight * 0.72,
                    fit: BoxFit.contain,
                  ),
                ),

                // 2. Production Ready Badge
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E5631),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'PRODUCTION-READY',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E5631),
                            letterSpacing: 0.5,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Bottom Typography
                Positioned(
                  bottom: 24,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'TEMPO101 DRIVER APP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E2522),
                          letterSpacing: 1.2,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 70,
                        height: 2.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFFE8A210)],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Smart. Fast. Reliable.',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4E5A56),
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEdzeeVisual(BuildContext context, double width, double height) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = height;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: const Color(0xFFF59E0B).withOpacity(0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Transparent mockup graphic from user covering the card
                Align(
                  alignment: const Alignment(0.0, -0.15),
                  child: Image.asset(
                    AppAssets.edzeeVisual,
                    height: cardHeight * 0.72,
                    fit: BoxFit.contain,
                  ),
                ),

                // 2. Production Ready Badge
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8A210),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'PRODUCTION-READY',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFD97706),
                            letterSpacing: 0.5,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Bottom Typography
                Positioned(
                  bottom: 24,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'EDZEESMART',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E2522),
                          letterSpacing: 1.2,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 70,
                        height: 2.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFF3B82F6)],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Educate. Empower. Excel.',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4E5A56),
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhonoverseVisual(BuildContext context, double width, double height) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = height;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFFFAF5FF), Color(0xFFF3E8FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: const Color(0xFFA855F7).withOpacity(0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Transparent mockup graphic from user covering the card
                Align(
                  alignment: const Alignment(0.0, -0.15),
                  child: Image.asset(
                    AppAssets.phonoverseVisual,
                    height: cardHeight * 0.75,
                    fit: BoxFit.contain,
                  ),
                ),

                // 2. Production Ready Badge
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF7C3AED),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'PRODUCTION-READY',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF7C3AED),
                            letterSpacing: 0.5,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Bottom Typography
                Positioned(
                  bottom: 24,
                  left: 20,
                  right: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'PHONOVERSE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E2522),
                          letterSpacing: 1.2,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 70,
                        height: 2.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Premium E-Commerce Client.',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4E5A56),
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildZombieVisual(BuildContext context, double width, double height) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = height;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFF10B981).withOpacity(0.08), // Soft emerald green outline
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04), // Clean, soft shadow
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  // 1. Mockup Image Card (fit to fill the aspect layout gracefully)
                  Positioned.fill(
                    child: Image.asset(
                      AppAssets.zombieVisual,
                      fit: BoxFit.cover, // Covered to show full screen visual depth
                    ),
                  ),

                  // 2. White-to-transparent multi-stop gradient overlay (Fades corners/bottom text area)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.12), // Very subtle top fade
                            Colors.transparent,             // Clear middle area
                            Colors.white.withOpacity(0.18), // Soft bottom fade
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.48, 0.9],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ViewfinderPainter extends CustomPainter {
  final Color color;

  _ViewfinderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const double cornerLength = 12.0;

    // Top Left
    canvas.drawLine(const Offset(0, 0), const Offset(cornerLength, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, cornerLength), paint);

    // Top Right
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - cornerLength, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), paint);

    // Bottom Left
    canvas.drawLine(Offset(0, size.height), Offset(cornerLength, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - cornerLength), paint);

    // Bottom Right
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - cornerLength, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - cornerLength), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



