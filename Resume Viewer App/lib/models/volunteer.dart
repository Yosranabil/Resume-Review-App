class Volunteer {
  final String organization;
  final String summary;

  Volunteer({
    required this.organization,
    required this.summary,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      organization: json["organization"] ?? "",
      summary: json["summary"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'organization': organization,
    'summary': summary,
  };
}
}
