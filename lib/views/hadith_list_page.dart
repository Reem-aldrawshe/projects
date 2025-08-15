
import 'package:flutter/material.dart';
import 'package:alhekma/models/hadith.dart';
import 'package:alhekma/views/hadith_details_page.dart';

class HadithListPage extends StatelessWidget {
  const HadithListPage({super.key});

  void openProfileDrawer() {
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
              const Spacer(),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16),
              child: Row(
                children: [
                  const SizedBox(width: 175),
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
                  color: const Color(0xFFE9FCFF), 
                  border: Border.all(color: const Color(0xFF9FCAD7)), 
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
