import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/l10n/locale_scope.dart';
import '../../core/widgets/section_header.dart';
import '../../core/animations/glass_box.dart';
import '../../core/widgets/gradient_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSending = true);
      
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 1000));
      
      if (!mounted) return;
      setState(() => _isSending = false);

      // Build WhatsApp message content
      final message = '${S.t(context, 'contactHeadline')}\n\n'
          '*Name:* ${_nameController.text}\n'
          '*Email:* ${_emailController.text}\n'
          '*Subject:* ${_subjectController.text}\n'
          '*Message:* ${_messageController.text}';

      final uri = Uri(
        scheme: 'mailto',
        path: AppConstants.email,
        queryParameters: {
          'subject': _subjectController.text,
          'body': message,
        },
      );

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }

      if (!mounted) return;

      // Show success popup
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.background,
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.primary),
              const SizedBox(width: 10),
              Text(
                S.t(context, 'mailOpened'),
                style: const TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
              ),
            ],
          ),
          content: Text(
            S.t(context, 'mailOpenedBody'),
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nameController.clear();
                _emailController.clear();
                _subjectController.clear();
                _messageController.clear();
              },
              child: const Text('OK', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      );
    }
  }

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
            title: S.t(context, 'contactTitle'),
            subtitle: S.t(context, 'contactEyebrow'),
          ),
          const SizedBox(height: 50),

          ResponsiveLayout(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _buildContactDetails(context)),
                const SizedBox(width: 50),
                Expanded(flex: 7, child: _buildContactForm(context)),
              ],
            ),
            mobile: Column(
              children: [
                _buildContactDetails(context),
                const SizedBox(height: 40),
                _buildContactForm(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          S.t(context, 'contactHeadline'),
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SelectableText(
          S.t(context, 'contactLede'),
          style: textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),

        // Info Cards
        _buildInfoRow(Icons.email, S.t(context, 'emailMe'), AppConstants.email, 'mailto:${AppConstants.email}'),
        const SizedBox(height: 16),
        _buildInfoRow(Icons.location_on, S.t(context, 'location'), AppConstants.address, null),
        
        const SizedBox(height: 40),
        
        // Social networks horizontal links
        Row(
          children: [
            _buildSocialSquare(Icons.code, AppConstants.githubUrl),
            const SizedBox(width: 12),
            _buildSocialSquare(Icons.business_center, AppConstants.linkedinUrl),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.05);
  }

  Widget _buildInfoRow(IconData icon, String title, String val, String? url) {
    return GestureDetector(
      onTap: url != null
          ? () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            }
          : null,
      child: GlassBox(
        animateHover: url != null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderColor: AppColors.glassBorderBlue,
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    val,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialSquare(IconData icon, String url) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: GlassBox(
        animateHover: true,
        borderRadius: 8,
        width: 44,
        height: 44,
        padding: EdgeInsets.zero,
        borderColor: AppColors.primary.withOpacity(0.3),
        child: Center(
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return GlassBox(
      borderColor: AppColors.glassBorder,
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.t(context, 'sendMessage'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 24),

            // Form Rows
            if (ResponsiveLayout.isMobile(context)) ...[
              _buildTextField(
                controller: _nameController,
                label: S.t(context, 'name'),
                hint: S.t(context, 'yourName'),
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: S.t(context, 'email'),
                hint: 'your.email@gmail.com',
                icon: Icons.email,
                validator: (val) {
                  if (val == null || val.isEmpty) return S.t(context, 'required');
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
            ] else
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _nameController,
                      label: S.t(context, 'name'),
                      hint: S.t(context, 'yourName'),
                      icon: Icons.person,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _emailController,
                      label: S.t(context, 'email'),
                      hint: 'your.email@gmail.com',
                      icon: Icons.email,
                      validator: (val) {
                        if (val == null || val.isEmpty) return S.t(context, 'required');
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _subjectController,
              label: S.t(context, 'subject'),
              hint: S.t(context, 'subjectHint'),
              icon: Icons.topic,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _messageController,
              label: S.t(context, 'message'),
              hint: S.t(context, 'messageHint'),
              icon: Icons.chat,
              maxLines: 5,
            ),
            const SizedBox(height: 32),

            // Submit button
            _isSending
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : GradientButton(
                    text: S.t(context, 'send'),
                    icon: Icons.send,
                    onPressed: _submitForm,
                  ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.05);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator ?? (val) => val == null || val.isEmpty ? S.t(context, 'required') : null,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 12),
        prefixIcon: Icon(icon, color: AppColors.primary.withOpacity(0.6), size: 16),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.textSecondary.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}
