import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tesmeat_app/bloc/sign_up_bloc.dart';
import 'package:tesmeat_app/service/auth_service.dart';
import 'package:tesmeat_app/ui/login.dart';
import 'package:tesmeat_app/ui/recording.dart';
import 'package:tesmeat_app/ui/sign_up1.dart';
import 'package:tesmeat_app/ui/tasmeaa.dart';
import 'package:tesmeat_app/ui/types.dart';

void main() async{

   WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
 

  await Hive.openBox('tokens');

  await Hive.openBox('recordings'); // فتح صندوق لتخزين التسجيلات

  runApp(
  ScreenUtilInit(
    designSize: Size(390, 844),
    builder: (context, child) {
      return MultiProvider(
        providers: [
          Provider<SignUpBloc>(
            create: (_) => SignUpBloc(AuthService()),
          ),
        ],
        child: MaterialApp(
          home: LogInPage(),
        ),
      );
    },
  ),
);

}
