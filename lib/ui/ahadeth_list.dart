import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/constant/app_text.dart';
import 'package:tesmeat_app/ui/hadeth.dart';

class AhadethListPage extends StatelessWidget {
  const AhadethListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 48),
        child: ListView.builder(
            itemCount: ahadeth_list_number.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 14, left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HadethPage()));
                  },
                  child: Container(
                    height: 59.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: fifth_color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        ahadeth_list_number[index],
                        style: TextStyle(color: fourth_color, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
