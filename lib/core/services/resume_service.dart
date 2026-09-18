import 'resume_service_stub.dart'
    if (dart.library.html) 'resume_service_web.dart'
    if (dart.library.io) 'resume_service_mobile.dart';

abstract class ResumeService {
  static Future<void> downloadResume() => downloadResumeImpl();
}
