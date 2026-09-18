import 'dart:html' as html;
import '../constants/app_assets.dart';

Future<void> downloadResumeImpl() async {
  // In Flutter Web, local assets are served under 'assets/assets/'
  html.AnchorElement(href: AppAssets.resumePdfWeb)
    ..setAttribute('download', 'Paulo_Moura_Martins_Resume.pdf')
    ..click();
}
