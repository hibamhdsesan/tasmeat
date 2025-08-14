
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/bloc_login/login_bloc_bloc.dart';
import 'package:tesmeat_app/bloc_login/login_bloc_event.dart';
import 'package:tesmeat_app/bloc_login/login_bloc_state.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/reusedWidget.dart';
import 'package:tesmeat_app/service/login_service.dart';
import 'package:tesmeat_app/ui/reset_password.dart';
import 'package:tesmeat_app/ui/types.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(loginService: LoginService()),
      child: Scaffold(
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        "  تسجيل الدخول",
                        style: TextStyle(color: primary_color, fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(height: 138.h),
                    Padding(
                      padding: const EdgeInsets.only(top: 7, right: 30),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            " الاسم ",
                            style: TextStyle(color: sixth_color, fontSize: 16.sp),
                          )),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 7, right: 30),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            " كلمة المرور",
                            style: TextStyle(color: sixth_color, fontSize: 16.sp),
                          )),
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
                    SizedBox(height: 130.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage1()));
                          },
                          child: const Text(
                            '  إعادة تعيين كلمة المرور',
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
                          "  نسيت كلمة المرور؟",
                          style: TextStyle(color: seventh_color, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 44.h),
            
                   BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  // التنقل لواجهة TypesPage بعد تسجيل الدخول بنجاح
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TypesPage()),
                  );
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator();
                }
                return BlueElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
            context.read<LoginBloc>().add(LoginButtonPressed(
                  username: nameController.text,
                  password: passwordController.text,
                ));
                    }
                  },
                  text: 'تسجيل الدخول',
                );
              },
            )
            
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