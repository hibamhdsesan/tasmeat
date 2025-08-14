
import 'package:dio/dio.dart';
import 'package:tesmeat_app/model/book_model.dart';
import 'package:tesmeat_app/service/baseService.dart';

class BookService {
  final Dio dio = BaseService.dio; // استخدمنا Dio من BaseService

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await dio.get('/books'); // المسار اللي بيرجع الريسبونس
      final List data = response.data;
      return data.map((e) => Book.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }
}
