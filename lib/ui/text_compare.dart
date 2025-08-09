
double simpleTextSimilarity(String text1, String text2) {
  final words1 = text1.split(RegExp(r'\s+')).map((e) => e.trim()).toList();
  final words2 = text2.split(RegExp(r'\s+')).map((e) => e.trim()).toList();

  int matchCount = 0;
  for (final word in words1) {
    if (words2.contains(word)) {
      matchCount++;
    }
  }

  return matchCount / words1.length;
}


// Future<String> getFilePath() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final path = '${directory.path}/recorded_audio.wav'; // مثلاً WAV أو M4A حسب الترميز
//   return path;
// }