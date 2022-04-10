class ShortLink {
  final String id;
  final String fullShortLink;

  ShortLink({required this.id, required this.fullShortLink});

  factory ShortLink.fromJson(Map<String, dynamic> json) =>
      ShortLink(id: json['code'], fullShortLink: json['full_short_link']);
}
