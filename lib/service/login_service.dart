import 'package:tesmeat_app/service/baseService.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class LoginService {
  final Dio dio = BaseService.dio;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      const endpoint = "/auth/login";

      final response = await dio.post(
        endpoint,
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final box = Hive.isBoxOpen('tokens') 
            ? Hive.box('tokens') 
            : await Hive.openBox('tokens');

        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        if (accessToken != null && refreshToken != null) {
          await box.put('access_token', accessToken);
          await box.put('refresh_token', refreshToken);

          return {
            'access_token': accessToken,
            'refresh_token': refreshToken,
          };
        } else {
          throw Exception('فشل تسجيل الدخول: التوكنات غير موجودة');
        }
      } else {
        throw Exception('فشل تسجيل الدخول: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // تمييز خطأ الـ 401 لو حبيت تستخدمه لاحقاً
      if (e.response?.statusCode == 401) {
        throw Exception('بيانات الدخول غير صحيحة');
      }
      throw Exception('خطأ في الاتصال: ${e.message}');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  Future<void> logout() async {
    final box = Hive.isBoxOpen('tokens') 
        ? Hive.box('tokens') 
        : await Hive.openBox('tokens');
    await box.clear();
  }
}
