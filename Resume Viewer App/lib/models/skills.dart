class Skills {
  final String name;
  final List<String> keywords;

  Skills({
    required this.name,
    required this.keywords,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      name: json["name"] ?? "",
      keywords: List<String>.from(json["keywords"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'keywords': keywords,
    };
  }
}
