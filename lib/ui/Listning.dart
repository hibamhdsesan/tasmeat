import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tesmeat_app/constant/app_colors.dart';
import 'package:tesmeat_app/constant/app_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tesmeat_app/ui/tasmeaa.dart';

class ListningPage extends StatefulWidget {
  const ListningPage({super.key});

  @override
  State<ListningPage> createState() => _ListningPageState();
}

class _ListningPageState extends State<ListningPage> {
  int _selectedIndex = 0;

  // مشغل الصوت
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    _player.onDurationChanged.listen((d) {
      setState(() => _duration = d);
    });

    _player.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });

    _player.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play(AssetSource('audios/hadeth1.mp3'));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TasmeaaPAge()));
    }
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
            height: 260.h,
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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(12),
              child: Text(
                first_hadeth,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 43.h,
            // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
              color: third_color,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(15), topEnd: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 43.0),
                  child: Text(
                    "1:00",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
                Expanded(
                  child: Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds
                        .toDouble()
                        .clamp(0, _duration.inSeconds.toDouble()),
                    onChanged: (value) async {
                      final pos = Duration(seconds: value.toInt());
                      await _player.seek(pos);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 59),
                  child: IconButton(
                    icon:
                        Icon(_isPlaying ? Icons.pause : Icons.play_circle_fill),
                    onPressed: _playPause,
                    iconSize: 36,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // الـ BottomNavigationBar الأصلي
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: primary_color,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.arrow_back),
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
                  children: const [
                    Icon(Icons.headphones),
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
                  children: const [
                    Icon(Icons.mic),
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
                  children: const [
                    Icon(Icons.arrow_forward),
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
