import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/reusedWidget.dart';
import 'package:tesmeat_app/ui/reset_password.dart';

class ResetPasswordPage3 extends StatefulWidget {
  ResetPasswordPage3({super.key});

  @override
  State<ResetPasswordPage3> createState() => _ResetPasswordPage3State();
}

class _ResetPasswordPage3State extends State<ResetPasswordPage3> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                  "   إعادة تعيين كلمة المرور",
                  style: TextStyle(color: primary_color, fontSize: 20.sp),
                ),
              ),
              SizedBox(
                height: 115.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, right: 30),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      " كلمة المرور ",
                      style: TextStyle(color: sixth_color, fontSize: 16.sp),
                    )),
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
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, right: 30),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "  تأكيد كلمة المرور",
                      style: TextStyle(color: sixth_color, fontSize: 16.sp),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: CustomTextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الحقل مطلوب';
                    }
                    return null;
                  },
                ),
              ),
             
              SizedBox(
                height: 244.h,
              ),
              BlueElevatedButton(
                onPressed: () {
                 
                },
                text: ' تعيين',
              )
            ],
          ),
        ),
      ),
    );
  }
}
