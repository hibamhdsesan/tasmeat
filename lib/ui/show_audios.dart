import 'package:flutter/material.dart';
import 'package:tesmeat_app/service/upload_voice_service.dart';

class AudioListPage extends StatefulWidget {
  final String authToken;

  const AudioListPage({super.key, required this.authToken});

  @override
  State<AudioListPage> createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {
  final BackendService service = BackendService();
  List<String> audios = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAudios();
  }

  void fetchAudios() async {
    List<String> list = await service.getAllAudios(authToken: widget.authToken);
    setState(() {
      audios = list;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الأصوات المرفوعة")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : audios.isEmpty
              ? const Center(child: Text("لا توجد أصوات."))
              : ListView.builder(
                  itemCount: audios.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("صوت رقم ${index + 1}"),
                      subtitle: Text(audios[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () {
                          // هنا ممكن تستخدم أي مكتبة لتشغيل الصوت مثل just_audio
                          print("تشغيل: ${audios[index]}");
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
