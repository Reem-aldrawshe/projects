import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:alhekma/blocs/auth/books/books_bloc.dart';
import 'package:alhekma/blocs/auth/books/books_event.dart';
import 'package:alhekma/blocs/auth/auth_bloc.dart';
import 'package:alhekma/local/adapters.dart';
import 'package:alhekma/local/hive_helper.dart';
import 'package:alhekma/models/book_model.dart';
import 'package:alhekma/repository/books_repository.dart';
import 'package:alhekma/repository/auth_repository.dart';
import 'package:alhekma/services/auth_service.dart';
import 'package:alhekma/views/login/splash_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await Hive.initFlutter();
  Hive.registerAdapter(HadithAdapter());
  Hive.registerAdapter(BookAdapter());
  await Hive.openBox<Book>(HiveHelper.booksBoxName);

  final booksRepository = BooksRepository();
  final authRepository = AuthRepository(AuthService());

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://e919e2c9f3df115080bb4cee1d11bbd3@o4509839127019520.ingest.us.sentry.io/4509839157952512';
      options.tracesSampleRate = 1.0; 
    },
    appRunner: () {
      runApp(MyApp(
        booksRepository: booksRepository,
        authRepository: authRepository,
      ));
    },
  );
}

class MyApp extends StatelessWidget {
  final BooksRepository booksRepository;
  final AuthRepository authRepository;

  const MyApp({
    super.key,
    required this.booksRepository,
    required this.authRepository,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  BooksBloc(repository: booksRepository)..add(BooksRequested()),
            ),
            BlocProvider(
              create: (_) => AuthBloc(authRepository: authRepository),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:alhekma/blocs/auth/books/books_bloc.dart';
// import 'package:alhekma/blocs/auth/books/books_event.dart';
// import 'package:alhekma/blocs/auth/auth_bloc.dart';
// import 'package:alhekma/local/adapters.dart';
// import 'package:alhekma/local/hive_helper.dart';
// import 'package:alhekma/models/book_model.dart';
// import 'package:alhekma/repository/books_repository.dart';
// import 'package:alhekma/repository/auth_repository.dart';
// import 'package:alhekma/services/auth_service.dart';
// import 'package:alhekma/views/login/splash_screen.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await ScreenUtil.ensureScreenSize();

//   await Hive.initFlutter();
//   Hive.registerAdapter(HadithAdapter());
//   Hive.registerAdapter(BookAdapter());
//   await Hive.openBox<Book>(HiveHelper.booksBoxName);

//   final booksRepository = BooksRepository();
//   final authRepository = AuthRepository(AuthService());

//   // تهيئة Sentry قبل تشغيل التطبيق
//   await SentryFlutter.init(
//     (options) {
//       options.dsn =
//           'https://e919e2c9f3df115080bb4cee1d11bbd3@o4509839127019520.ingest.us.sentry.io/4509839157952512';
//       options.tracesSampleRate = 1.0; // لتتبع الأداء (اختياري)
//     },
//     appRunner: () {
//       runApp(MyApp(
//         booksRepository: booksRepository,
//         authRepository: authRepository,
//       ));
//     },
//   );
// }

// class MyApp extends StatelessWidget {
//   final BooksRepository booksRepository;
//   final AuthRepository authRepository;

//   const MyApp({
//     super.key,
//     required this.booksRepository,
//     required this.authRepository,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       builder: (context, child) {
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (_) =>
//                   BooksBloc(repository: booksRepository)..add(BooksRequested()),
//             ),
//             BlocProvider(
//               create: (_) => AuthBloc(authRepository: authRepository),
//             ),
//           ],
//           child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: Scaffold(
//               body: Stack(
//                 children: [
//                   const SplashScreen(),
//                   Positioned(
//                     bottom: 20,
//                     right: 20,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // زر لاختبار Sentry
//                         throw Exception('Test Sentry error!');
//                       },
//                       child: const Text('Test Sentry'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
