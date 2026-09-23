import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/constants/app_constants.dart';
import 'presentation/home/home_page.dart';

final ThemeController themeController = ThemeController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  themeController.load();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp(
          title: AppConstants.pageTitle,
          debugShowCheckedModeBanner: false,
          themeMode: themeController.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          home: const HomePage(),
        );
      },
    );
  }
}
