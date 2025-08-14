class Hadith {
  final int id;
  final int bookId;
  final String title;
  final String content;
  final String raawi;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Hadith({
    required this.id,
    required this.bookId,
    required this.title,
    required this.content,
    required this.raawi,
    required this.createdAt,
    this.updatedAt,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'],
      bookId: json['book_id'],
      title: json['title'],
      content: json['content'],
      raawi: json['raawi'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_id': bookId,
      'title': title,
      'content': content,
      'raawi': raawi,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
