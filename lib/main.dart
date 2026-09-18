import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_assets.dart';
import 'core/animations/glass_box.dart';
import 'features/home/hero_section.dart';
import 'features/about/about_section.dart';
import 'features/skills/skills_section.dart';
import 'features/projects/projects_section.dart';
import 'features/services/services_section.dart';
import 'features/experience/experience_section.dart';
import 'features/statistics/statistics_section.dart';
import 'features/contact/contact_section.dart';
import 'features/contact/footer_section.dart';
import 'core/l10n/locale_scope.dart';
import 'core/l10n/language_switcher.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<String> _locale = ValueNotifier('en');

  @override
  Widget build(BuildContext context) {
    return LocaleScope(
      notifier: _locale,
      child: AnimatedBuilder(
        animation: _locale,
        builder: (context, _) {
          return MaterialApp(
            title: 'Paulo Moura Martins | LLM Engineer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const PortfolioShell(),
          );
        },
      ),
    );
  }
}

class PortfolioShell extends StatefulWidget {
  const PortfolioShell({super.key});

  @override
  State<PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<PortfolioShell> {
  final _scrollController = ScrollController();
  
  // Section keys for scrolling
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  double _scrollProgress = 0.0;
  String _activeSection = 'Home';
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    
    // Calc scroll progress
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    
    setState(() {
      _scrollProgress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
    });

    // Detect active section only if NOT programmatically scrolling
    if (!_isProgrammaticScroll) {
      _detectActiveSection(currentScroll);
    }
  }

  void _detectActiveSection(double pixels) {
    // Basic approximate boundary offsets
    final List<Map<String, dynamic>> sectionBounds = [
      {'name': 'Home', 'key': _homeKey},
      {'name': 'About', 'key': _aboutKey},
      {'name': 'Skills', 'key': _skillsKey},
      {'name': 'Projects', 'key': _projectsKey},
      {'name': 'Services', 'key': _servicesKey},
      {'name': 'Experience', 'key': _experienceKey},
      {'name': 'Contact', 'key': _contactKey},
    ];

    for (final section in sectionBounds) {
      final key = section['key'] as GlobalKey;
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          // If the section is roughly at the top viewport half
          if (position.dy < 200 && position.dy > -box.size.height + 200) {
            if (_activeSection != section['name']) {
              setState(() {
                _activeSection = section['name'];
              });
            }
            break;
          }
        }
      }
    }
  }

  void _scrollTo(String sectionName, GlobalKey key) {
    if (_activeSection == sectionName) return;

    setState(() {
      _isProgrammaticScroll = true;
      _activeSection = sectionName;
    });

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );
    }

    Future.delayed(const Duration(milliseconds: 950), () {
      _isProgrammaticScroll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = MediaQuery.of(context).size.width < 1150.0;

    return Scaffold(
      endDrawer: isMobile ? _buildMobileDrawer() : null,
      body: Stack(
        children: [
          // 1. Deep Space Solid Background
          Container(color: AppColors.background),

          // 2. Glowing Premium Ambient Light blobs
          Positioned(
            top: -200,
            left: -100,
            child: _buildGlowBlob(
              color: AppColors.primary.withOpacity(0.07),
              width: 500,
              height: 500,
            ),
          ),
          Positioned(
            top: size.height * 0.4,
            right: -200,
            child: _buildGlowBlob(
              color: AppColors.secondary.withOpacity(0.08),
              width: 600,
              height: 600,
            ),
          ),
          Positioned(
            bottom: -100,
            left: size.width * 0.2,
            child: _buildGlowBlob(
              color: AppColors.accent.withOpacity(0.06),
              width: 500,
              height: 500,
            ),
          ),

          // 3. Scrollable Contents
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : size.width * 0.08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top margin spacer
                  const SizedBox(height: 120),

                  // Hero Section
                  Container(key: _homeKey, child: HeroSection(
                    onHireMePressed: () => _scrollTo('Contact', _contactKey),
                    onViewProjectsPressed: () => _scrollTo('Projects', _projectsKey),
                  )),

                  // Statistics Banner
                  const StatisticsSection(),

                  // About Me Section
                  Container(key: _aboutKey, child: const AboutSection()),

                  // Skills Section
                  Container(key: _skillsKey, child: const SkillsSection()),

                  // Featured Projects Section
                  Container(key: _projectsKey, child: const ProjectsSection()),

                  // Services Section
                  Container(key: _servicesKey, child: const ServicesSection()),

                  // Experience Timeline Section
                  Container(key: _experienceKey, child: const ExperienceSection()),

                  // Contact Section
                  Container(key: _contactKey, child: const ContactSection()),

                  // Footer Section
                  FooterSection(
                    onBackToTopPressed: () => _scrollTo('Home', _homeKey),
                  ),
                ],
              ),
            ),
          ),

          // 4. Floating Header (Navigation bar)
          Positioned(
            top: 24,
            left: isMobile ? 16 : size.width * 0.08,
            right: isMobile ? 16 : size.width * 0.08,
            child: _buildHeader(context),
          ),

          // 5. Left Side floating social handles on Desktop
          if (!isMobile)
            Positioned(
              left: 24,
              bottom: 40,
              child: _buildSideSocials(),
            ),

          // 6. Scroll Indicator Bar at very top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 3.5,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _scrollProgress,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowBlob({required Color color, required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1150.0;

    return GlassBox(
      borderRadius: 16,
      borderColor: AppColors.primary.withOpacity(0.12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Developer Branding
          GestureDetector(
            onTap: () => _scrollTo('Home', _homeKey),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        AppAssets.profilePhoto,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.person,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    AppConstants.developerName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      fontFamily: 'Outfit',
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Nav links on Desktop
          if (!isMobile)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LiquidNavMenu(
                  activeSection: _activeSection,
                  onSectionTap: (label, key) => _scrollTo(label, key),
                  homeKey: _homeKey,
                  aboutKey: _aboutKey,
                  skillsKey: _skillsKey,
                  projectsKey: _projectsKey,
                  servicesKey: _servicesKey,
                  experienceKey: _experienceKey,
                ),
                const SizedBox(width: 12),
                const LanguageSwitcher(),
                const SizedBox(width: 12),
                // Premium Contact CTA
                _ContactCTAButton(
                  onTap: () => _scrollTo('Contact', _contactKey),
                ),
              ],
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LanguageSwitcher(),
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu, color: AppColors.primary),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSideSocials() {
    return Column(
      children: [
        _buildSideSocialIcon(
          url: AppConstants.githubUrl,
          child: Image.asset(
            AppAssets.githubIcon,
            width: 16,
            height: 16,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        _buildSideSocialIcon(
          url: AppConstants.linkedinUrl,
          child: Image.asset(
            AppAssets.linkedinIcon,
            width: 16,
            height: 16,
          ),
        ),
        const SizedBox(height: 16),
        _buildSideSocialIcon(
          url: 'mailto:${AppConstants.email}',
          child: const Icon(
            Icons.alternate_email,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        // Connecting thread line
        Container(
          width: 1.5,
          height: 90,
          color: AppColors.textSecondary.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _buildSideSocialIcon({required Widget child, required String url}) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: AppColors.textSecondary.withOpacity(0.2),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: AppColors.primary.withOpacity(0.12),
              width: 1.5,
            ),
          ),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const LanguageSwitcher(),
            const SizedBox(height: 24),
            Text(
              S.t(context, 'navigation'),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 24),
            _buildDrawerItem('Home', _homeKey, S.t(context, 'navHome')),
            _buildDrawerItem('About', _aboutKey, S.t(context, 'navAbout')),
            _buildDrawerItem('Skills', _skillsKey, S.t(context, 'navSkills')),
            _buildDrawerItem('Projects', _projectsKey, S.t(context, 'navProjects')),
            _buildDrawerItem('Services', _servicesKey, S.t(context, 'navServices')),
            _buildDrawerItem('Experience', _experienceKey, S.t(context, 'navExperience')),
            _buildDrawerItem('Contact', _contactKey, S.t(context, 'navContact')),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String key, GlobalKey destKey, String label) {
    final isActive = _activeSection == key;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(); // Close drawer
        _scrollTo(key, destKey);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            if (isActive) ...[
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// Liquid Droplet Navigation Bar Widget & Painter
// =========================================================================

class _LiquidNavMenu extends StatefulWidget {
  final String activeSection;
  final Function(String, GlobalKey) onSectionTap;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey projectsKey;
  final GlobalKey servicesKey;
  final GlobalKey experienceKey;

  const _LiquidNavMenu({
    required this.activeSection,
    required this.onSectionTap,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.projectsKey,
    required this.servicesKey,
    required this.experienceKey,
  });

  @override
  State<_LiquidNavMenu> createState() => _LiquidNavMenuState();
}

class _LiquidNavMenuState extends State<_LiquidNavMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;
  int _prevIndex = 0;

  final List<String> _sections = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Services',
    'Experience'
  ];

  late final List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    _keys = [
      widget.homeKey,
      widget.aboutKey,
      widget.skillsKey,
      widget.projectsKey,
      widget.servicesKey,
      widget.experienceKey,
    ];
    _currentIndex = _sections.indexOf(widget.activeSection);
    if (_currentIndex == -1) {
      _currentIndex = widget.activeSection == 'Contact' ? 5 : 0;
    }
    _prevIndex = _currentIndex;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
  }

  @override
  void didUpdateWidget(covariant _LiquidNavMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeSection != oldWidget.activeSection) {
      int newIndex = _sections.indexOf(widget.activeSection);
      if (newIndex == -1) {
        if (widget.activeSection == 'Contact') {
          newIndex = 5;
        } else {
          newIndex = _currentIndex;
        }
      }
      if (newIndex != _currentIndex) {
        setState(() {
          _prevIndex = _currentIndex;
          _currentIndex = newIndex;
        });
        _controller.forward(from: 0.0);
      }
    }
  }

  String _navLabel(BuildContext context, String key) {
    const map = {
      'Home': 'navHome',
      'About': 'navAbout',
      'Skills': 'navSkills',
      'Projects': 'navProjects',
      'Services': 'navServices',
      'Experience': 'navExperience',
    };
    return S.t(context, map[key] ?? key);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double tabWidth = 90.0;
    const double menuWidth = tabWidth * 6;

    return SizedBox(
      width: menuWidth,
      height: 38,
      child: Stack(
        children: [
          // Liquid droplet background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _LiquidDropletPainter(
                    prevIndex: _prevIndex,
                    currentIndex: _currentIndex,
                    progress: _controller.value,
                    tabWidth: tabWidth,
                  ),
                );
              },
            ),
          ),

          // Menu texts
          Row(
            children: List.generate(_sections.length, (index) {
              final label = _sections[index];
              final isActive = _currentIndex == index;

              return SizedBox(
                width: tabWidth,
                height: 38,
                child: GestureDetector(
                  onTap: () {
                    if (_currentIndex != index) {
                      setState(() {
                        _prevIndex = _currentIndex;
                        _currentIndex = index;
                      });
                      _controller.forward(from: 0.0);
                      widget.onSectionTap(label, _keys[index]);
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Outfit',
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          color: isActive ? AppColors.primary : AppColors.textSecondary,
                        ),
                        child: Text(_navLabel(context, label)),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _LiquidDropletPainter extends CustomPainter {
  final int prevIndex;
  final int currentIndex;
  final double progress;
  final double tabWidth;

  const _LiquidDropletPainter({
    required this.prevIndex,
    required this.currentIndex,
    required this.progress,
    required this.tabWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height / 2;
    const double h = 32.0; // Droplet height
    const double w = 72.0; // Normal width of droplet
    const double r = h / 2; // Radius of rounded ends

    final double x1 = prevIndex * tabWidth + tabWidth / 2;
    final double x2 = currentIndex * tabWidth + tabWidth / 2;

    double leftEdge;
    double rightEdge;

    final t = progress;

    if (x1 < x2) {
      // Moving right
      final leftOffset = Curves.easeInCubic.transform(t) * (x2 - x1);
      final rightOffset = Curves.easeOutCubic.transform(t) * (x2 - x1);
      leftEdge = x1 - w / 2 + leftOffset;
      rightEdge = x1 + w / 2 + rightOffset;
    } else if (x1 > x2) {
      // Moving left
      final leftOffset = Curves.easeOutCubic.transform(t) * (x2 - x1);
      final rightOffset = Curves.easeInCubic.transform(t) * (x2 - x1);
      leftEdge = x1 - w / 2 + leftOffset;
      rightEdge = x1 + w / 2 + rightOffset;
    } else {
      // Idle
      leftEdge = x1 - w / 2;
      rightEdge = x1 + w / 2;
    }

    final double currentWidth = rightEdge - leftEdge;
    final double stretch = (currentWidth - w).clamp(0.0, double.infinity);
    final double maxPossibleStretch = (x2 - x1).abs();

    // Liquid thinning factor in the middle (gooey bridge)
    final double stretchRatio = maxPossibleStretch > 0 ? (stretch / maxPossibleStretch).clamp(0.0, 1.0) : 0.0;
    final double midH = h * (1.0 - 0.45 * stretchRatio);

    // Draw the water droplet shape
    final path = Path();
    final leftCenter = Offset(leftEdge + r, cy);
    final rightCenter = Offset(rightEdge - r, cy);

    // Draw left semi-circle
    path.addArc(
      Rect.fromCircle(center: leftCenter, radius: r),
      math.pi / 2,
      math.pi,
    );

    // Top gooey line connecting left to right
    path.moveTo(leftEdge + r, cy - r);
    path.quadraticBezierTo(
      (leftEdge + rightEdge) / 2,
      cy - midH / 2,
      rightEdge - r,
      cy - r,
    );

    // Draw right semi-circle
    path.arcTo(
      Rect.fromCircle(center: rightCenter, radius: r),
      -math.pi / 2,
      math.pi,
      false,
    );

    // Bottom gooey line connecting right to left
    path.quadraticBezierTo(
      (leftEdge + rightEdge) / 2,
      cy + midH / 2,
      leftEdge + r,
      cy + r,
    );

    path.close();

    // Premium Water Droplet styling
    // 1. Shadow for depth
    final shadowPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.04)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
    canvas.drawPath(path, shadowPaint);

    // 2. Liquid body fill with dynamic gradient based on color theme
    final fillGradient = LinearGradient(
      colors: [
        AppColors.primary.withOpacity(0.12),
        AppColors.secondary.withOpacity(0.12),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    final fillPaint = Paint()
      ..shader = fillGradient.createShader(
        Rect.fromLTRB(leftEdge, cy - h / 2, rightEdge, cy + h / 2),
      )
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. Water droplet outline border with gradient
    final borderGradient = LinearGradient(
      colors: [
        AppColors.primary.withOpacity(0.35),
        AppColors.secondary.withOpacity(0.35),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    final borderPaint = Paint()
      ..shader = borderGradient.createShader(
        Rect.fromLTRB(leftEdge, cy - h / 2, rightEdge, cy + h / 2),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    canvas.drawPath(path, borderPaint);

    // 4. Subtle glossy shine highlight (small white reflection) at the top-left
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.45)
      ..style = PaintingStyle.fill;
    
    final shineLeft = leftEdge + r * 0.7;
    final shineTop = cy - h * 0.35;
    final shineWidth = (currentWidth * 0.25).clamp(8.0, 16.0);
    const shineHeight = 2.5;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(shineLeft, shineTop, shineWidth, shineHeight),
        const Radius.circular(1.2),
      ),
      shinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LiquidDropletPainter oldDelegate) {
    return oldDelegate.prevIndex != prevIndex ||
        oldDelegate.currentIndex != currentIndex ||
        oldDelegate.progress != progress ||
        oldDelegate.tabWidth != tabWidth;
  }
}

// =========================================================================
// Premium Contact CTA Button with slide-on-hover arrow
// =========================================================================

class _ContactCTAButton extends StatefulWidget {
  final VoidCallback onTap;

  const _ContactCTAButton({required this.onTap});

  @override
  State<_ContactCTAButton> createState() => _ContactCTAButtonState();
}

class _ContactCTAButtonState extends State<_ContactCTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: _isHovered
          ? [const Color(0xFF1D5A48), AppColors.accent]
          : [AppColors.primary, const Color(0xFF1D5A48)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.04 : 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(_isHovered ? 0.22 : 0.08),
                blurRadius: _isHovered ? 14 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.t(context, 'contactMe'),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                transform: Matrix4.translationValues(_isHovered ? 3.0 : 0.0, 0.0, 0.0),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
