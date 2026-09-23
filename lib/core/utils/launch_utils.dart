import 'package:url_launcher/url_launcher.dart';

class LaunchUtils {
  LaunchUtils._();

  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    // Note: deliberately NOT awaiting canLaunchUrl() first — on web that
    // extra await happens *after* the click event finishes, which makes
    // Chrome/Safari treat the resulting window.open() as an unrequested
    // pop-up and silently block it. Calling launchUrl directly keeps it
    // inside the click's "user gesture" window so the tab actually opens.
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}