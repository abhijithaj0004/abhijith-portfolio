import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/launch_utils.dart';
import '../../data/services/contact_service.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/highlights_section.dart';
import '../widgets/architecture_section.dart';
import '../widgets/resume_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final ContactService _contactService = MockContactService();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isScrolled = _scrollController.offset > 12;
      if (isScrolled != _scrolled) {
        setState(() => _scrolled = isScrolled);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    final navItems = [
      NavItem('Home', _homeKey),
      NavItem('About', _aboutKey),
      NavItem('Skills', _skillsKey),
      NavItem('Experience', _experienceKey),
      NavItem('Projects', _projectsKey),
      NavItem('Contact', _contactKey),
    ];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(key: _homeKey),
                HeroSection(
                  reduceMotion: reduceMotion,
                  onViewWork: () => _scrollTo(_projectsKey),
                  onDownloadResume: () => LaunchUtils.openUrl(AppConstants.resumeAssetPath),
                  onContact: () => _scrollTo(_contactKey),
                ),
                AboutSection(sectionKey: _aboutKey, reduceMotion: reduceMotion),
                SkillsSection(sectionKey: _skillsKey, reduceMotion: reduceMotion),
                ExperienceSection(sectionKey: _experienceKey, reduceMotion: reduceMotion),
                ProjectsSection(sectionKey: _projectsKey, reduceMotion: reduceMotion),
                HighlightsSection(sectionKey: UniqueKey(), reduceMotion: reduceMotion),
                ArchitectureSection(sectionKey: UniqueKey(), reduceMotion: reduceMotion),
                ResumeSection(sectionKey: UniqueKey()),
                ContactSection(sectionKey: _contactKey, contactService: _contactService),
                FooterSection(onBackToTop: _scrollToTop),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              items: navItems,
              scrolled: _scrolled,
              onResumeTap: () => LaunchUtils.openUrl(AppConstants.resumeAssetPath),
            ),
          ),
        ],
      ),
    );
  }
}
