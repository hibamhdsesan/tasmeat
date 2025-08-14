import 'package:tesmeat_app/model/hadeth_model.dart';

class Book {
  final int id;
  final String title;
  final String description;
  final String author;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<Hadith> hadiths;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
    this.updatedAt,
    required this.hadiths,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      hadiths: (json['hadiths'] as List)
          .map((e) => Hadith.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'hadiths': hadiths.map((e) => e.toJson()).toList(),
    };
  }
}
