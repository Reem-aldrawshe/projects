import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword3Page extends StatefulWidget {
  const ResetPassword3Page({super.key});

  @override
  State<ResetPassword3Page> createState() => _ResetPassword3PageState();
}

class _ResetPassword3PageState extends State<ResetPassword3Page> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة جميع الحقول')),
      );
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, '/login'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
              left: 90.w,
              child: SizedBox(
                width: 210.w,
                height: 37.h,
                child: Text(
                  'إعادة تعيين كلمة المرور',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF088395),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Positioned(
              top: 252.h,
              left: 261.w,
              child: SizedBox(
                width: 76.w,
                height: 35.h,
                child: Text(
                  'كلمة المرور',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF8F8D7D),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),

            Positioned(
              top: 294.h,
              left: 45.w,
              child: SizedBox(
                width: 300.w,
                height: 47.13.h,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '********',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF8F8D7D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF8F8D7D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF088395)),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 353.h,
              left: 225.w,
              child: SizedBox(
                width: 112.w,
                height: 35.h,
                child: Text(
                  'تأكيد كلمة المرور',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF8F8D7D),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),

            Positioned(
              top: 395.h,
              left: 45.w,
              child: SizedBox(
                width: 300.w,
                height: 47.13.h,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '********',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF8F8D7D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF8F8D7D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: const Color(0xFF088395)),
                    ),
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
                  onPressed: _onSubmit,
                  child: Center(
                    child: Text(
                      'تعيين',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
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
