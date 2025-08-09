import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/ui/recording.dart';
import 'package:tesmeat_app/ui/types.dart';

void main() {
  runApp(ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          home: TypesPage(),
        );
      }));
}
