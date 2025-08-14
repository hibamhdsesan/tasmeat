import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:record/record.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/constant/app_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tesmeat_app/model/hadeth_model.dart';
import 'package:tesmeat_app/service/assemplyService.dart';
import 'package:tesmeat_app/service/upload_voice_service.dart';
import 'package:tesmeat_app/ui/show_audios.dart';
import 'package:tesmeat_app/ui/text_compare.dart';

class TasmeaaPAge extends StatefulWidget {
  final Hadith hadith;
  const TasmeaaPAge({super.key, required this.hadith});

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

  // void _stopRecording() async {
  //   _timer?.cancel();
  //   String? path = await _record.stop();

  //   if (path != null) {
  //     var box = Hive.box('recordings');
  //     await box.put('lastRecording', path);
  //   }

  //   setState(() {
  //     _isRecording = false;
  //     _recordedFilePath = path;
  //   });

  //   print('تم حفظ التسجيل في: $path');
  // }
  Future<String?> getAuthToken() async {
    var box = Hive.box('tokens');
    final token = box.get('access_token');
    if (token != null && token is String) {
      print(token);
      return token;
    }
    return null;
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

    // رفع التسجيل مباشرة للباك إند عبر السيرفس
    if (_recordedFilePath != null) {
      final authToken = await getAuthToken();
      if (authToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('لم يتم العثور على التوكن، يرجى تسجيل الدخول.')),
        );
        return;
      } // دالة لجلب التوكن
      BackendService backendService = BackendService(); // انشاء instance
      final audioUrl = await BackendService().uploadAudioFromHadith(
        filePath: _recordedFilePath!,
        hadith: widget.hadith,
        authToken: authToken, // هنا صار assured انه String
      );

      if (audioUrl != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم رفع الملف بنجاح!')),
        );
        print('رابط الملف المرفوع: $audioUrl');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل رفع الملف')),
        );
      }
    }
  }

  void _playRecording() async {
    if (_recordedFilePath != null) {
      await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
    }
  }

 void _onItemTapped(int index) async {
  if (index == 2) {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  } 
  else if (index == 3) {
    // استدعاء الدالة وانتظار النتيجة
    String? token = await getAuthToken();

    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AudioListPage(authToken: token),
        ),
      );
    } else {
      // إذا ما في توكن، ممكن تظهر رسالة خطأ أو توجه لصفحة تسجيل الدخول
      print("❌ لا يوجد توكن للمصادقة");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("لا يوجد توكن، الرجاء تسجيل الدخول.")),
      );
    }
  }
  else {
    setState(() {
      _selectedIndex = index;
    });
  }
}

  String _similarityResult = ""; // جديد: لتخزين النتيجة

  void _transcribeRecording() async {
    if (_recordedFilePath == null) return;

    final service = AssemblyAIService();

    // رفع الملف
    final audioUrl = await service.uploadAudioFile(_recordedFilePath!);
    if (audioUrl == null) return;

    // طلب التفريغ
    final transcriptId = await service.requestTranscription(audioUrl);
    if (transcriptId == null) return;

    // الحصول على النص النهائي
    final text = await service.getTranscriptionResult(transcriptId);

    setState(() {
      _transcribedText = text ?? "فشل في التفريغ";
    });
  }

  void _compareTexts() {
    if (_transcribedText.isEmpty) return;

    int distance = levenshteinDistance(first_hadeth, _transcribedText);
    int maxLength = first_hadeth.length > _transcribedText.length
        ? first_hadeth.length
        : _transcribedText.length;

    double similarity = ((maxLength - distance) / maxLength) * 100;

    setState(() {
      _similarityResult = ' ${similarity.toStringAsFixed(2)}%';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _record.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _transcribedText = "";

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
            padding: EdgeInsets.only(right: 29, top: 31),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: Container(
                    width: 74.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.yellow,
                        ),
                        Text(
                          "150",
                          style: TextStyle(fontSize: 14, color: Colors.yellow),
                        ),
                      ],
                    ),
                  
                  
                  ),
                ),
                Text("سمع الحديث النبوي",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
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
                _transcribedText,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 37, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      _compareTexts();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffBBBBBB), // لون الخلفية
                    ),
                    child: Text(
                      _similarityResult,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      _transcribeRecording();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffBBBBBB), // لون الخلفية
                    ),
                    child: Text(
                      'عرض النتيجة',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
