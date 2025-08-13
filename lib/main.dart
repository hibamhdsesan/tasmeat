import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tesmeat_app/ui/recording.dart';
import 'package:tesmeat_app/ui/sign_up1.dart';
import 'package:tesmeat_app/ui/tasmeaa.dart';
import 'package:tesmeat_app/ui/types.dart';

void main() async{

   WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await Hive.openBox('recordings'); // فتح صندوق لتخزين التسجيلات

  runApp(ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          home: TypesPage(),
        );
      }));
}
