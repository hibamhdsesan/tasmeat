import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:tesmeat_app/model/hadeth_model.dart';
import 'package:tesmeat_app/service/assemplyService.dart';
import 'package:tesmeat_app/ui/text_compare.dart';

class VoiceTranscriptionPage extends StatefulWidget {
  
  @override
  _VoiceTranscriptionPageState createState() => _VoiceTranscriptionPageState();
}

class _VoiceTranscriptionPageState extends State<VoiceTranscriptionPage> {
  final Record record = Record();
  final AssemblyAIService assemblyAIService = AssemblyAIService();

  String? transcriptionText;
  double similarityScore = 0.0;
  bool isRecording = false;
  bool isProcessing = false;

  final String referenceText =
      'من قُتل دونَ ماله فهو شهيد و من قتل دون دمه فهو شهيد و من قتل دون دينه فهو شهيد و من قتل دون أهله فهو شهيد';

  Future<void> startStopRecording() async {
    if (isRecording) {
      print("🛑 إيقاف التسجيل...");
      final path = await record.stop();
      print("📂 مسار الملف المسجل: $path");

      setState(() {
        isRecording = false;
        isProcessing = true;
      });

      if (path != null) {
        print("📤 رفع الملف إلى الخادم...");
        final audioUrl = await assemblyAIService.uploadAudioFile(path);

        if (audioUrl != null) {
          print("✅ تم رفع الملف، رابط الصوت: $audioUrl");

          print("📨 إرسال طلب التفريغ النصي...");
          final transcriptId =
              await assemblyAIService.requestTranscription(audioUrl);

          if (transcriptId != null) {
            print("✅ تم إنشاء الطلب، المعرف: $transcriptId");

            print("⌛ جلب النتيجة من الخادم...");
            final text =
                await assemblyAIService.getTranscriptionResult(transcriptId);

            if (text != null) {
              print("✅ تم الحصول على النص: $text");

              final similarity = simpleTextSimilarity(text, referenceText);
              print("📊 نسبة التشابه: ${(similarity * 100).toStringAsFixed(2)}%");

              setState(() {
                transcriptionText = text;
                similarityScore = similarity;
                isProcessing = false;
              });
            } else {
              print("❌ فشل في الحصول على النص من الخادم");
              setState(() {
                transcriptionText = 'فشل في الحصول على النص';
                isProcessing = false;
              });
            }
          } else {
            print("❌ فشل في إنشاء طلب التفريغ النصي");
            setState(() {
              transcriptionText = 'فشل في طلب التفريغ النصي';
              isProcessing = false;
            });
          }
        } else {
          print("❌ فشل في رفع الملف الصوتي");
          setState(() {
            transcriptionText = 'فشل في رفع الملف';
            isProcessing = false;
          });
        }
      }
    } else {
      print("🎙 التحقق من أذونات التسجيل...");
      bool hasPermission = await record.hasPermission();
      if (hasPermission) {
        print("✅ تم منح الإذن، بدء التسجيل...");
        await record.start();
        setState(() {
          isRecording = true;
        });
      } else {
        print("❌ لم يتم منح إذن التسجيل");
      }
    }
  }

  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل ومقارنة النص'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'النص المرجعي:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(referenceText, textAlign: TextAlign.center),

            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: isProcessing ? null : startStopRecording,
              icon: Icon(isRecording ? Icons.stop : Icons.mic),
              label: Text(isRecording ? 'إيقاف التسجيل' : 'بدء التسجيل'),
            ),

            SizedBox(height: 20),

            if (isProcessing) CircularProgressIndicator(),

            if (transcriptionText != null && !isProcessing) ...[
              Text(
                'النص المسجل:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(transcriptionText!, textAlign: TextAlign.center),
              SizedBox(height: 20),
              Text(
                'نسبة التشابه: ${(similarityScore * 100).toStringAsFixed(2)} %',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
