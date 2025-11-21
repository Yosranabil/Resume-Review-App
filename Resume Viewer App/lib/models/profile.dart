class Profile {
  final String network;
  final String url;

  Profile({
    required this.network,
    required this.url,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      network: json["network"] ?? "",
      url: json["url"] ?? "",
    );
  }
}
