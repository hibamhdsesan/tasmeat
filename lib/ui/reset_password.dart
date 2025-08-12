import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/reusedWidget.dart';
import 'package:tesmeat_app/ui/authentication.dart';
import 'package:tesmeat_app/ui/login.dart';
import 'package:tesmeat_app/ui/reset_password2.dart';
import 'package:tesmeat_app/ui/sign_up2.dart';

class ResetPasswordPage1 extends StatefulWidget {
  const ResetPasswordPage1({super.key});

  @override
  State<ResetPasswordPage1> createState() => _ResetPasswordPage1State();
}

class _ResetPasswordPage1State extends State<ResetPasswordPage1> {
    TextEditingController emailController = TextEditingController();

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
                    "  إعادة تعيين كلمة المرور",
                    style: TextStyle(color: primary_color, fontSize: 20.sp),
                  ),
                ),
                SizedBox(height: 15.h),
                Image.asset(
                  "images/Login2.png",
                ),
                SizedBox(height: 16.h),
             Padding(
  padding: const EdgeInsets.only(left: 38),
  child: Text(
    "سنرسل لبريدك الإلكتروني رمز تحقق \nمن 6 خانات",
    style: TextStyle(fontSize: 18.sp, color: text_color),
    textAlign: TextAlign.right,  
  ),
),

              SizedBox(height: 30.h,),
          
                  Padding(
                    padding: const EdgeInsets.only(top: 7, right: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "البريد الإلكتروني",
                        style:
                            TextStyle(color: sixth_color, fontSize: 16.sp),
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: CustomTextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الحقل مطلوب';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 147.h),
                  
                  BlueElevatedButton(
                    onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordPage2()));
                     
                    },
                    text: ' إرسال الرمز',
                  )
               
                
                
                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
