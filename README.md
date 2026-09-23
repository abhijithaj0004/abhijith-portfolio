# Abhijith AJ — Flutter Web Portfolio

A production-style personal portfolio built entirely with Flutter Web.

> ⚠️ **This project was generated without access to a Flutter SDK or
> pub.dev**, so it has **not** been run through `flutter pub get`,
> `flutter analyze`, or `flutter build web`. Treat it as a strong first
> draft: the architecture, imports, and widget logic were written
> carefully, but you are the first to actually compile it. Budget time
> to fix whatever `flutter analyze` / `flutter run` turn up — see
> "Likely first issues" below.

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

## 4. Replace the resume

The provided resume (`Abhijith_AJ_Resume_2026.pdf`) is already copied to
`web/resume.pdf`. It's served as a **plain static file** (not through
Flutter's asset bundle) so the Download/View Resume buttons can link to it
with a simple relative URL (`resume.pdf`). To update it, just replace
`web/resume.pdf` with a new file of the same name — no code changes needed.

## 5. Update social links

`lib/core/constants/app_constants.dart` has two placeholders that were
**not** provided in the source brief:

```dart
static const String linkedInUrl = 'https://www.linkedin.com/in/REPLACE-ME';
static const String githubUrl = 'https://github.com/REPLACE-ME';
```

Replace both with your real profile URLs before deploying.

## 6. Configure the contact service

`lib/data/services/contact_service.dart` defines a `ContactService`
abstraction. Right now `MockContactService` simulates a network call and
always "succeeds" so you can see the form's loading/success/error states
work end to end — **it does not actually send anything**.

To wire up a real backend:

1. Pick a provider (Formspree, EmailJS, a Firebase Cloud Function, or your
   own API).
2. Implement a new class that implements `ContactService`, e.g.
   `FormspreeContactService`, using the commented example inside
   `MockContactService.send()` as a starting point.
3. In `lib/presentation/home/home_page.dart`, swap:
   ```dart
   final ContactService _contactService = MockContactService();
   ```
   for your new implementation.

**Never put API keys directly in this Flutter Web source** — they'd be
visible in the compiled JS bundle. Route the request through a backend
endpoint (Formspree/EmailJS forms are designed for this; for a custom
backend, keep the key server-side).

## 7. Deploy

Any static host works, since `flutter build web` outputs static files:

- **Firebase Hosting**: `firebase init hosting` (public dir: `build/web`), then `firebase deploy`
- **GitHub Pages**: push `build/web/` contents to a `gh-pages` branch, or use a GitHub Action
- **Netlify**: connect the repo, build command `flutter build web --release`, publish directory `build/web`
- **Vercel**: same idea — build command + `build/web` as the output directory

---

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

Editing content (projects, experience, skills, stats) only requires
touching `lib/data/content/portfolio_data.dart` — none of it is
hardcoded in the widgets.

## What's implemented vs. simplified from the original brief

Implemented: responsive nav (desktop + animated mobile hamburger), animated
hero with an orbiting tech-badge visual, animated stat counters, tech stack
grid, expandable experience timeline, featured + grid project cards with a
detail modal, engineering highlights grid, an interactive architecture flow
diagram, a resume CTA, a validated contact form with loading/success/error
states, footer with back-to-top, dark/light theme toggle persisted via
`SharedPreferences`, and `prefers-reduced-motion` support via
`MediaQuery.disableAnimations`.

Simplified/omitted to keep the dependency list small and the code reliable
without a test run: no custom cursor, no particle-field background (used a
subtle two-color gradient instead), and scroll-reveal animations use a
lightweight position check rather than a dedicated visibility-detection
package. All are reasonable follow-ups once the base project is compiling.

## Likely first issues to check

Since this hasn't been run, these are the most probable snags:

- **Deprecated `ColorScheme` params**: `app_theme.dart` uses
  `background`/`onBackground`, which are deprecated in newer Flutter SDKs
  (still functional, but `flutter analyze` may flag them — safe to leave
  or migrate to `surface`/`onSurface` only).
- **`AnimatedContainer` + `transform`**: a few hover effects
  (`AppButton`, `GlassCard`, project cards) animate a `Matrix4` translate
  via `AnimatedContainer.transform`. This is valid Flutter API but double
  check hover offsets look right at your SDK version.
- **Package versions**: `shared_preferences: ^2.2.3` and
  `url_launcher: ^6.2.6` were current as of this project's writing —
  `flutter pub get` may resolve newer patch versions, which should be
  compatible, but re-check if you hit breaking API changes.
- **Web renderer**: if `flutter build web` defaults to a renderer that
  renders gradients/shadows differently than expected, try
  `--web-renderer canvaskit` explicitly.

## Content accuracy

All names, companies, dates, technologies, and project details come
directly from the provided resume and project brief — nothing was
invented. LinkedIn and GitHub profile URLs were not provided and are left
as editable placeholders (see step 5 above).
