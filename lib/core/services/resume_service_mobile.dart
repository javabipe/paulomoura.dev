import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';

Future<void> downloadResumeImpl() async {
  final Uri url = Uri.parse(AppConstants.resumeUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
