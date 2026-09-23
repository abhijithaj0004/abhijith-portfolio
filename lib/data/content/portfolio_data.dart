import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/experience_item.dart';
import '../models/skill.dart';
import '../models/social_link.dart';
import '../../core/constants/app_constants.dart';

/// Single source of truth for portfolio content. Nothing here is invented —
/// every fact traces back to the resume / project brief. Edit this file to
/// update copy without touching UI widgets.
class PortfolioData {
  PortfolioData._();

  static const String aboutSummary =
      "I build production Flutter applications — not just screens. Over "
      "2+ years I've shipped apps end-to-end across gaming, dating/social, "
      "audiobook, and astrology domains, owning architecture, real-time "
      "features, and performance work along the way. I work in MVVM and "
      "Clean Architecture, lean on Provider, BLoC, and GetX for state, and "
      "care about the details that separate a working app from a good "
      "one: responsive layouts, reusable components, and rendering "
      "performance on low-end devices.";

  static const List<Map<String, String>> stats = [
    {'value': '2+', 'label': 'Years Experience'},
    {'value': '5+', 'label': 'Featured Projects'},
    {'value': '1000+', 'label': 'Game Templates'},
    {'value': '50%', 'label': 'Rendering Performance Improvement'},
  ];

  static const List<SkillCategory> skillCategories = [
    SkillCategory(title: 'Languages', icon: Icons.code, skills: ['Dart']),
    SkillCategory(
        title: 'Framework', icon: Icons.flutter_dash, skills: ['Flutter']),
    SkillCategory(
      title: 'Architecture',
      icon: Icons.architecture,
      skills: ['MVVM', 'Clean Architecture', 'Repository Pattern'],
    ),
    SkillCategory(
      title: 'State Management',
      icon: Icons.account_tree_outlined,
      skills: ['Provider', 'BLoC', 'GetX'],
    ),
    SkillCategory(
      title: 'Backend & APIs',
      icon: Icons.cloud_outlined,
      skills: ['REST APIs', 'Firebase', 'Dio', 'Socket.io'],
    ),
    SkillCategory(
      title: 'Database & Storage',
      icon: Icons.storage_outlined,
      skills: ['Hive', 'SharedPreferences'],
    ),
    SkillCategory(
      title: 'Tools',
      icon: Icons.build_outlined,
      skills: [
        'Git',
        'GitHub',
        'Android Studio',
        'VS Code',
        'Figma',
        'Claude',
        'ChatGPT',
      ],
    ),
    SkillCategory(
      title: 'Other',
      icon: Icons.extension_outlined,
      skills: [
        'Agora',
        'Flutter Flame',
        'Responsive UI',
        'RTL Localization',
        'Audio/Video Playback',
        'In-App Purchases',
      ],
    ),
  ];

  static const List<ExperienceItem> experience = [
    ExperienceItem(
      company: 'Trilia Solutions',
      role: 'Flutter Developer',
      location: 'Kerala',
      period: 'Oct 2025 – Mar 2026',
      responsibilities: [
        'Built EverQpid, a dating application, independently from architecture through Play Store release as the sole Flutter developer.',
        'Developed the customer-facing Astro application for an astrology platform alongside a companion admin web application.',
        'Contributed to ShutterX through feature development and bug fixes.',
        'Developed real-time communication features using Socket.io and Agora.',
        'Integrated Firebase Authentication, REST APIs, and Dio using MVVM architecture.',
        'Designed reusable widgets and modular UI components.',
        'Collaborated with backend developers to integrate APIs and resolve production issues.',
        'Optimized application performance and responsiveness through refactoring.',
      ],
    ),
    ExperienceItem(
      company: 'Dreamloop.ai',
      role: 'Flutter Developer',
      location: 'Kerala',
      period: 'Nov 2023 – Sep 2025',
      responsibilities: [
        'Developed core modules for Max2D, a no-code visual game engine, using Flutter and Flutter Flame.',
        'Engineered event systems, asset management, and interactive controls.',
        'Supported 1,000+ customizable game templates.',
        'Improved rendering performance by up to 50% on low-end devices.',
        'Designed UI and integrated advanced audio playback features for NovelFM.',
        'Implemented RTL localization and responsive layouts.',
        'Connected applications to REST APIs using Provider.',
        'Implemented project import/export functionality.',
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'EverQpid',
      category: 'Dating / Social App',
      company: 'Trilia Solutions',
      description:
          'A production dating/social application developed independently '
          'end-to-end.',
      technologies: ['Flutter', 'Firebase', 'REST API', 'Socket.io', 'Dio', 'MVVM'],
      highlights: ['Built independently from architecture to Play Store release.'],
      role: 'Sole Flutter Developer',
      architecture: 'MVVM',
      contributions: [
        'Architecture and end-to-end build',
        'Firebase Authentication integration',
        'Real-time features via Socket.io',
        'REST API integration with Dio',
      ],
      impact: 'Shipped independently to the Play Store.',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.everqpid.customerapp',
    ),
    Project(
      title: 'Max2D',
      category: 'No-Code Game Engine',
      company: 'Dreamloop.ai',
      description:
          'A visual no-code game engine allowing users to create '
          'customizable games.',
      technologies: ['Flutter', 'Flutter Flame'],
      highlights: [
        '1,000+ customizable game templates',
        'Event systems',
        'Actions',
        'Controls',
        'Asset management',
        'Project import/export',
        'Performance optimization',
        'Rendering optimization',
      ],
      role: 'Flutter Developer',
      architecture: 'Modular Flutter architecture',
      contributions: [
        'Event system',
        'Actions',
        'Controls',
        'Asset management',
        'Project import/export',
        'Rendering optimization',
      ],
      impact: 'Up to 50% rendering performance improvement on low-end devices, '
          'supporting 1,000+ customizable game templates.',
      playStoreUrl: 'https://play.google.com/store/search?q=max2d&c=apps',
      featured: true,
    ),
    Project(
      title: 'NovelFM',
      category: 'Novel Reading / Audiobook',
      company: 'Dreamloop.ai',
      description:
          'A novel-reading and audiobook application with responsive '
          'layouts and advanced audio playback functionality.',
      technologies: ['Flutter', 'Provider', 'REST API', 'Audio playback'],
      highlights: [
        'Audio playback',
        'Novel reading',
        'REST API integration',
        'Responsive UI',
        'RTL localization',
      ],
      role: 'Flutter Developer',
      contributions: [
        'UI design',
        'Advanced audio playback integration',
        'RTL localization',
        'Responsive layouts',
      ],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.novelfm.novel',
    ),
        Project(
      title: 'Astro',
      category: 'Astrology App',
      company: 'Trilia Solutions',
      description:
          'A customer-facing astrology platform app with a companion '
          'admin web application, supporting live pooja broadcasts, '
          'slot booking, and one-to-one consultation calls.',
      technologies: ['Flutter', 'MVVM', 'Dio', 'Provider', 'Agora'],
      highlights: [
        'Live pooja broadcast',
        'Slot booking',
        'One-to-one calls via Agora',
        'Customer + admin web app',
      ],
      role: 'Flutter Developer',
      architecture: 'MVVM',
      contributions: [
        'Customer-facing app development',
        'Live pooja broadcast feature',
        'Slot booking flow',
        'One-to-one audio/video calling via Agora',
        'REST API integration with Dio',
      ],
    ),
    Project(
      title: 'Tickshow',
      category: 'Quiz Application',
      company: 'Freelance Project',
      description:
          'A quiz application independently delivered with authentication, '
          'wallet, payments, leaderboard functionality, and timer-based '
          'scoring.',
      technologies: ['Flutter', 'Provider', 'Razorpay', 'REST API'],
      highlights: [
        'Authentication',
        'Wallet',
        'Payment gateway',
        'Leaderboard',
        'Timer-based scoring',
        'Custom REST APIs',
      ],
      role: 'Independent Developer',
      contributions: [
        'Authentication flow',
        'Wallet and Razorpay payment integration',
        'Leaderboard and timer-based scoring',
        'Custom REST API integration',
      ],
    ),
  ];

  static const List<Map<String, String>> highlights = [
    {
      'title': 'Game Engine Systems',
      'description':
          'Event systems, actions, controls, assets and customizable game templates.',
    },
    {
      'title': 'Real-Time Communication',
      'description': 'Socket.io + Agora based communication.',
    },
    {
      'title': 'Production APIs',
      'description': 'REST APIs, Dio, Firebase authentication.',
    },
    {
      'title': 'Performance Engineering',
      'description': 'Rendering and responsiveness optimization.',
    },
    {
      'title': 'Audio Experiences',
      'description': 'Audio playback and audiobook functionality.',
    },
    {
      'title': 'Responsive UI',
      'description': 'Layouts supporting multiple screen sizes.',
    },
    {
      'title': 'Localization',
      'description': 'RTL localization support.',
    },
    {
      'title': 'Independent Product Delivery',
      'description': 'Apps taken from architecture to production release.',
    },
  ];

  static const List<String> architectureFlow = [
    'UI',
    'State Management (Provider / BLoC)',
    'ViewModel',
    'Repository',
    'Dio / REST API',
    'Backend',
  ];

  static List<SocialLink> socialLinks = [
    SocialLink(
      label: 'GitHub',
      icon: Icons.code,
      url: AppConstants.githubUrl,
    ),
    SocialLink(
      label: 'LinkedIn',
      icon: Icons.business_center_outlined,
      url: AppConstants.linkedInUrl,
    ),
    SocialLink(
      label: 'Email',
      icon: Icons.email_outlined,
      url: 'mailto:${AppConstants.email}',
    ),
  ];
}
