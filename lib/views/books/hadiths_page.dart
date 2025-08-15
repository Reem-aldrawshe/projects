import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhekma/blocs/auth/books/books_bloc.dart';
import 'package:alhekma/blocs/auth/books/books_state.dart';
import 'package:alhekma/views/hadith/hadith_detail_page.dart';

class HadithsPage extends StatelessWidget {
  final int bookId;
  final String bookTitle;
  const HadithsPage({required this.bookId, required this.bookTitle, super.key});

  void openProfileDrawer() {
    // ضع هنا الكود لفتح البروفايل
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      
      appBar: AppBar(
  backgroundColor: const Color(0xFF088395),
  elevation: 0,
  toolbarHeight: 72,
  automaticallyImplyLeading: false,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
  title: Center(
    child: Text(
      bookTitle,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 16),
      child: Stack(
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
            left: 0,
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
    ),
  ],
),

      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          final book = state.selectedBook;
          if (state.loading) return const Center(child: CircularProgressIndicator());
          if (book == null) return const Center(child: Text('لا توجد بيانات للكتاب'));

          final hadiths = book.hadiths;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            itemCount: hadiths.length,
            itemBuilder: (context, idx) {
              final h = hadiths[idx];
              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>HadithDetailPage(bookId: book.id, initialIndex: idx)
,
                    ));
                  },
                  child: Container(
                    width: double.infinity,
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
                    alignment: Alignment.center,
                    child: Text(
                      h.title,
                      style: const TextStyle(
                        color: Color(0xFF115C7B),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
