import 'package:string_similarity/string_similarity.dart';

class SimilarityUtils {
  static double calculateSimilarity(String original, String spoken) {
    return original.similarityTo(spoken);
  }
}
