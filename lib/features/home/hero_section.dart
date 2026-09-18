import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_assets.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/animations/animated_typing.dart';
import '../../core/widgets/gradient_button.dart';
import '../../core/l10n/locale_scope.dart';
import '../../core/services/resume_service.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onHireMePressed;
  final VoidCallback onViewProjectsPressed;

  const HeroSection({
    super.key,
    required this.onHireMePressed,
    required this.onViewProjectsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: ResponsiveLayout.isMobile(context) ? 0 : 500,
      ),
      alignment: Alignment.center,
      child: ResponsiveLayout(
        desktop: _buildDesktop(context),
        mobile: _buildMobile(context),
        tablet: _buildMobile(context), // Treat tablet as mobile view to stack components cleanly
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // Left Column: Text & CTAs
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ).animate(onPlay: (controller) => controller.repeat())
                     .scale(end: const Offset(1.5, 1.5), duration: 1000.ms, curve: Curves.easeInOut)
                     .fadeOut(duration: 1000.ms),
                    const SizedBox(width: 8),
                    Text(
                      S.t(context, 'openForWork'),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: -0.1),
              const SizedBox(height: 24),

              // Title
              SelectableText(
                S.t(context, 'helloIm'),
                style: textTheme.headlineMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
              const SizedBox(height: 8),
              
              // Name
              ShaderMask(
                shaderCallback: (bounds) => AppColors.cyberGradient.createShader(bounds),
                child: SelectableText(
                  AppConstants.developerName,
                  style: textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 300.ms).scaleXY(begin: 0.95),
              const SizedBox(height: 16),

              // Subtitle Typing
              Row(
                children: [
                  Text(
                    S.t(context, 'iBuild'),
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AnimatedTyping(
                    texts: [
                      S.t(context, 'type1'),
                      S.t(context, 'type2'),
                      S.t(context, 'type3'),
                      S.t(context, 'type4'),
                    ],
                    style: textTheme.headlineMedium!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
              const SizedBox(height: 16),

              // Tagline description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 550),
                child: SelectableText(
                  S.t(context, 'heroLede'),
                  style: textTheme.bodyLarge,
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
              const SizedBox(height: 40),

              // CTAs
              Wrap(
                spacing: 16,
                runSpacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  GradientButton(
                    text: S.t(context, 'hireMe'),
                    icon: Icons.alternate_email,
                    onPressed: onHireMePressed,
                  ),
                  GradientButton(
                    text: S.t(context, 'viewProjects'),
                    icon: Icons.grid_view,
                    isSecondary: true,
                    onPressed: onViewProjectsPressed,
                  ),
                  // Resume download
                  GradientButton(
                    text: S.t(context, 'resume'),
                    icon: Icons.download,
                    isTertiary: true,
                    onPressed: () => ResumeService.downloadResume(),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.1),
            ],
          ),
        ),

        // Right Column: Rotating cyber visual art
        Expanded(
          flex: 4,
          child: Center(
            child: _buildCyberGraphic(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Center(child: _buildCyberGraphic(context)),
        const SizedBox(height: 40),

        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                S.t(context, 'openForWork'),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        SelectableText(
          S.t(context, 'helloIm'),
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),

        ShaderMask(
          shaderCallback: (bounds) => AppColors.cyberGradient.createShader(bounds),
          child: SelectableText(
            AppConstants.developerName,
            style: textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 42,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Subtitle Typing in column for mobile spacing
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.t(context, 'iBuild'),
              style: textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            AnimatedTyping(
              texts: [
                S.t(context, 'type1'),
                S.t(context, 'type2'),
                S.t(context, 'type3'),
                S.t(context, 'type4'),
              ],
              style: textTheme.titleLarge!.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        SelectableText(
          S.t(context, 'heroLede'),
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),

        // CTAs in Wrap for mobile wrapping
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            GradientButton(
              text: S.t(context, 'hireMe'),
              icon: Icons.alternate_email,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              onPressed: onHireMePressed,
            ),
            GradientButton(
              text: S.t(context, 'viewProjects'),
              icon: Icons.grid_view,
              isSecondary: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              onPressed: onViewProjectsPressed,
            ),
            GradientButton(
              text: S.t(context, 'resume'),
              icon: Icons.download,
              isTertiary: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              onPressed: () => ResumeService.downloadResume(),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildCyberGraphic(BuildContext context) {
    return const _HeroCyberGraphic();
  }
}

class _HeroCyberGraphic extends StatefulWidget {
  const _HeroCyberGraphic();

  @override
  State<_HeroCyberGraphic> createState() => _HeroCyberGraphicState();
}

class _HeroCyberGraphicState extends State<_HeroCyberGraphic> with SingleTickerProviderStateMixin {
  int? _hoveredIndex;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: 520,
        height: 520,
        child: Stack(
          children: [
            // Custom Painter to draw connecting tracks, dots and glowing gradient lines
            // AnimatedBuilder only wraps the painter to avoid rebuilding cards at 60fps
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _HeroDiagramPainter(
                      hoveredIndex: _hoveredIndex,
                      rotationAngle: _animationController.value * 2 * math.pi * 0.4,
                    ),
                  );
                },
              ),
            ),

            // Top-Left: DEVELOPMENT (index 0)
            Positioned(
              left: 15,
              top: 15,
              width: 150,
              height: 120,
              child: _HeroServiceCard(
                title: S.t(context, 'heroDev'),
                imageAsset: AppAssets.developmentImage,
                themeColor: const Color(0xFF8B5CF6),
                isHovered: _hoveredIndex == 0,
                onHoverChanged: (hovered) {
                  setState(() {
                    _hoveredIndex = hovered ? 0 : null;
                  });
                },
                index: 0,
              ),
            ),

            // Top-Right: AI INTEGRATION (index 1)
            Positioned(
              right: 15,
              top: 15,
              width: 150,
              height: 120,
              child: _HeroServiceCard(
                title: S.t(context, 'heroAi'),
                imageAsset: AppAssets.aiIntegrationImage,
                themeColor: const Color(0xFF10B981),
                isHovered: _hoveredIndex == 1,
                onHoverChanged: (hovered) {
                  setState(() {
                    _hoveredIndex = hovered ? 1 : null;
                  });
                },
                index: 1,
              ),
            ),

            // Bottom-Left: CLOUD SOLUTIONS (index 2)
            Positioned(
              left: 15,
              bottom: 15,
              width: 150,
              height: 120,
              child: _HeroServiceCard(
                title: S.t(context, 'heroCloud'),
                imageAsset: AppAssets.cloudSolutionsImage,
                themeColor: const Color(0xFFE8A210),
                isHovered: _hoveredIndex == 2,
                onHoverChanged: (hovered) {
                  setState(() {
                    _hoveredIndex = hovered ? 2 : null;
                  });
                },
                index: 2,
              ),
            ),

            // Bottom-Right: PERFORMANCE (index 3)
            Positioned(
              right: 15,
              bottom: 15,
              width: 150,
              height: 120,
              child: _HeroServiceCard(
                title: S.t(context, 'heroPerf'),
                imageAsset: AppAssets.performanceImage,
                themeColor: const Color(0xFF0D9488),
                isHovered: _hoveredIndex == 3,
                onHoverChanged: (hovered) {
                  setState(() {
                    _hoveredIndex = hovered ? 3 : null;
                  });
                },
                index: 3,
              ),
            ),

            // Central laptop node (resized to 140x140)
            Align(
              alignment: Alignment.center,
              child: _HeroCenterNode(hoveredIndex: _hoveredIndex),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroServiceCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final Color themeColor;
  final bool isHovered;
  final ValueChanged<bool> onHoverChanged;
  final int index;

  const _HeroServiceCard({
    required this.title,
    required this.imageAsset,
    required this.themeColor,
    required this.isHovered,
    required this.onHoverChanged,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final scale = isHovered ? 1.05 : 1.0;

    // Corner alignment configurations where the vibrant theme color concentrates.
    final gradients = [
      LinearGradient(
        colors: [Colors.grey.withOpacity(0.08), themeColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Colors.grey.withOpacity(0.08), themeColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Colors.grey.withOpacity(0.08), themeColor],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      LinearGradient(
        colors: [Colors.grey.withOpacity(0.08), themeColor],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
    ];

    // Shadow offset configurations to cast shadow glow outwards/inwards towards the highlight.
    final shadowOffsets = [
      Offset(isHovered ? 6 : 3, isHovered ? 6 : 3),
      Offset(isHovered ? 6 : 3, isHovered ? 6 : 3),
      Offset(isHovered ? 6 : 3, isHovered ? -6 : -3),
      Offset(isHovered ? -6 : -3, isHovered ? -6 : -3),
    ];

    final double borderWidth = isHovered ? 2.5 : 1.8;

    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(scale),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: gradients[index],
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? themeColor.withOpacity(0.22)
                  : Colors.black.withOpacity(0.03),
              blurRadius: isHovered ? 28 : 14,
              spreadRadius: isHovered ? 3 : 1,
              offset: shadowOffsets[index],
            ),
          ],
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(borderWidth),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20 - borderWidth),
          ),
          child: Stack(
            children: [
              // 3D image filling the container
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20 - borderWidth),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Soft gradient overlay to keep text extremely legible
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20 - borderWidth),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.25),
                        Colors.white.withOpacity(0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Text and divider bar aligned at the bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          color: AppColors.textPrimary,
                          shadows: [
                            Shadow(
                              color: Colors.white,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white,
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 24,
                        height: 2.5,
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
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
}

class _HeroCenterNode extends StatelessWidget {
  final int? hoveredIndex;

  const _HeroCenterNode({required this.hoveredIndex});

  @override
  Widget build(BuildContext context) {
    final activeColor = hoveredIndex != null
        ? (hoveredIndex == 0
            ? const Color(0xFF8B5CF6)
            : hoveredIndex == 1
                ? const Color(0xFF10B981)
                : hoveredIndex == 2
                    ? const Color(0xFFE8A210)
                    : const Color(0xFF0D9488))
        : AppColors.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 140, // Resized from 110 to 140
      height: 140, // Resized from 110 to 140
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: activeColor.withOpacity(0.2),
          width: 2.2,
        ),
        boxShadow: [
          BoxShadow(
            color: activeColor.withOpacity(hoveredIndex != null ? 0.22 : 0.05),
            blurRadius: hoveredIndex != null ? 28 : 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.laptop,
              size: 75, // Resized from 55 to 75
              color: activeColor.withOpacity(0.85),
            ),
            Positioned(
              top: 22, // Adjusted positioning for larger scale
              child: Icon(
                Icons.code,
                size: 20, // Resized from 14 to 20
                color: activeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroDiagramPainter extends CustomPainter {
  final int? hoveredIndex;
  final double rotationAngle;

  const _HeroDiagramPainter({
    required this.hoveredIndex,
    required this.rotationAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Adjusted concentric ring radii for larger central node (140x140)
    const double innerRingRadius = 90;
    const double dashedTrackRadius = 118;
    const double outerTrackRadius = 150;

    final colors = [
      const Color(0xFF8B5CF6), // 0: Dev
      const Color(0xFF10B981), // 1: AI
      const Color(0xFFE8A210), // 2: Cloud
      const Color(0xFF0D9488), // 3: Perf
    ];

    // Inner Solid guide ring
    final innerPaint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, innerRingRadius, innerPaint);

    // Dashed Circle Track (Spins slowly)
    final dashedPaint = Paint()
      ..color = Colors.grey.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    _drawDashedCircle(canvas, center, dashedTrackRadius, 40, dashedPaint, rotationAngle);

    // Outer Solid guide ring
    final outerPaint = Paint()
      ..color = Colors.grey.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, outerTrackRadius, outerPaint);

    // Card Inner Corner Offsets (Static - no bobbing offset)
    final lineStarts = [
      const Offset(165, 135),
      const Offset(355, 135),
      const Offset(165, 385),
      const Offset(355, 385),
    ];

    final alignments = [
      [Alignment.topLeft, Alignment.bottomRight],
      [Alignment.topRight, Alignment.bottomLeft],
      [Alignment.bottomLeft, Alignment.topRight],
      [Alignment.bottomRight, Alignment.topLeft],
    ];

    for (int i = 0; i < 4; i++) {
      final themeColor = colors[i];
      final isHovered = hoveredIndex == i;
      final start = lineStarts[i];

      final dir = start - center;
      final dist = dir.distance;
      final unitDir = dir / dist;

      // Line ends at the center laptop node boundary (radius = 70 for 140x140 node)
      final lineEnd = center + unitDir * 70;

      if (isHovered) {
        // Glowing Linear Gradient Line
        final linePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..shader = LinearGradient(
            colors: [themeColor, themeColor.withOpacity(0.0)],
            begin: alignments[i][0],
            end: alignments[i][1],
          ).createShader(Rect.fromPoints(start, lineEnd));

        canvas.drawLine(start, lineEnd, linePaint);
      } else {
        // Soft standard connector line
        final linePaint = Paint()
          ..color = Colors.grey.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        canvas.drawLine(start, lineEnd, linePaint);
      }

      // Static dot at intersection of dashed track (radius = 118)
      // Dot size increased: 5.5 (normal) and 8.5 (hover) to make them prominent!
      final double dotRadius = isHovered ? 8.5 : 5.5;
      final dotPaint = Paint()
        ..color = themeColor
        ..style = PaintingStyle.fill;
      final dotPos = center + unitDir * dashedTrackRadius;
      canvas.drawCircle(dotPos, dotRadius, dotPaint);

      // Glossy white inner core reflection to make them look like glowing indicator bulbs!
      final corePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(dotPos, dotRadius * 0.35, corePaint);

      if (isHovered) {
        final glowPaint = Paint()
          ..color = themeColor.withOpacity(0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
        canvas.drawCircle(dotPos, dotRadius + 4.0, glowPaint);
      }
    }
  }

  void _drawDashedCircle(
      Canvas canvas, Offset center, double radius, int dashCount, Paint paint, double offsetAngle) {
    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (i * 2 * math.pi) / dashCount + offsetAngle;
      final double sweepAngle = math.pi / dashCount;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HeroDiagramPainter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex ||
        oldDelegate.rotationAngle != rotationAngle;
  }
}
