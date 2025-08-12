import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/reusedWidget.dart';
import 'package:tesmeat_app/ui/reset_password3.dart';

class ResetPasswordPage2 extends StatefulWidget {
  ResetPasswordPage2({super.key});

  @override
  State<ResetPasswordPage2> createState() => _ResetPasswordPage2State();
}

class _ResetPasswordPage2State extends State<ResetPasswordPage2> {
  String otpCode = "";

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
                    "    إعادة تعيين كلمة المرور",
                    style: TextStyle(color: primary_color, fontSize: 20.sp),
                  ),
                ),
                SizedBox(
                  height: 111.h,
                ),
               Padding(
                    padding: const EdgeInsets.only(top: 7, right: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        " أدخل رمز التحقق الذي تم إرساله  ",
                        style:
                            TextStyle(color: sixth_color, fontSize: 16.sp),
                      ),
                    ),
                  ),
                SizedBox(height: 34.h,),
                 Padding(
                    padding: const EdgeInsets.only( right: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "  رمز التحقق     ",
                        style:
                            TextStyle(color: sixth_color, fontSize: 16.sp),
                      ),
                    ),
                  ),
                
                
                
             Padding(
                  padding: EdgeInsets.only(top: 4.h,right: 25,left: 25),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                    onCompleted: (value) {
                      print("OTP مكتمل: $value");
                    },
                    textStyle: TextStyle(fontSize: 18.sp),
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(15),
                      fieldHeight: 50.h,
                      fieldWidth: 42.w,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveColor: Colors.grey.shade400,
                      selectedColor: primary_color,
                      activeColor: primary_color,
                      borderWidth: 1,
                    ),
                    enableActiveFill: true,
                  ),
                ),
                SizedBox(height: 70.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'إرسال مرة أخرى',
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
                      "    لم يصلك الرمز؟",
                      style: TextStyle(color: seventh_color, fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 177.h,
                ),
                BlueElevatedButton(
                  onPressed: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordPage3()));
                   
                  },
                  text: ' تحقق',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
