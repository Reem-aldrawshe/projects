import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/auth/books/books_bloc.dart';
import 'package:test_app/blocs/auth/books/books_event.dart';
import 'package:test_app/blocs/auth/books/books_state.dart';
import 'package:test_app/blocs/profile/profile_bloc.dart';
import 'package:test_app/blocs/profile/profile_event.dart';
import 'package:test_app/blocs/profile/profile_state.dart';
import 'package:test_app/models/book_model.dart';
import 'package:test_app/repository/profile_repository.dart';
import 'package:test_app/services/auth_service.dart';
import 'package:test_app/views/books/hadiths_page.dart';
import 'package:test_app/views/hadith_list_page.dart';

// // محلي
// class ArbaoonScreen extends StatelessWidget {
//   const ArbaoonScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('الأربعون النووية')),
//       body: const Center(child: Text('صفحة الأربعون النووية - محلي')),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openProfileDrawer(String token) {
  _scaffoldKey.currentState?.openEndDrawer();
  // بعد الفتح نضيف حدث تحميل البروفايل
  context.read<ProfileBloc>().add(LoadProfile());
}

  @override
  void initState() {
    super.initState();
    context.read<BooksBloc>().add(BooksRequested()); // جلب الكتب من الباك
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFEFF1F3),
      appBar: AppBar(
        backgroundColor: const Color(0xff088395),
        elevation: 0,
        title: const Text('حديث النيات', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: [
       IconButton(
  icon: const Icon(Icons.person),
  onPressed: () {
    _scaffoldKey.currentState?.openEndDrawer();
  },
),


          const SizedBox(width: 10),
        ],
      ),

     endDrawer: Drawer(
  width: 298,
  child: BlocProvider(
    create: (_) => ProfileBloc(
        repository: ProfileRepository(authService: AuthService()))
      ..add(LoadProfile()),
    child: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: const BoxDecoration(
                  color: Color(0xFF00A9A9),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: Color(0xFF00A9A9)),
                    ),
                    const SizedBox(height: 10),
                    Text(state.username,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text(state.email,
                        style: const TextStyle(color: Colors.white70, fontSize: 16)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 20),
                  children: [
                    ListTile(
                      leading: Icon(Icons.vpn_key_outlined, color: Colors.grey[700]),
                      title: const Text("إعادة تعيين كلمة المرور",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.grey[700]),
                      title: const Text("تسجيل الخروج",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      onTap: () {
                        context.read<ProfileBloc>().add(LogoutProfile());
                        Navigator.pop(context); // غلق الدراور بعد Logout
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else if (state is ProfileLogout) {
          return const Center(child: Text("تم تسجيل الخروج"));
        } else {
          return const SizedBox.shrink();
        }
      },
    ),
  ),
),

      body: SafeArea(
        child: BlocBuilder<BooksBloc, BooksState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null && state.books.isEmpty) {
              return Center(child: Text('خطأ: ${state.error}'));
            }

Book? findByTitle(List<Book> books, String keyword) {
  for (final b in books) {
    if (b.title.contains(keyword)) return b;
  }
  return null;
}

final Book? jawame3Book = findByTitle(state.books, 'جوامع الإسلام');
final Book? kawakibBook = findByTitle(state.books, 'الكواكب الزاهرة');

            // // فلترة الكتب المطلوبة من الباك
            // final jawame3Book = state.books.firstWhere(
            //   (b) => b.title.contains('جوامع الإسلام'),
            //   orElse: () => null,
            // );
            // final kawakibBook = state.books.firstWhere(
            //   (b) => b.title.contains('الكواكب الزاهرة'),
            //   orElse: () => null,
            // );

            return Center(
              child: SizedBox(
                width: 390,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),

                    // المربع الأول - الأربعين النووية (محلي)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HadithListPage()),
                        );
                      },
                      child: Container(
                        width: 300,
                        height: 160,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9FCAD7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/image1.png',
                            width: 202,
                            height: 102,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // المربع الثاني - جوامع الإسلام (من الباك)
                    if (jawame3Book != null)
                      GestureDetector(
                        onTap: () {
                          context.read<BooksBloc>().add(BookByIdRequested(jawame3Book.id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HadithsPage(
                                bookId: jawame3Book.id,
                                bookTitle: jawame3Book.title,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color(0xFF9FCAD7),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1),
                          ),
                          child: Center(
                            child: Text(
                              jawame3Book.title,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 12),

                    // المربع الثالث - الكواكب الزاهرة (من الباك)
                    if (kawakibBook != null)
                      GestureDetector(
                        onTap: () {
                          context.read<BooksBloc>().add(BookByIdRequested(kawakibBook.id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HadithsPage(
                                bookId: kawakibBook.id,
                                bookTitle: kawakibBook.title,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color(0xFF9FCAD7),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1),
                          ),
                          child: Center(
                            child: Text(
                              kawakibBook.title,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
