import 'dart:convert';
import 'package:flutter/services.dart';
import 'resume_service.dart';
import '../models/resume.dart';

class ResumeLoad {
  static Future<Resume> loadResume(String githubUrl) async {
    // Load local JSON
    final local = await rootBundle.loadString("assets/resume.json");
    Map<String, dynamic> jsonMap = jsonDecode(local);

    // Fetch GitHub JSON
    final online = await GitHubService.fetchResume(githubUrl);

    if (online != null) {
      jsonMap = online; // replace w/ GitHub version
    }

    return Resume.fromJson(jsonMap);
  }
}
