import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tesmeat_app/model/hadeth_model.dart';
import 'package:tesmeat_app/service/baseService.dart';

class BackendService {
  final Dio dio = BaseService.dio;

  Future<String?> uploadAudioFromHadith({
    required String filePath,
    required Hadith hadith, // استلمي الـ Hadith object مباشرة
    required String authToken,
  }) async {
    try {
      print("🔹 بدء رفع الملف...");
      File audioFile = File(filePath);

      if (!audioFile.existsSync()) {
        print("❌ الملف غير موجود: $filePath");
        return null;
      }

      String fileName = audioFile.path.split('/').last;
      print("🔹 اسم الملف: $fileName");

      // إعداد FormData حسب متطلبات الباك إند
      FormData formData = FormData.fromMap({
        'hadith_id': hadith.bookId, // بدل 'id'
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      print("🔹 إعداد البيانات للإرسال: ${formData.fields}");

      final response = await dio.post(
        "/audio/upload",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Accept': 'application/json',
          },
        ),
      );

      print("🔹 الرد من السيرفر: ${response.statusCode}");
      print("🔹 بيانات الرد: ${response.data}");

      if (response.statusCode == 200) {
        print("✅ تم رفع الملف بنجاح!");
        return response.data['audio_url']; 
      } else {
        print("❌ خطأ في الرد من السيرفر: ${response.statusCode}");
        return null;
      }
    } catch (e, stackTrace) {
      print("❌ خطأ في رفع الملف: $e");
      print(stackTrace);
      return null;
    }
  }

Future<List<String>> getAllAudios({required String authToken}) async {
  try {
    final response = await dio.get(
      "/audio/my-uploads",
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data
          .map((item) => item['file_path']?.toString() ?? "غير متوفر")
          .toList();
    } else {
      print("❌ خطأ في الرد: ${response.statusCode}");
      return [];
    }
  } catch (e, stackTrace) {
    print("❌ خطأ في جلب الأصوات: $e");
    print(stackTrace);
    return [];
  }
}

}
