// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tesmeat_app/constant/app_colors.dart';
// import 'package:tesmeat_app/reusedWidget.dart';
// import 'package:tesmeat_app/ui/authentication.dart';
// import 'package:tesmeat_app/ui/sign_up3.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// class SignUpPage2 extends StatefulWidget {
//   SignUpPage2({super.key});

//   @override
//   State<SignUpPage2> createState() => _SignUpPage2State();
// }

// class _SignUpPage2State extends State<SignUpPage2> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController birthDateController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Padding(
//         padding: const EdgeInsets.only(right: 20, left: 20, top: 112),
//         child: SingleChildScrollView(
//           child: Container(
//             width: 350.w,
//             height: 700.h,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 40),
//                   child: Text(
//                     "  إنشاء حساب",
//                     style: TextStyle(color: primary_color, fontSize: 20.sp),
//                   ),
//                 ),
//                 SizedBox(height: 39.h),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 7, right: 30),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Text(
//                       "الاسم",
//                       style:
//                           TextStyle(color: sixth_color, fontSize: 16.sp),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 7),
//                   child: CustomTextFormField(
//                     controller: nameController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الحقل مطلوب';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 17.h),

//                 Padding(
//                   padding: const EdgeInsets.only(top: 7, right: 30),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Text(
//                       "تاريخ الميلاد",
//                       style:
//                           TextStyle(color: sixth_color, fontSize: 16.sp),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 7),
//                   child: CustomTextFormField(
//                     controller: birthDateController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الحقل مطلوب';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 17.h),

//                 Padding(
//                   padding: const EdgeInsets.only(top: 7, right: 30),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Text(
//                       "رقم الهاتف",
//                       style:
//                           TextStyle(color: sixth_color, fontSize: 16.sp),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 7, left: 20, right: 20),
//                   child: IntlPhoneField(
//                     controller: phoneNumberController,
//                     decoration: InputDecoration(
//                       contentPadding:
//                           const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     initialCountryCode: 'SY',
//                     onChanged: (phone) {
//                       print(phone.completeNumber);
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 17.h),

//                 Padding(
//                   padding: const EdgeInsets.only(top: 7, right: 30),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Text(
//                       "البريد الإلكتروني",
//                       style:
//                           TextStyle(color: sixth_color, fontSize: 16.sp),
//                     ),
//                   ),
//                 ),
              
              
//                 Padding(
//                   padding: const EdgeInsets.only(top: 7),
//                   child: CustomTextFormField(
//                     controller: emailController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الحقل مطلوب';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
              
              
//                 SizedBox(height: 34.h),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                          Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => AuthenticationPage()));
//                         // Navigator.pushNamed(context, '/login');
//                       },
//                       child: const Text(
//                         'إدخال الرمز الخاص',
//                         style: TextStyle(
//                           color: Color(0xffED4141),
//                           decoration: TextDecoration.underline,
//                           decorationColor: Colors.red,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 21),
//                     Text(
//                       "منتسب لمعهد ما؟",
//                       style:
//                           TextStyle(color: seventh_color, fontSize: 16.sp),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 40.h),

//                 BlueElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SignUpPsge3(),
//                       ),
//                     );
//                   },
//                   text: 'التالي',
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/bloc/sign_up_bloc.dart';
import 'package:tesmeat_app/bloc/sign_up_event.dart';
import 'package:tesmeat_app/bloc/sign_up_state.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/model/user_model.dart';
import 'package:tesmeat_app/reusedWidget.dart';
import 'package:tesmeat_app/service/auth_service.dart';
import 'package:tesmeat_app/ui/authentication.dart';
import 'package:tesmeat_app/ui/types.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 112),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("جاري إنشاء الحساب...")),
              );
            } else if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم إنشاء الحساب بنجاح")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TypesPage()),
              );
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("خطأ: ${state.message}")),
              );
            }
          },
          child: SingleChildScrollView(
            child: Container(
              width: 350.w,
              height: 700.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
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

                    // الاسم
                    Padding(
                      padding: const EdgeInsets.only(top: 7, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "الاسم",
                          style: TextStyle(color: sixth_color, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: CustomTextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الحقل مطلوب';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 17.h),

                    // البريد الإلكتروني
                    Padding(
                      padding: const EdgeInsets.only(top: 7, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "البريد الإلكتروني",
                          style: TextStyle(color: sixth_color, fontSize: 16.sp),
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

                    SizedBox(height: 17.h),

                    // كلمة المرور
                    Padding(
                      padding: const EdgeInsets.only(top: 7, right: 30),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "كلمة المرور",
                          style: TextStyle(color: sixth_color, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: CustomTextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الحقل مطلوب';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 34.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AuthenticationPage()),
                            );
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
                    SizedBox(height: 40.h),

                    BlueElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final request = UserModel(
                            username: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          context.read<SignUpBloc>().add(SignUpSubmitted(request));
                        }
                      },
                      text: 'التالي',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
