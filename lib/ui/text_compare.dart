
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


int levenshteinDistance(String s1, String s2) {
  final len1 = s1.length;
  final len2 = s2.length;

  List<List<int>> dp = List.generate(len1 + 1, (_) => List.filled(len2 + 1, 0));

  // ملء الصف الأول والعمود الأول
  for (int i = 0; i <= len1; i++) dp[i][0] = i;
  for (int j = 0; j <= len2; j++) dp[0][j] = j;

  for (int i = 1; i <= len1; i++) {
    for (int j = 1; j <= len2; j++) {
      if (s1[i - 1] == s2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1]; // نفس الحرف، ما في تعديل
      } else {
        dp[i][j] = 1 + [
          dp[i - 1][j],    // حذف
          dp[i][j - 1],    // إضافة
          dp[i - 1][j - 1] // تعديل
        ].reduce((a, b) => a < b ? a : b);
      }
    }
  }

  return dp[len1][len2];
}

// لحساب نسبة التشابه
double similarity(String s1, String s2) {
  final distance = levenshteinDistance(s1, s2);
  final maxLen = s1.length > s2.length ? s1.length : s2.length;
  if (maxLen == 0) return 1.0; // لتجنب القسمة على صفر
  return (1 - distance / maxLen) * 100; // نسبة مئوية
}


// Future<String> getFilePath() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final path = '${directory.path}/recorded_audio.wav'; // مثلاً WAV أو M4A حسب الترميز
//   return path;
// }