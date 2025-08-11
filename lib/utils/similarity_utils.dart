// import 'package:string_similarity/string_similarity.dart';

// class SimilarityUtils {
//   static double calculateSimilarity(String original, String spoken) {
//     return original.similarityTo(spoken);
//   }
// }


class SimilarityUtils {
  static String removeDiacritics(String input) {
    final arabicDiacritics = RegExp(r'[\u064B-\u065F\u0610-\u061A\u06D6-\u06ED]');
    return input.replaceAll(arabicDiacritics, '');
  }

  static int levenshtein(String s1, String s2) {
    final len1 = s1.length;
    final len2 = s2.length;

    final dp = List.generate(len1 + 1, (_) => List.filled(len2 + 1, 0));

    for (int i = 0; i <= len1; i++) dp[i][0] = i;
    for (int j = 0; j <= len2; j++) dp[0][j] = j;

    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        if (s1[i - 1] == s2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 + [
            dp[i - 1][j],     // حذف
            dp[i][j - 1],     // إضافة
            dp[i - 1][j - 1]  // استبدال
          ].reduce((a, b) => a < b ? a : b);
        }
      }
    }

    return dp[len1][len2];
  }

  static double calculateSimilarity(String original, String spoken) {
    final cleanOriginal = removeDiacritics(original);
    final cleanSpoken = removeDiacritics(spoken);

    if (cleanOriginal.isEmpty && cleanSpoken.isEmpty) return 1.0;
    if (cleanOriginal.isEmpty || cleanSpoken.isEmpty) return 0.0;

    final distance = levenshtein(cleanOriginal, cleanSpoken);
    final maxLen = cleanOriginal.length > cleanSpoken.length ? cleanOriginal.length : cleanSpoken.length;

    return 1.0 - (distance / maxLen);
  }
}
