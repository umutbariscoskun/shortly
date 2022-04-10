class ShortLink {
  final String id;
  final String fullShortLink;
  bool isCopied;

  ShortLink({
    required this.id,
    required this.fullShortLink,
    this.isCopied = false,
  });

  factory ShortLink.fromJson(Map<String, dynamic> json) => ShortLink(
      id: json['code'],
      fullShortLink: json['full_short_link'],
      isCopied: false);
}
