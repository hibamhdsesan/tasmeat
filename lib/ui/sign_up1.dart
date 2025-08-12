import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/reusedWidget.dart';
import 'package:tesmeat_app/ui/authentication.dart';
import 'package:tesmeat_app/ui/login.dart';
import 'package:tesmeat_app/ui/sign_up2.dart';

class SignUpPAge1 extends StatefulWidget {
  const SignUpPAge1({super.key});

  @override
  State<SignUpPAge1> createState() => _SignUpPAge1State();
}

class _SignUpPAge1State extends State<SignUpPAge1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 112),
        child: Container(
          width: 350.w,
          height: 700.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "جاهز لتعلم المزيد؟",
                  style: TextStyle(color: primary_color, fontSize: 20.sp),
                ),
              ),
              SizedBox(height: 35.h),
              Image.asset(
                "images/Login1.png",
              ),
              SizedBox(height: 62.h),
              BlueElevatedButton(
                text: 'إنشاء حساب',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => SignUpPage2())));
                },
              ),
              SizedBox(height: 26.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogInPage()));
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Color(0xffED4141),
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 21),
                  Text(
                    "لديك حساب بالفعل؟",
                    style: TextStyle(color: seventh_color, fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 63),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 10,
                      ),
                    ),
                  ),
                  const Text(
                    'أو',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 63),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  // أكشن الزر
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(312, 54),
                  backgroundColor: Colors.transparent, // شفافية الخلفية
                  elevation: 0, // حتى ما يكون فيه ظل
                  side: BorderSide(color: primary_color), // لون الحافة
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'تصفح التطبيق',
                  style: TextStyle(
                    fontSize: 16,
                    color: primary_color, // لون النص مثل لون الحافة
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 26.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticationPage()));
                    },
                    child: const Text(
                      'إدخال الرمز الخاص',
                      style: TextStyle(
                        color: Color(0xffED4141),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 21),
                  Text(
                    "منتسب لمعهد ما؟",
                    style: TextStyle(color: seventh_color, fontSize: 16.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
