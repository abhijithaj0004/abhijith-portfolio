/// Verified contact info and links from the resume. LinkedIn/GitHub profile
/// URLs were not provided in source material, so they're left as editable
/// placeholders — update them before deploying (see README).
class AppConstants {
  AppConstants._();

  static const String name = 'Abhijith AJ';
  static const String role = 'Flutter Developer';
  static const String tagline =
      'Flutter Developer building production-grade mobile experiences.';
  static const String subTagline =
      '2+ years of experience building cross-platform applications across '
      'gaming, social, audio, and interactive products.';

  static const String email = 'abhijith.aj.dev@gmail.com';
  static const String phone = '+91-7034468049';
  static const String phoneTel = '+917034468049';

 

  static const String linkedInUrl = 'https://www.linkedin.com/in/abhijith-aj-7a28a2254/';
  static const String githubUrl = 'https://github.com/abhijithaj0004';

  // Served as a plain static file from web/resume.pdf (copied verbatim to
  // build/web/resume.pdf on `flutter build web`), rather than through
  // Flutter's asset bundle — this keeps the download/view link a simple,
  // reliable relative URL instead of the bundle's nested asset path.
  static const String resumeAssetPath = 'resume.pdf';

  static const String pageTitle = 'Abhijith AJ | Flutter Developer';
  static const String metaDescription =
      'Abhijith AJ is a Flutter Developer with 2+ years of experience '
      'building production mobile applications across gaming, social, '
      'audio and interactive products.';
}
