import 'basics.dart';
import 'projects.dart';
import 'volunteer.dart';
import 'skills.dart';

class Resume {
  final Basics basics;
  final List<Projects> projects;
  final List<Volunteer> volunteer;
  final List<Skills> skills;

  Resume({
    required this.basics,
    required this.projects,
    required this.volunteer,
    required this.skills,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      basics: Basics.fromJson(json["basics"] ?? {}),
      projects: (json["projects"] as List<dynamic>? ?? [])
          .map((e) => Projects.fromJson(e))
          .toList(),
      volunteer: (json["volunteer"] as List<dynamic>? ?? [])
          .map((e) => Volunteer.fromJson(e))
          .toList(),
      skills: (json["skills"] as List<dynamic>? ?? [])
          .map((e) => Skills.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'basics': basics.toJson(),
    'projects': projects.map((project) => project.toJson()).toList(),
    'volunteer': volunteer.map((vol) => vol.toJson()).toList(),
    'skills': skills.map((skill) => skill.toJson()).toList(),
  };
}
}
