import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_assets.dart';
import '../../core/l10n/locale_scope.dart';
import '../../core/animations/glass_box.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onBackToTopPressed;

  const FooterSection({
    super.key,
    required this.onBackToTopPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.textSecondary.withOpacity(0.1),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              if (isMobile) {
                return Column(
                  children: [
                    // Logo/Name branding
                    Text(
                    AppConstants.developerName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontFamily: 'Outfit',
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Social Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon(
                          url: AppConstants.githubUrl,
                          child: Image.asset(
                            AppAssets.githubIcon,
                            width: 20,
                            height: 20,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildSocialIcon(
                          url: AppConstants.linkedinUrl,
                          child: Image.asset(
                            AppAssets.linkedinIcon,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildSocialIcon(
                          url: 'mailto:${AppConstants.email}',
                          child: const Icon(
                            Icons.alternate_email,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Back to top floating indicator
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onBackToTopPressed,
                        child: GlassBox(
                          animateHover: true,
                          borderRadius: 8,
                          padding: EdgeInsets.zero,
                          width: 38,
                          height: 38,
                          borderColor: AppColors.primary.withOpacity(0.3),
                          child: const Center(
                            child: Icon(Icons.arrow_upward, size: 16, color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo/Name branding
                  Text(
                    AppConstants.developerName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: 'Outfit',
                      letterSpacing: 1.5,
                    ),
                  ),

                  // Social Icons
                  Row(
                    children: [
                      _buildSocialIcon(
                        url: AppConstants.githubUrl,
                        child: Image.asset(
                          AppAssets.githubIcon,
                          width: 20,
                          height: 20,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildSocialIcon(
                        url: AppConstants.linkedinUrl,
                        child: Image.asset(
                          AppAssets.linkedinIcon,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      _buildSocialIcon(
                        url: 'mailto:${AppConstants.email}',
                        child: const Icon(
                          Icons.alternate_email,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  // Back to top floating indicator
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onBackToTopPressed,
                      child: GlassBox(
                        animateHover: true,
                        borderRadius: 8,
                        padding: EdgeInsets.zero,
                        width: 38,
                        height: 38,
                        borderColor: AppColors.primary.withOpacity(0.3),
                        child: const Center(
                          child: Icon(Icons.arrow_upward, size: 16, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          // Copyright notice
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              if (isMobile) {
                return Column(
                  children: [
                    Text(
                      '© ${DateTime.now().year} ${AppConstants.developerName}.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.t(context, 'footerNote'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© ${DateTime.now().year} ${AppConstants.developerName}.',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    S.t(context, 'footerNote'),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({required Widget child, required String url}) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: child,
      ),
    );
  }
}
