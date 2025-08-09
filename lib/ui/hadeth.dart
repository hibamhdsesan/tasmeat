import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/constant/app_text.dart';

class HadethPage extends StatefulWidget {
  const HadethPage({super.key});

  @override
  State<HadethPage> createState() => _HadethPageState();
}

class _HadethPageState extends State<HadethPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // هون بتحط الأكشن يلي بدك يصير لما المستخدم يضغط على أي أيقونة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        backgroundColor: primary_color,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 64, top: 31),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 29),
                  child: Container(
                    width: 74.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 62),
                  child: Text(" سمع الحديث النبوي"),
                ),
              ],
            ),
          ),
          SizedBox(height: 23),
          Container(
            width: 362.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                alrawi,
                style: TextStyle(
                  color: alrawi_color,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 11),
          Container(
            width: 362.w,
            height: 324.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                first_hadeth,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
     bottomNavigationBar: BottomNavigationBar(
 type: BottomNavigationBarType.fixed, // ضروري لحتى يثبت اللون
  backgroundColor: primary_color, // لون الخلفية
  currentIndex: _selectedIndex,
  selectedItemColor: Colors.white, // لون المختار
  unselectedItemColor: Colors.white,
  onTap: _onItemTapped,
  items: [
    BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.arrow_back),
          SizedBox(height: 4),
          Text("السابق", style: TextStyle(fontSize: 12,color: Colors.white)),
        ],
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.headphones),
          SizedBox(height: 4),
          Text("استماع", style: TextStyle(fontSize: 12,color: Colors.white)),
        ],
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.mic),
          SizedBox(height: 4),
          Text("تسميع", style: TextStyle(fontSize: 12,color: Colors.white)),
        ],
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.arrow_forward),
          SizedBox(height: 4),
          Text("التالي", style: TextStyle(fontSize: 12,color: Colors.white)),
        ],
      ),
      label: '',
    ),
  ],
),

    );
  }
}
