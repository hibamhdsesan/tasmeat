
import 'package:tesmeat_app/model/book_model.dart';
import 'package:tesmeat_app/model/hadeth_model.dart';
import 'package:tesmeat_app/service/baseService.dart';

class HadithService {
  Future<List<Hadith>> fetchHadithsByBookId(int bookId) async {
    try {
      final response = await BaseService.dio.get('/books');
      final List data = response.data;

      // نعمل parsing للـ books
      final books = data.map((e) => Book.fromJson(e)).toList();

      // نلاقي الكتاب المطلوب
      final book = books.firstWhere((b) => b.id == bookId);

      return book.hadiths;
    } catch (e) {
      throw Exception('Failed to load hadiths: $e');
    }
  }
}
