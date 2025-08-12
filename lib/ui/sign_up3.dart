import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/reusedWidget.dart';
import 'package:tesmeat_app/ui/authentication.dart';
import 'package:tesmeat_app/ui/sign_up3.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPsge3 extends StatefulWidget {
  SignUpPsge3({super.key});

  @override
  State<SignUpPsge3> createState() => _SignUpPsge3State();
}

class _SignUpPsge3State extends State<SignUpPsge3> {
  TextEditingController educationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPAsswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 112),
        child: SingleChildScrollView(
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
                    "  إنشاء حساب",
                    style: TextStyle(color: primary_color, fontSize: 20.sp),
                  ),
                ),
                SizedBox(height: 39.h),
               
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 30),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "درجة التعليم",
                      style:
                          TextStyle(color: sixth_color, fontSize: 16.sp),
                    ),
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: CustomTextFormField(
                    controller: educationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الحقل مطلوب';
                      }
                      return null;
                    },
                  ),
                ),
                
                
                SizedBox(height: 40.h),

                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 30),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      " كلمة المرور",
                      style:
                          TextStyle(color: sixth_color, fontSize: 16.sp),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: CustomTextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الحقل مطلوب';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 40.h),

              
                
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 30),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      " تأكيد كلمة المرور",
                      style:
                          TextStyle(color: sixth_color, fontSize: 16.sp),
                    ),
                  ),
                ),
              
              
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: CustomTextFormField(
                    controller: confirmPAsswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الحقل مطلوب';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 88.h),

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
                      style:
                          TextStyle(color: seventh_color, fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),

                BlueElevatedButton(
                  onPressed: () {
                   
                  },
                  text: 'إنشاء حساب',
                )
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}
