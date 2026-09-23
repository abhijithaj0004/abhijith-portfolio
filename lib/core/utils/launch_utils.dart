import 'package:url_launcher/url_launcher.dart';

class LaunchUtils {
  LaunchUtils._();

  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }
}
