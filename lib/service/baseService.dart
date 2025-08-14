import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class BaseService {
  static final Dio dio = Dio(BaseOptions(
  baseUrl: 'https://alhekmah-server-side.onrender.com/',
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
))..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // منع إضافة Authorization لطلبات login أو refresh
      if (!options.path.contains('/auth/login') && !options.path.contains('/auth/refresh')) {
        final box = Hive.isBoxOpen('tokens') 
            ? Hive.box('tokens') 
            : await Hive.openBox('tokens');

        final accessToken = box.get('access_token');
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
      }
      return handler.next(options);
    },
    onError: (DioError e, handler) async {
      final requestPath = e.requestOptions.path;

      if (e.response?.statusCode == 401 &&
          requestPath != '/auth/login' &&
          requestPath != '/auth/refresh' &&
          e.requestOptions.extra['retried'] != true) {
        
        final box = Hive.isBoxOpen('tokens') 
            ? Hive.box('tokens') 
            : await Hive.openBox('tokens');
        final refreshToken = box.get('refresh_token');

        if (refreshToken != null) {
          try {
            final response = await dio.post('/auth/refresh',
                data: {'refresh_token': refreshToken});

            final newAccess = response.data['access_token'];
            final newRefresh = response.data['refresh_token'];

            await box.put('access_token', newAccess);
            await box.put('refresh_token', newRefresh);

            final opts = e.requestOptions;
            opts.headers['Authorization'] = 'Bearer $newAccess';
            opts.extra['retried'] = true;

            final cloneReq = await dio.fetch(opts);
            return handler.resolve(cloneReq);
          } catch (err) {
            await box.clear(); // حذف التوكنات إذا فشل الريفرش
            return handler.reject(err as DioError);
          }
        }
      }

      return handler.next(e);
    },
  ));

}
