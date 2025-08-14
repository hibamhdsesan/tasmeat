import 'package:dio/dio.dart';
import 'package:tesmeat_app/model/user_model.dart';
import 'package:tesmeat_app/service/baseService.dart';

class AuthService {
  final Dio dio = BaseService.dio;

  Future<void> signUp(UserModel request) async {
    const endpoint = "/auth/register"; // المسار الخاص بالتسجيل
    try {
      final response = await dio.post(
        endpoint,
        data: request.toJson(),
      );
      print("تم التسجيل بنجاح: ${response.data}");
    } on DioError catch (e) {
      print("خطأ في التسجيل: ${e.response?.data ?? e.message}");
      rethrow;
    }
  }
}
