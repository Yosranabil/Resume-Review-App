import 'profile.dart';

class Basics {
  final String name;
  final String label;
  final String phone;
  final String email;
  final List<Profile> profiles;

  Basics({
    required this.name,
    required this.label,
    required this.phone,
    required this.email,
    required this.profiles,
  });

  factory Basics.fromJson(Map<String, dynamic> json) {
    return Basics(
      name: json["name"] ?? "",
      label: json["label"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      profiles: (json["profiles"] as List<dynamic>? ?? [])
          .map((e) => Profile.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'name': name,
    'label': label,
    'email': email,
    'phone': phone,
  };
}
}
