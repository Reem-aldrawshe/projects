import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/auth/books/books_bloc.dart';
import 'package:test_app/blocs/auth/books/books_event.dart';
import 'package:test_app/blocs/auth/books/books_state.dart';
import 'package:test_app/views/books/hadiths_page.dart';


class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  @override
  void initState() {
    super.initState();
    context.read<BooksBloc>().add(BooksRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF088395),
        toolbarHeight: 72,
        title: const Text('الأربعون النووية'), // طبقتي عنوان ثابت؛ ممكن تغيّريه ديناميك
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                // افتح profile drawer — تقدر تعدّلي محتواه لاحقاً
                Scaffold.of(context).openEndDrawer();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Center(child: Text('Profile drawer - عدّليه انتِ')),
      ),
      body: SafeArea(
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            if (state.loading) return const Center(child: CircularProgressIndicator());

            if (state.error != null && state.books.isEmpty) {
              return Center(child: Text('خطأ: ${state.error}'));
            }

            final books = state.books;
            if (books.isEmpty) return const Center(child: Text('لا توجد كتب'));

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: books.length,
              itemBuilder: (context, i) {
                final book = books[i];
                return GestureDetector(
                  onTap: () {
                    // عند الضغط نطلب كتاب حسب id ثم نفتح صفحة الأحـاديث
                    context.read<BooksBloc>().add(BookByIdRequested(book.id));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => HadithsPage(bookId: book.id, bookTitle: book.title),
                    ));
                  },
                  child: BookCard(bookTitle: book.title, description: book.description),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String bookTitle;
  final String description;
  const BookCard({required this.bookTitle, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF9FCAD7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.book, size: 36, color: Color(0xFF115C7B)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bookTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
