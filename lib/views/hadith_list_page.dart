// import 'package:flutter/material.dart';
// import 'package:test_app/models/hadith.dart';
// import 'package:test_app/views/hadith_details_page.dart';


// class HadithListPage extends StatelessWidget {
//   const HadithListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF088395),
//         title: const Text('الأربعون النووية'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: arbaoonHadiths.length,
//         itemBuilder: (context, index) {
//           final hadith = arbaoonHadiths[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 12.0),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => HadithDetailsPage(hadith: hadith),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 20.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     'الحديث ${hadith.id}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:test_app/models/hadith.dart';
import 'package:test_app/views/hadith_details_page.dart';

class HadithListPage extends StatelessWidget {
  const HadithListPage({super.key});

  void openProfileDrawer() {
    // ضع هنا الكود لفتح البروفايل
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBar(
          backgroundColor: const Color(0xFF088395),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 16),
              // النص جنب البروفايل لاحقاً مع Spacer لتنسيق المسافة
              const Spacer(),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16),
              child: Row(
                children: [
                  const SizedBox(width: 175), // موقع النص حسب ما أعطيتِ
                  const Text(
                    'الأربعون النووية',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: openProfileDrawer,
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.teal),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        itemCount: arbaoonHadiths.length,
        itemBuilder: (context, index) {
          final hadith = arbaoonHadiths[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HadithDetailsInteractivePage(),
                  ),
                );
              },
              child: Container(
                width: 370,
                height: 59,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9FCFF), // خلفية المربع
                  border: Border.all(color: const Color(0xFF9FCAD7)), // الحواف
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'الحديث ${hadith.id}',
                    style: const TextStyle(
                      color: Color(0xFF115C7B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
