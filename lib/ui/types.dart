import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/ui/ahadeth_list.dart';

class TypesPage extends StatelessWidget {
  const TypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>AhadethListPage()));
                },
                child: Container(
                  height: 160.h,
                  width: 300.w,
                  color: fifth_color,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 58.w,
                        top: 0,
                        child: Text(
                          "40",
                          style: TextStyle(
                            fontSize: 110.sp,
                            color: primary_color,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 170.w,
                        top: 65.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الأربعون",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: third_color,
                              ),
                            ),
                            Text(
                              "النووية",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: third_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 160.h,
              width: 300.w,
              color: fifth_color,
              child: Stack(
                children: [
                  Positioned(
                    left: 58.w,
                    top: 0,
                    child: Text(
                      "75",
                      style: TextStyle(
                        fontSize: 110.sp,
                        color: primary_color,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 170.w,
                    top: 65.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "جوامع",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: third_color,
                          ),
                        ),
                        Text(
                          "الإسلام",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: third_color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 160.h,
              width: 300.w,
              color: fifth_color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/clock 1.png"),
                  Text(
                    "قريبا",
                    style: TextStyle(fontSize: 20.sp, color: third_color),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
