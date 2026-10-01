class AzkarItem {
  const AzkarItem({
    required this.category,
    required this.content,
    required this.count,
    required this.description,
    required this.reference,
  });

  final String category;
  final String content;
  final String count;
  final String description;
  final String reference;

  factory AzkarItem.fromJson(Map<String, dynamic> json) {
    return AzkarItem(
      category: (json['category'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      count: (json['count'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      reference: (json['reference'] ?? '').toString(),
    );
  }
}
