import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alhekma/blocs/auth/auth_bloc.dart';
import 'package:alhekma/blocs/auth/auth_event.dart';
import 'package:alhekma/blocs/auth/auth_state.dart';
import 'package:alhekma/views/home_screen.dart';
import 'package:alhekma/views/pass/resetpassword_page1.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final username = _emailController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة البريد الإلكتروني وكلمة المرور')),
      );
      return;
    }

    context.read<AuthBloc>().add(LoginRequested(username: username, password: password));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: 60.h,
              left: 20.w,
              child: Container(
                width: 350.w,
                height: 700.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 100.h,
              left: 131.w,
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xFF088395),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Positioned(
              top: 275.h,
              left: 238.w,
              child: Text(
                'البريد الإلكتروني',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF8F8D7D),
                ),
              ),
            ),

            Positioned(
              top: 317.h,
              left: 45.w,
              child: SizedBox(
                width: 300.w,
                height: 47.h,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'youruser123@gmail.com',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFF8F8D7D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFF088395)),
                    ),
                  ),
                ),
              ),
            ),

           
            Positioned(
              top: 395.h,
              left: 264.w,
              child: Text(
                'كلمة المرور',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF8F8D7D),
                ),
              ),
            ),

         
            Positioned(
              top: 437.h,
              left: 45.w,
              child: SizedBox(
                width: 300.w,
                height: 47.h,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '********',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFF8F8D7D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFF088395)),
                    ),
                  ),
                ),
              ),
            ),

         
            Positioned(
              top: 615.h,
              left: 215.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetPasswordPage()));
                },
                child: Text(
                  'نسيت كلمة المرور ؟',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 615.h,
              left: 65.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetPasswordPage()));
                },
                child: Text(
                  'إعادة تعيين كلمة المرور',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

         
            Positioned(
              top: 686.h,
              left: 39.w,
              child: SizedBox(
                width: 312.w,
                height: 54.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF088395),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: _login,
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
