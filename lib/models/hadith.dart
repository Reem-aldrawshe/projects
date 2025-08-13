
// class Hadith {
//   final String id;
//   final String title;
//   final String audioAssetPath;
//   final String originalText;

//   Hadith({
//     required this.id,
//     required this.title,
//     required this.audioAssetPath,
//     required this.originalText,
//   });
// }


class Hadith {
  final String id;
  final String title;
  final String audioAssetPath;
  final String originalText;

  Hadith({
    required this.id,
    required this.title,
    required this.audioAssetPath,
    required this.originalText,
  });
}

// قائمة الأربعين النووية
final List<Hadith> arbaoonHadiths = [
  Hadith(
    id: '1',
    title: 'عَنْ أَمِيرِ المُؤمِنينَ أَبي حَفْصٍ عُمَرَ بْنِ الخَطَّابِ',
    audioAssetPath: 'assets/audio/hadith1.mp3',
    originalText:
        'قَالَ: سَمِعْتُ رَسُولَ اللهِ ﷺ يَقُولُ: "إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ، وَإنَّمَا لِكُلِّ امْرِىءٍ مَا نَوَى، فَمَنْ كَانَتْ هِجْرَتُهُ إِلى اللهِ وَرَسُوله فَهِجْرتُهُ إِلى اللهِ وَرَسُوله، وَمَنْ كَانَتْ هِجْرَتُهُ لِدُنْيَا يُصِيبُهَا أو مرأة ينكحها فهجرته إلى ما هاجر إليه."',
  ),
  Hadith(
    id: '2',
    title: 'عَنْ أَبِي هُرَيْرَةَ',
    audioAssetPath: 'assets/audio/hadith2.mp3',
    originalText:
        'قال رسول الله ﷺ: "من كان يؤمن بالله واليوم الآخر فليقل خيرًا أو ليصمت."',
  ),
  Hadith(
    id: '3',
    title: 'عَنْ أَبِي هُرَيْرَةَ',
    audioAssetPath: 'assets/audio/hadith3.mp3',
    originalText:
        'قال رسول الله ﷺ: "من كان يؤمن بالله واليوم الآخر فليكرم ضيفه."',
  ),
  Hadith(
    id: '4',
    title: 'عَنْ عُمَرَ بْنِ الخَطَّابِ',
    audioAssetPath: 'assets/audio/hadith4.mp3',
    originalText:
        'قال رسول الله ﷺ: "الدين النصيحة." قالوا: لمن يا رسول الله؟ قال: "لله، ولكتابه، ولرسوله، ولأئمة المسلمين وعامتهم."',
  ),
  Hadith(
    id: '5',
    title: 'عَنْ أَبِي هُرَيْرَةَ',
    audioAssetPath: 'assets/audio/hadith5.mp3',
    originalText:
        'قال رسول الله ﷺ: "من أحب الله أحب الله من أحب."',
  ),

  Hadith(
     id: '6',
    title: 'عَنْ أَمِيرِ المُؤمِنينَ أَبي حَفْصٍ عُمَرَ بْنِ الخَطَّابِ',
    audioAssetPath: 'assets/audio/hadith1.mp3',
    originalText:
        ' قَالَ : سَمِعْتُ رَسُولَ اللهِ ﷺ يَقُولُ : " إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ ، وَإنَّمَا لِكُلِّ امْرِىءٍ مَا نَوَى ، فَمَنْ كَانَتْ هِجْرَتُهُ إِلى اللهِ وَرَسُوله فَهِجْرتُهُ إلى اللهِ وَرَسُوُله ، وَمَنْ كَانَتْ هِجْرَتُهُ لِدُنْيَا يُصِيْبُهَا  أو مرأة  ينكحها فهجرته إلى ما هاجر إليه',
 
    )

  // لاحقاً استكملي باقي الأربعين بنفس الأسلوب
];

