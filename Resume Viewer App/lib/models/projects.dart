class Projects {
  final String name;
  final String summary;

  Projects({
    required this.name,
    required this.summary,
  });

  factory Projects.fromJson(Map<String, dynamic> json) {
    return Projects(
      name: json["name"] ?? "",
      summary: json["summary"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'name': name,
    'summary': summary,
  };
}
}
