// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:alhekma/presenters/hadith_presenter.dart';
// import '../../data/models/book_model.dart';
// import '../../services/playback_service.dart';
// import '../../services/recording_service.dart';
// import '../../services/transcription_service.dart';

// class HadithDetailPage extends StatefulWidget {
//   final Book book;
//   final int initialIndex;

//   const HadithDetailPage({required this.book, required this.initialIndex, super.key});

//   @override
//   State<HadithDetailPage> createState() => _HadithDetailPageState();
// }

// class _HadithDetailPageState extends State<HadithDetailPage> {
//   late int currentIndex;

//   final PlaybackService _playback = PlaybackService();
//   final RecordingService _recorder = RecordingService();
// final HadithPresenter presenter = HadithPresenter();

//   bool _isRecording = false;
//   String? _recordedFilePath;
//   String uploadedText = '';
//   double? _lastScore;
//   bool _showResult = false;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.initialIndex;
//   }

//   void next() {
//     if (currentIndex < widget.book.hadiths.length - 1) {
//       setState(() {
//         currentIndex++;
//         resetAudio();
//       });
//     }
//   }

//   void prev() {
//     if (currentIndex > 0) {
//       setState(() {
//         currentIndex--;
//         resetAudio();
//       });
//     }
//   }

//   void resetAudio() {
//     _playback.stop();
//     _recordedFilePath = null;
//     uploadedText = '';
//     _lastScore = null;
//     _showResult = false;
//     _isRecording = false;
//   }

//   // تشغيل صوت الحديث من assets
//   void _playHadithAsset() {
//     final path = 'assets/audio/hadith_${widget.book.hadiths[currentIndex].id}.mp3';
//     _playback.playAsset(path);
//   }

//   // التسجيل
//   void _startRecording() async {
//     final path = await _recorder.startRecording(fileName: 'hadith_${widget.book.hadiths[currentIndex].id}.m4a');
//     if (path != null) {
//       setState(() {
//         _isRecording = true;
//         _recordedFilePath = path;
//       });
//     }
//   }

//   void _stopRecording() async {
//     await _recorder.stopRecording();
//     setState(() {
//       _isRecording = false;
//     });
//   }

//   void _playRecorded() async {
//     if (_recordedFilePath != null) {
//       _playback.playFile(_recordedFilePath!);
//     }
//   }

//   void _uploadAndShowText() async {
//     if (_recordedFilePath != null) {
//       final text = await TranscriptionService.uploadAndTranscribe(_recordedFilePath!);
//       setState(() {
//         uploadedText = text;
//       });
//     }
//   }

//   void _onShowResult() {
//     final original = widget.book.hadiths[currentIndex].content;
//     final edited = uploadedText;
//     final score = presenter.calculateSimilarity(original, edited); // خوارزمية التشابه الخاصة فيك
//     setState(() {
//       _lastScore = score;
//       _showResult = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hadith = widget.book.hadiths[currentIndex];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF088395),
//         toolbarHeight: 72,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(child: Text(hadith.title, style: const TextStyle(fontSize: 16))),
//             Stack(
//               children: const [
//                 CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.person)),
//                 Positioned(
//                   left: 6,
//                   top: 4,
//                   child: SizedBox(
//                     width: 8,
//                     height: 8,
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 74,
//                     height: 35,
//                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(Icons.book, size: 16),
//                         SizedBox(width: 6),
//                         Text('150', style: TextStyle(fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                   const Expanded(child: SizedBox()),
//                   GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('تنويه'),
//                           content: const Text('قد يرد في هذا الحديث مفردات لها عدّة قراءات\nيرجى الاستماع للحديث'),
//                           actions: [
//                             TextButton(onPressed: () => Navigator.pop(context), child: const Text('تم'))
//                           ],
//                         ),
//                       );
//                     },
//                     child: Row(
//                       children: const [
//                         Text('سمّع الحديث النبوي !', style: TextStyle(color: Color(0xFF8F8D7D))),
//                         SizedBox(width: 8),
//                         Icon(Icons.volume_up, size: 20),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Container(
//                 width: double.infinity,
//                 height: 60,
//                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.all(12),
//                 child: Text('الراوي: ${hadith.raawi}', style: const TextStyle(color: Colors.black87)),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                   padding: const EdgeInsets.all(14),
//                   child: SingleChildScrollView(
//                     child: Text(
//                       uploadedText.isNotEmpty ? uploadedText : hadith.content,
//                       style: const TextStyle(color: Colors.black87, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Play asset
//                   IconButton(icon: const Icon(Icons.headset), onPressed: _playHadithAsset),
//                   // Record
//                   IconButton(
//                       icon: Icon(_isRecording ? Icons.stop : Icons.mic),
//                       onPressed: _isRecording ? _stopRecording : _startRecording),
//                   // Play recorded
//                   if (_recordedFilePath != null) IconButton(icon: const Icon(Icons.play_arrow), onPressed: _playRecorded),
//                   // Upload & Show Result
//                   ElevatedButton(
//                     onPressed: uploadedText.isEmpty ? _uploadAndShowText : _onShowResult,
//                     style: ElevatedButton.styleFrom(backgroundColor: _showResult ? Colors.green : const Color(0xFFBBBBBB)),
//                     child: Text(_showResult
//                         ? 'النتيجة: ${((_lastScore ?? 0) * 100).toStringAsFixed(0)}/100'
//                         : uploadedText.isEmpty
//                             ? 'حفظ وارسال'
//                             : 'عرض النتيجة'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: const Color(0xFF088395),
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: prev,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.arrow_back, color: Colors.white),
//                     SizedBox(height: 4),
//                     Text('السابق', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: next,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.arrow_forward, color: Colors.white),
//                     SizedBox(height: 4),
//                     Text('التالي', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:alhekma/repository/books_repository.dart';
// import 'package:alhekma/presenters/hadith_presenter.dart';
// import '../../models/book_model.dart';
// import '../../services/playback_service.dart';
// import '../../services/recording_service.dart';
// import '../../services/transcription_service.dart';

// class HadithDetailPage extends StatefulWidget {
//   final int bookId; // بدل ما تجيب الكتاب كامل
//   final int initialIndex;

//   const HadithDetailPage({required this.bookId, required this.initialIndex, super.key});

//   @override
//   State<HadithDetailPage> createState() => _HadithDetailPageState();
// }

// class _HadithDetailPageState extends State<HadithDetailPage> {
//   late int currentIndex;

//   final PlaybackService _playback = PlaybackService();
//   final RecordingService _recorder = RecordingService();
//   final HadithPresenter presenter = HadithPresenter();
//   final BooksRepository _repo = BooksRepository();

//   Book? book;

//   bool _isLoading = true;
//   bool _isRecording = false;
//   String? _recordedFilePath;
//   String uploadedText = '';
//   double? _lastScore;
//   bool _showResult = false;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.initialIndex;
//     loadBook(widget.bookId);
//   }

//   Future<void> loadBook(int id) async {
//     try {
//       book = await _repo.fetchAndCacheById(id); // يحاول من الإنترنت
//     } catch (_) {
//       book = _repo.getCachedBookById(id);      // لو ما في نت يرجع من الكاش
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   void next() {
//     if (book != null && currentIndex < book!.hadiths.length - 1) {
//       setState(() {
//         currentIndex++;
//         resetAudio();
//       });
//     }
//   }

//   void prev() {
//     if (book != null && currentIndex > 0) {
//       setState(() {
//         currentIndex--;
//         resetAudio();
//       });
//     }
//   }

//   void resetAudio() {
//     _playback.stop();
//     _recordedFilePath = null;
//     uploadedText = '';
//     _lastScore = null;
//     _showResult = false;
//     _isRecording = false;
//   }

//   void _playHadithAsset() {
//     if (book == null) return;
//     final path = 'assets/audio/hadith_${book!.hadiths[currentIndex].id}.mp3';
//     _playback.playAsset(path);
//   }

//   void _startRecording() async {
//     if (book == null) return;
//     final path = await _recorder.startRecording(fileName: 'hadith_${book!.hadiths[currentIndex].id}.m4a');
//     if (path != null) {
//       setState(() {
//         _isRecording = true;
//         _recordedFilePath = path;
//       });
//     }
//   }

//   void _stopRecording() async {
//     await _recorder.stopRecording();
//     setState(() {
//       _isRecording = false;
//     });
//   }

//   void _playRecorded() async {
//     if (_recordedFilePath != null) {
//       _playback.playFile(_recordedFilePath!);
//     }
//   }

//   void _uploadAndShowText() async {
//     if (_recordedFilePath != null) {
//       final text = await TranscriptionService.uploadAndTranscribe(_recordedFilePath!);
//       setState(() {
//         uploadedText = text;
//       });
//     }
//   }

//   void _onShowResult() {
//     if (book == null) return;
//     final original = book!.hadiths[currentIndex].content;
//     final edited = uploadedText;
//     final score = presenter.calculateSimilarity(original, edited);
//     setState(() {
//       _lastScore = score;
//       _showResult = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (book == null) {
//       return const Scaffold(
//         body: Center(child: Text('لا يوجد بيانات لهذا الكتاب')),
//       );
//     }

//     final hadith = book!.hadiths[currentIndex];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF088395),
//         toolbarHeight: 72,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(child: Text(hadith.title, style: const TextStyle(fontSize: 16))),
//             Stack(
//               children: const [
//                 CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.person)),
//                 Positioned(
//                   left: 6,
//                   top: 4,
//                   child: SizedBox(
//                     width: 8,
//                     height: 8,
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 74,
//                     height: 35,
//                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(Icons.book, size: 16),
//                         SizedBox(width: 6),
//                         Text('150', style: TextStyle(fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                   const Expanded(child: SizedBox()),
//                   GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('تنويه'),
//                           content: const Text('قد يرد في هذا الحديث مفردات لها عدّة قراءات\nيرجى الاستماع للحديث'),
//                           actions: [
//                             TextButton(onPressed: () => Navigator.pop(context), child: const Text('تم'))
//                           ],
//                         ),
//                       );
//                     },
//                     child: Row(
//                       children: const [
//                         Text('سمّع الحديث النبوي !', style: TextStyle(color: Color(0xFF8F8D7D))),
//                         SizedBox(width: 8),
//                         Icon(Icons.volume_up, size: 20),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Container(
//                 width: double.infinity,
//                 height: 60,
//                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.all(12),
//                 child: Text('الراوي: ${hadith.raawi}', style: const TextStyle(color: Colors.black87)),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                   padding: const EdgeInsets.all(14),
//                   child: SingleChildScrollView(
//                     child: Text(
//                       uploadedText.isNotEmpty ? uploadedText : hadith.content,
//                       style: const TextStyle(color: Colors.black87, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(icon: const Icon(Icons.headset), onPressed: _playHadithAsset),
//                   IconButton(
//                       icon: Icon(_isRecording ? Icons.stop : Icons.mic),
//                       onPressed: _isRecording ? _stopRecording : _startRecording),
//                   if (_recordedFilePath != null) IconButton(icon: const Icon(Icons.play_arrow), onPressed: _playRecorded),
//                   ElevatedButton(
//                     onPressed: uploadedText.isEmpty ? _uploadAndShowText : _onShowResult,
//                     style: ElevatedButton.styleFrom(backgroundColor: _showResult ? Colors.green : const Color(0xFFBBBBBB)),
//                     child: Text(_showResult
//                         ? 'النتيجة: ${((_lastScore ?? 0) * 100).toStringAsFixed(0)}/100'
//                         : uploadedText.isEmpty
//                             ? 'حفظ وارسال'
//                             : 'عرض النتيجة'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: const Color(0xFF088395),
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: prev,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.arrow_back, color: Colors.white),
//                     SizedBox(height: 4),
//                     Text('السابق', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: next,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.arrow_forward, color: Colors.white),
//                     SizedBox(height: 4),
//                     Text('التالي', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:alhekma/repository/books_repository.dart';
// import 'package:alhekma/presenters/hadith_presenter.dart';
// import '../../models/book_model.dart';
// import '../../services/playback_service.dart';
// import '../../services/recording_service.dart';
// import '../../services/transcription_service.dart';

// class HadithDetailPage extends StatefulWidget {
//   final int bookId;
//   final int initialIndex;

//   const HadithDetailPage({required this.bookId, required this.initialIndex, super.key});

//   @override
//   State<HadithDetailPage> createState() => _HadithDetailPageState();
// }

// class _HadithDetailPageState extends State<HadithDetailPage> {
//   late int currentIndex;
//   final PlaybackService _playback = PlaybackService();
//   final RecordingService _recorder = RecordingService();
//   final HadithPresenter presenter = HadithPresenter();
//   final BooksRepository _repo = BooksRepository();
//   final AudioPlayer _player = AudioPlayer(); // لتشغيل الصوت وعرض السلايدر

//   Book? book;
//   bool _isLoading = true;
//   bool _isRecording = false;
//   String? _recordedFilePath;
//   String uploadedText = '';
//   double? _lastScore;
//   bool _showResult = false;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.initialIndex;
//     loadBook(widget.bookId);
//   }

//   @override
//   void dispose() {
//     _player.dispose();
//     super.dispose();
//   }

//   Future<void> loadBook(int id) async {
//     try {
//       book = await _repo.fetchAndCacheById(id);
//     } catch (_) {
//       book = _repo.getCachedBookById(id);
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   void next() {
//     if (book != null && currentIndex < book!.hadiths.length - 1) {
//       setState(() {
//         currentIndex++;
//         resetAudio();
//       });
//     }
//   }

//   void prev() {
//     if (book != null && currentIndex > 0) {
//       setState(() {
//         currentIndex--;
//         resetAudio();
//       });
//     }
//   }

//   void resetAudio() {
//     _player.stop();
//     _recordedFilePath = null;
//     uploadedText = '';
//     _lastScore = null;
//     _showResult = false;
//     _isRecording = false;
//   }

//   Future<void> _playHadithAsset() async {
//     if (book == null) return;
//     final path = 'assets/audio/hadith_${book!.hadiths[currentIndex].id}.mp3';
//     await _player.setAsset(path);
//     _player.play();
//   }

//   Future<void> _startRecording() async {
//     if (book == null) return;
//     final path = await _recorder.startRecording(fileName: 'hadith_${book!.hadiths[currentIndex].id}.m4a');
//     if (path != null) {
//       setState(() {
//         _isRecording = true;
//         _recordedFilePath = path;
//       });
//     }
//   }

//   Future<void> _stopRecording() async {
//     await _recorder.stopRecording();
//     setState(() {
//       _isRecording = false;
//     });
//   }

//   void _playRecorded() async {
//     if (_recordedFilePath != null) {
//       await _player.setFilePath(_recordedFilePath!);
//       _player.play();
//     }
//   }

//   void _uploadAndShowText() async {
//     if (_recordedFilePath != null) {
//       final text = await TranscriptionService.uploadAndTranscribe(_recordedFilePath!);
//       setState(() {
//         uploadedText = text;
//       });
//     }
//   }

//   void _onShowResult() {
//     if (book == null) return;
//     final original = book!.hadiths[currentIndex].content;
//     final edited = uploadedText;
//     final score = presenter.calculateSimilarity(original, edited);
//     setState(() {
//       _lastScore = score;
//       _showResult = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }
//     if (book == null) {
//       return const Scaffold(body: Center(child: Text('لا يوجد بيانات لهذا الكتاب')));
//     }

//     final hadith = book!.hadiths[currentIndex];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF088395),
//         toolbarHeight: 72,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(child: Text(hadith.title, style: const TextStyle(fontSize: 16))),
//             Stack(
//               children: const [
//                 CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.person)),
//                 Positioned(
//                   left: 6,
//                   top: 4,
//                   child: SizedBox(
//                     width: 8,
//                     height: 8,
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 74,
//                     height: 35,
//                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(Icons.book, size: 16),
//                         SizedBox(width: 6),
//                         Text('150', style: TextStyle(fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                   const Expanded(child: SizedBox()),
//                   GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: const Text('تنويه'),
//                           content: const Text('قد يرد في هذا الحديث مفردات لها عدّة قراءات\nيرجى الاستماع للحديث'),
//                           actions: [
//                             TextButton(onPressed: () => Navigator.pop(context), child: const Text('تم'))
//                           ],
//                         ),
//                       );
//                     },
//                     child: Row(
//                       children: const [
//                         Text('سمّع الحديث النبوي !', style: TextStyle(color: Color(0xFF8F8D7D))),
//                         SizedBox(width: 8),
//                         Icon(Icons.volume_up, size: 20),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Container(
//                 width: double.infinity,
//                 height: 60,
//                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.all(12),
//                 child: Text('الراوي: ${hadith.raawi}', style: const TextStyle(color: Colors.black87)),
//               ),
//               const SizedBox(height: 12),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//                   padding: const EdgeInsets.all(14),
//                   child: SingleChildScrollView(
//                     child: Text(
//                       uploadedText.isNotEmpty ? uploadedText : hadith.content,
//                       style: const TextStyle(color: Colors.black87, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: uploadedText.isEmpty ? _uploadAndShowText : _onShowResult,
//                 style: ElevatedButton.styleFrom(backgroundColor: _showResult ? Colors.green : const Color(0xFFBBBBBB)),
//                 child: Text(_showResult
//                     ? 'النتيجة: ${((_lastScore ?? 0) * 100).toStringAsFixed(0)}/100'
//                     : uploadedText.isEmpty
//                         ? 'حفظ وارسال'
//                         : 'عرض النتيجة'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: StreamBuilder<Duration>(
//         stream: _player.positionStream,
//         builder: (context, snapshot) {
//           final position = snapshot.data ?? Duration.zero;
//           final duration = _player.duration ?? Duration.zero;

//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (_player.playing || _isRecording)
//                 Slider(
//                   value: position.inSeconds.toDouble(),
//                   min: 0,
//                   max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1,
//                   onChanged: (value) {
//                     _player.seek(Duration(seconds: value.toInt()));
//                   },
//                 ),
//               BottomAppBar(
//                 color: const Color(0xFF088395),
//                 child: SizedBox(
//                   height: 64,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       GestureDetector(
//                         onTap: prev,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Icon(Icons.arrow_back, color: Colors.white),
//                             SizedBox(height: 4),
//                             Text('السابق', style: TextStyle(color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: _playHadithAsset,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Icon(Icons.headset, color: Colors.white),
//                             SizedBox(height: 4),
//                             Text('استماع', style: TextStyle(color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: _isRecording ? _stopRecording : _startRecording,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.white),
//                             const SizedBox(height: 4),
//                             const Text('تسميع', style: TextStyle(color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: next,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Icon(Icons.arrow_forward, color: Colors.white),
//                             SizedBox(height: 4),
//                             Text('التالي', style: TextStyle(color: Colors.white)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alhekma/repository/books_repository.dart';
import 'package:alhekma/presenters/hadith_presenter.dart';
import '../../models/book_model.dart';
import '../../services/playback_service.dart';
import '../../services/recording_service.dart';
import '../../services/transcription_service.dart';

class HadithDetailPage extends StatefulWidget {
  final int bookId;
  final int initialIndex;

  const HadithDetailPage({required this.bookId, required this.initialIndex, super.key});

  @override
  State<HadithDetailPage> createState() => _HadithDetailPageState();
}

class _HadithDetailPageState extends State<HadithDetailPage> {
  late int currentIndex;
  final PlaybackService _playback = PlaybackService();
  final RecordingService _recorder = RecordingService();
  final HadithPresenter presenter = HadithPresenter();
  final BooksRepository _repo = BooksRepository();
  final AudioPlayer _player = AudioPlayer();

  Book? book;
  bool _isLoading = true;
  bool _isRecording = false;
  String? _recordedFilePath;
  String uploadedText = '';
  double? _lastScore;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    loadBook(widget.bookId);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> loadBook(int id) async {
    try {
      book = await _repo.fetchAndCacheById(id);
    } catch (_) {
      book = _repo.getCachedBookById(id);
    }
    await _loadRecordedFilePath(); 
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadRecordedFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/hadith_${book!.hadiths[currentIndex].id}.m4a');
    if (await file.exists()) {
      _recordedFilePath = file.path;
    }
  }

  void next() async {
    if (book != null && currentIndex < book!.hadiths.length - 1) {
      setState(() {
        currentIndex++;
        uploadedText = '';
        _lastScore = null;
        _showResult = false;
      });
      await _loadRecordedFilePath();
    }
  }

  void prev() async {
    if (book != null && currentIndex > 0) {
      setState(() {
        currentIndex--;
        uploadedText = '';
        _lastScore = null;
        _showResult = false;
      });
      await _loadRecordedFilePath();
    }
  }

  Future<void> _playAudio() async {
    if (_recordedFilePath != null) {
      await _player.setFilePath(_recordedFilePath!);
    } else {
      final path = 'assets/audio/hadith_${book!.hadiths[currentIndex].id}.mp3';
      await _player.setAsset(path);
    }
    _player.play();
  }

  Future<void> _startRecording() async {
    if (book == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/hadith_${book!.hadiths[currentIndex].id}.m4a';

    final savedPath = await _recorder.startRecording(
  fileName: 'hadith_${book!.hadiths[currentIndex].id}',
);

    if (savedPath != null) {
      setState(() {
        _isRecording = true;
        _recordedFilePath = savedPath;
      });
    }
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecording();
    setState(() {
      _isRecording = false; 
    });
    await _loadRecordedFilePath();
  }

  void _uploadAndShowText() async {
    if (_recordedFilePath != null) {
      final text = await TranscriptionService.uploadAndTranscribe(_recordedFilePath!);
      setState(() {
        uploadedText = text;
      });
    }
  }

  void _onShowResult() {
    if (book == null) return;
    final original = book!.hadiths[currentIndex].content;
    final edited = uploadedText;
    final score = presenter.calculateSimilarity(original, edited);
    setState(() {
      _lastScore = score;
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (book == null) {
      return const Scaffold(body: Center(child: Text('لا يوجد بيانات لهذا الكتاب')));
    }

    final hadith = book!.hadiths[currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF088395),
        toolbarHeight: 72,
        title: Text(hadith.title, style: const TextStyle(fontSize: 16)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(12),
                child: Text('الراوي: ${hadith.raawi}', style: const TextStyle(color: Colors.black87)),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(14),
                  child: SingleChildScrollView(
                    child: Text(
                      uploadedText.isNotEmpty ? uploadedText : hadith.content,
                      style: const TextStyle(color: Color(0xffF4862C), fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: uploadedText.isEmpty ? _uploadAndShowText : _onShowResult,
                style: ElevatedButton.styleFrom(backgroundColor: _showResult ? Color(0xff34B2C4) : const Color(0xFFBBBBBB)),
                child: Text(_showResult
                    ? 'النتيجة: ${((_lastScore ?? 0) * 100).toStringAsFixed(0)}/100'
                    : uploadedText.isEmpty
                        ? 'حفظ وارسال'
                        : 'عرض النتيجة'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StreamBuilder<Duration>(
        stream: _player.positionStream,
        builder: (context, snapshot) {
          final position = snapshot.data ?? Duration.zero;
          final duration = _player.duration ?? Duration.zero;

          final showSlider = _player.playing || _isRecording || (_recordedFilePath != null);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showSlider)
                Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0,
                  max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1,
                  onChanged: (value) {
                    _player.seek(Duration(seconds: value.toInt()));
                  },
                ),
              BottomAppBar(
                color: const Color(0xFF088395),
                child: SizedBox(
                  height: 64,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: prev,
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: _playAudio,
                        child: const Icon(Icons.headset, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: _isRecording ? _stopRecording : _startRecording,
                        child: Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: next,
                        child: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
