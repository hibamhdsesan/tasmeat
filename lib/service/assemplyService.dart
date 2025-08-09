import 'dart:io';
import 'package:dio/dio.dart';

class AssemblyAIService {
  final Dio dio = Dio();
  final String apiKey = 'a64c623c40ed4d2fa62184c17adc725e';

  AssemblyAIService() {
    dio.options.headers = {
      'authorization': apiKey,
      'content-type': 'application/json',
    };
  }

  /// رفع ملف الصوت إلى AssemblyAI (upload endpoint)
  Future<String?> uploadAudioFile(String filePath) async {
    final file = File(filePath);
    final fileLength = await file.length();

    final response = await dio.post(
      'https://api.assemblyai.com/v2/upload',
      data: file.openRead(),
      options: Options(
        headers: {
          'authorization': apiKey,
          'transfer-encoding': 'chunked',
          'content-length': fileLength,
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data['upload_url'] as String?;
    } else {
      return null;
    }
  }

  /// طلب التفريغ النصي (transcription) بناءً على رابط الصوت المرفوع
  Future<String?> requestTranscription(String audioUrl) async {
    final response = await dio.post(
      'https://api.assemblyai.com/v2/transcript',
      data: {
        'audio_url': audioUrl,
        "language_code": "ar"
      },
    );

    if (response.statusCode == 200) {
      return response.data['id'] as String?;
    }
    return null;
  }

  /// استعلام حالة التفريغ النصي واسترجاع النص النهائي
  Future<String?> getTranscriptionResult(String transcriptId) async {
    while (true) {
      final response = await dio.get(
        'https://api.assemblyai.com/v2/transcript/$transcriptId',
      );

      if (response.statusCode == 200) {
        final status = response.data['status'];
        if (status == 'completed') {
          return response.data['text'] as String;
        } else if (status == 'error') {
          return null;
        } else {
          // الانتظار قليلاً قبل الاستعلام مجدداً
          await Future.delayed(Duration(seconds: 3));
        }
      } else {
        return null;
      }
    }
  }
}
