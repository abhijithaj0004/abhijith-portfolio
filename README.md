# Abhijith AJ — Flutter Web Portfolio

A production-style personal portfolio built entirely with Flutter Web.

---

## 1. Install dependencies

```bash
flutter --version   # tested against Flutter 3.22+ / Dart 3.3+
flutter pub get
```

## 2. Run locally

```bash
flutter run -d chrome
```

## 3. Build for web

```bash
flutter build web --release
```

Output goes to `build/web/`.

## Project structure

```
lib/
├── core/
│   ├── theme/        # AppColors, AppTypography, AppTheme, ThemeController
│   ├── constants/     # Contact info, links, page metadata
│   ├── responsive/     # Breakpoints + ResponsiveBuilder
│   ├── animations/    # ScrollReveal, AnimatedCounter
│   └── utils/          # url_launcher wrapper
├── data/
│   ├── models/        # Project, ExperienceItem, SkillCategory, SocialLink
│   ├── services/       # ContactService abstraction
│   └── content/         # PortfolioData — all real copy, sourced from the resume
├── presentation/
│   ├── home/            # HomePage — assembles every section
│   └── widgets/         # One file per section + a widgets/common/ folder
│       └── common/       # AppButton, GlassCard, SectionTitle, ResponsiveContainer, SocialButton
└── main.dart
```

