import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import '../../core/responsive/responsive.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/launch_utils.dart';
import '../../data/content/portfolio_data.dart';
import '../../data/services/contact_service.dart';
import 'common/section_title.dart';
import 'common/responsive_container.dart';
import 'common/app_button.dart';
import 'common/social_button.dart';

enum _FormStatus { idle, loading, success, error }

class ContactSection extends StatefulWidget {
  final Key sectionKey;
  final ContactService contactService;

  const ContactSection({
    required this.sectionKey,
    required this.contactService,
    super.key,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  _FormStatus _status = _FormStatus.idle;
  String? _feedback;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _status = _FormStatus.loading;
      _feedback = null;
    });

    try {
      final result = await widget.contactService.send(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
      );
      setState(() {
        _status = result.success ? _FormStatus.success : _FormStatus.error;
        _feedback = result.message;
      });
      if (result.success) {
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
        _formKey.currentState?.reset();
      }
    } catch (_) {
      setState(() {
        _status = _FormStatus.error;
        _feedback = 'Something went wrong. Please try again or email me directly.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AppSection(
      sectionKey: widget.sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            eyebrow: 'Contact',
            title: "Let's build something.",
            subtitle: "Have a project, opportunity, or idea? I'd love to hear about it.",
          ),
          const SizedBox(height: 40),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _contactRow(context, Icons.email_outlined, 'Email', AppConstants.email,
                        () => LaunchUtils.openUrl('mailto:${AppConstants.email}')),
                    const SizedBox(height: 20),
                    _contactRow(context, Icons.phone_outlined, 'Phone', AppConstants.phone,
                        () => LaunchUtils.openUrl('tel:${AppConstants.phoneTel}')),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 12,
                      children: PortfolioData.socialLinks
                          .map((link) => SocialButton(link: link))
                          .toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 32 : 0),
              Expanded(
                flex: 3,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _field(context, controller: _nameController, label: 'Name',
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null),
                      const SizedBox(height: 16),
                      _field(
                        context,
                        controller: _emailController,
                        label: 'Email',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Please enter your email';
                          final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
                          return ok ? null : 'Enter a valid email address';
                        },
                      ),
                      const SizedBox(height: 16),
                      _field(context, controller: _subjectController, label: 'Subject',
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a subject' : null),
                      const SizedBox(height: 16),
                      _field(
                        context,
                        controller: _messageController,
                        label: 'Message',
                        maxLines: 5,
                        validator: (v) => (v == null || v.trim().length < 10)
                            ? 'Message should be at least 10 characters'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        label: _status == _FormStatus.loading ? 'Sending...' : 'Send Message',
                        loading: _status == _FormStatus.loading,
                        onPressed: _status == _FormStatus.loading ? null : _submit,
                      ),
                      if (_feedback != null) ...[
                        const SizedBox(height: 14),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              _status == _FormStatus.success
                                  ? Icons.check_circle_outline
                                  : Icons.error_outline,
                              size: 18,
                              color: _status == _FormStatus.success
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _feedback!,
                                style: AppTypography.body(
                                  _status == _FormStatus.success
                                      ? AppColors.success
                                      : AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.label(context.textMuted).copyWith(fontSize: 11)),
                const SizedBox(height: 2),
                Text(value, style: AppTypography.body(context.textPrimary)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: AppTypography.body(context.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTypography.body(context.textMuted),
        filled: true,
        fillColor: context.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: context.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: context.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
