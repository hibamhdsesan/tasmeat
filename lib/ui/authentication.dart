import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/reusedWidget.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
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
            height: 632.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 107),
                  child: Text(
                    "   منتسب لمعهد؟",
                    style: TextStyle(color: primary_color, fontSize: 20.sp),
                  ),
                ),
                SizedBox(
                  height: 133.h,
                ),
               Padding(
                    padding: const EdgeInsets.only(top: 7, right: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        " أدخل الرمز الخاص بك",
                        style:
                            TextStyle(color: sixth_color, fontSize: 16.sp),
                      ),
                    ),
                  ),
                
                
             Padding(
                  padding: EdgeInsets.only(top: 30.h,right: 25,left: 25),
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
                SizedBox(height: 25.h,),
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
                  height: 76.h,
                ),
                BlueElevatedButton(
                  onPressed: () {
                   
                  },
                  text: ' التحقق',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
