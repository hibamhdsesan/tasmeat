import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:record/record.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/constant/app_text.dart';
import 'package:audioplayers/audioplayers.dart';

class TasmeaaPAge extends StatefulWidget {
  const TasmeaaPAge({super.key});

  @override
  State<TasmeaaPAge> createState() => _TasmeaaPAgeState();
}

class _TasmeaaPAgeState extends State<TasmeaaPAge> {
  int _selectedIndex = 0;

  final Record _record = Record();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isRecording = false;
  int _recordDuration = 0;
  Timer? _timer;

  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    var box = Hive.box('recordings');
    _recordedFilePath = box.get('lastRecording');
  }

  void _startRecording() async {
    bool hasPermission = await _record.hasPermission();
    if (hasPermission) {
      await _record.start(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        samplingRate: 44100,
      );

      setState(() {
        _isRecording = true;
        _recordDuration = 0;
      });

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _recordDuration++;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى السماح بالوصول إلى الميكروفون')),
      );
    }
  }

  void _stopRecording() async {
    _timer?.cancel();
    String? path = await _record.stop();

    if (path != null) {
      var box = Hive.box('recordings');
      await box.put('lastRecording', path);
    }

    setState(() {
      _isRecording = false;
      _recordedFilePath = path;
    });

    print('تم حفظ التسجيل في: $path');
  }

  void _playRecording() async {
    if (_recordedFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
    }
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      if (_isRecording) {
        _stopRecording();
      } else {
        _startRecording();
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _record.dispose();
    _audioPlayer.dispose();
    super.dispose();
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
                "",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الـ Container بيضل موجود دايمًا
          Container(
            width: double.infinity,
            height: 43.h,
            decoration: BoxDecoration(
              color: secondary_color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.mic, color: Colors.white),
                Expanded(
                  child: _isRecording
                      ? Text(
                          'Recording: $_recordDuration s',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        )
                      : (_recordedFilePath != null
                          ? GestureDetector(
                              onTap: _playRecording,
                              child: Text(
                                'تشغيل آخر تسجيل',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.sp),
                              ),
                            )
                          : Text(
                              'لا يوجد تسجيل بعد',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            )),
                ),
                GestureDetector(
                  onTap: _isRecording ? _stopRecording : _startRecording,
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: primary_color,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    SizedBox(height: 4),
                    Text("السابق",
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.headphones, color: Colors.white),
                    SizedBox(height: 4),
                    Text("استماع",
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isRecording
                          ? Icons.mic_external_off_outlined
                          : Icons.mic,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4),
                    Text("تسميع",
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white),
                    SizedBox(height: 4),
                    Text("التالي",
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
                label: '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:record/record.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:tesmeat_app/constant/app_colors.dart';
// import 'package:tesmeat_app/constant/app_text.dart';

// class TasmeaaPAge extends StatefulWidget {
//   const TasmeaaPAge({super.key});

//   @override
//   State<TasmeaaPAge> createState() => _TasmeaaPAgeState();
// }

// class _TasmeaaPAgeState extends State<TasmeaaPAge> {
//   int _selectedIndex = 0;

//   final Record _record = Record();
//   final stt.SpeechToText _speech = stt.SpeechToText();

//   bool _isRecording = false;
//   int _recordDuration = 0;
//   Timer? _timer;

//   String? _recordedFilePath;
//   String _recognizedText = ""; // النص المحوّل من الصوت

//   Future<void> _startRecording() async {
//     bool hasPermission = await _record.hasPermission();
//     bool available = await _speech.initialize(
//       onStatus: (status) => print('Status: $status'),
//       onError: (error) => print('Error: $error'),
//     );

//     if (hasPermission && available) {
//       // بدء التسجيل الصوتي
//       await _record.start(
//         encoder: AudioEncoder.aacLc,
//         bitRate: 128000,
//         samplingRate: 44100,
//       );

//       // بدء التعرف على الكلام
//       _speech.listen(
//         onResult: (result) {
//           setState(() {
//             _recognizedText = result.recognizedWords;
//           });
//         },
//         localeId: "ar_SA", // اللغة العربية
//       );

//       setState(() {
//         _isRecording = true;
//         _recordDuration = 0;
//       });

//       _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//         setState(() {
//           _recordDuration++;
//         });
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('يرجى السماح بالوصول إلى الميكروفون')),
//       );
//     }
//   }

//   void _stopRecording() async {
//     _timer?.cancel();
//     String? path = await _record.stop();
//     _speech.stop();

//     setState(() {
//       _isRecording = false;
//       _recordedFilePath = path;
//     });

//     print('تم حفظ التسجيل في: $path');
//   }

//   void _onItemTapped(int index) {
//     if (index == 2) {
//       if (_isRecording) {
//         _stopRecording();
//       } else {
//         _startRecording();
//       }
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _record.dispose();
//     _speech.stop();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: background_color,
//       appBar: AppBar(
//         backgroundColor: primary_color,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(right: 64, top: 31),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 29),
//                   child: Container(
//                     width: 74.w,
//                     height: 35.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 62),
//                   child: Text(" سمع الحديث النبوي"),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 23),
//           Container(
//             width: 362.w,
//             height: 60.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 6,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 alrawi,
//                 style: TextStyle(
//                   color: alrawi_color,
//                   fontSize: 18.sp,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 11),
//           Container(
//             width: 362.w,
//             height: 324.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 6,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 _recognizedText, // عرض النص المحوّل
//                 textAlign: TextAlign.right,
//                 style: TextStyle(fontSize: 18.sp),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (_isRecording)
//             Container(
//               width: double.infinity,
//               height: 43.h,
//               decoration: BoxDecoration(
//                 color: secondary_color,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black38,
//                     blurRadius: 6,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(Icons.mic, color: Colors.white),
//                   Text(
//                     'Recording: $_recordDuration s',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: _stopRecording,
//                     child: Icon(Icons.stop, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: primary_color,
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.white,
//             unselectedItemColor: Colors.white70,
//             onTap: _onItemTapped,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.arrow_back, color: Colors.white),
//                     SizedBox(height: 4),
//                     Text("السابق", style: TextStyle(fontSize: 12, color: Colors.white)),
//                   ],
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.headphones, color: Colors.white),
//                     SizedBox(height: 4),
//                     Text("استماع", style: TextStyle(fontSize: 12, color: Colors.white)),
//                   ],
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       _isRecording ? Icons.mic_external_off_outlined : Icons.mic,
//                       color: Colors.white,
//                     ),
//                     SizedBox(height: 4),
//                     Text("تسميع", style: TextStyle(fontSize: 12, color: Colors.white)),
//                   ],
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.arrow_forward, color: Colors.white),
//                     SizedBox(height: 4),
//                     Text("التالي", style: TextStyle(fontSize: 12, color: Colors.white)),
//                   ],
//                 ),
//                 label: '',
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
