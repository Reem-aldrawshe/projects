import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alhekma/views/login/login_screen.dart';
import 'package:alhekma/views/home_screen.dart';
import 'package:alhekma/views/login/register_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              left: 112.w,
              child: SizedBox(
                width: 167.w,
                height: 37.h,
                child: Text(
                  'جاهز لنتعلم المزيد؟',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF088395),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

           
            Positioned(
              top: 172.h,
              left: 95.w,
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Image.asset(
                  'assets/images/computer.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Positioned(
              top: 434.h,
              left: 39.w,
              child: SizedBox(
                width: 312.w,
                height: 54.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF088395),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterPageSimple()),
                    );
                  },
                  child: Text(
                    'إنشاء حساب',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 515.h,
              left: 184.w,
              child: SizedBox(
                width: 133.w,
                height: 30.h,
                child: Text(
                  'لديك حساب بالفعل؟ ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 515.h,
              left: 74.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                child: SizedBox(
                  width: 89.w,
                  height: 32.h,
                  child: Text(
                    'تسجيل دخول',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 600.h,
              left: 83.w,
              child: Row(
                children: [
                  Container(
                    width: 90.w,
                    height: 1,
                    color: Color(0xFFAAAAAA),
                  ),
                  SizedBox(width: 8.w),
                  Text('أو', style: TextStyle(fontSize: 14.sp)),
                  SizedBox(width: 8.w),
                  Container(
                    width: 90.w,
                    height: 1,
                    color: Color(0xFFAAAAAA),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 639.h,
              left: 39.w,
              child: SizedBox(
                width: 312.w,
                height: 54.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF088395)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  },
                  child: Text(
                    'تصفح التطبيق',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Color(0xFF088395),
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
