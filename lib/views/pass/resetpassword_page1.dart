import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/views/pass/resetpassword_page2.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // المربع الأبيض الخلفي
            Positioned(
              top: 60.h,
              left: 20.w,
              child: Container(
                width: 350.w,
                height: 700.h,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
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

            // عنوان "إعادة تعيين كلمة المرور"
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
                    color: const Color(0xff088395),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // صورة forgetpass (لازم تحط الصورة بمجلد assets وتعريفها في pubspec.yaml)
            Positioned(
              top: 152.h,
              left: 95.w,
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Image.asset(
                  'assets/images/forgetpass.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // النص تحت الصورة
            Positioned(
              top: 256.h,
              left: 38.w,
              child: SizedBox(
             //   width: 279.w,
              //  height: 42.h,
                child: Text(
                  'سنرسل لبريدك الإلكتروني رمز تحقق n/ من 6 خانات',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xFF7D7C73),
                    fontWeight: FontWeight.w400,
                  ),
              //    textAlign: TextAlign.center,
                ),
              ),
            ),

            // كلمة البريد الإلكتروني
            Positioned(
              top: 452.h,
              left: 235.w,
              child: SizedBox(
                width: 102.w,
                height: 35.h,
                child: Text(
                  'البريد الإلكتروني',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF8F8D7D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            // حقل إدخال البريد الإلكتروني
            Positioned(
              top: 512.h,
              left: 45.w,
              child: Container(
                width: 300.w,
                height: 47.13.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xff8F8D7D), width: 1),
                ),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'youruser123@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 16.sp, color: Color(0xff393939)),
                ),
              ),
            ),

            // زر إرسال الرمز
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
                  onPressed: () {
                    // نروح للصفحة الثانية مع تمرير الإيميل لو حبيت
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResetPassword2Page(
                          email: emailController.text.trim(),
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 90.w,
                    height: 37.h,
                    child: Center(
                      child: Text(
                        'إرسال الرمز',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:test_app/views/pass/resetpassword_page2.dart';

// class ResetPasswordPage extends StatefulWidget {
//   const ResetPasswordPage({super.key});

//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }

// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final TextEditingController emailController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             /// المربع الأبيض الخلفي
//             Positioned(
//               top: 60.h,
//               left: 20.w,
//               child: Container(
//                 width: 350.w,
//                 height: 700.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffFFFFFF),
//                   borderRadius: BorderRadius.circular(10.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8.r,
//                       offset: Offset(0, 4.h),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             /// العنوان
//             Positioned(
//               top: 100.h,
//               left: 90.w,
//               child: SizedBox(
//                 width: 210.w,
//                 height: 37.h,
//                 child: Text(
//                   'إعادة تعيين كلمة المرور',
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     color: const Color(0xff088395),
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),

//             /// صورة النسيان
//             Positioned(
//               top: 152.h,
//               left: 95.w,
//               child: SizedBox(
//                 width: 200.w,
//                 height: 200.h,
//                 child: Image.asset(
//                   'assets/images/forgetpass.gif',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),

//             /// النص تحت الصورة - سطرين
//             Positioned(
//               top: 256.h,
//               left: 38.w,
//               child: SizedBox(
//                 width: 279.w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'سنرسل لبريدك الإلكتروني رمز تحقق',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         color: const Color(0xFF7D7C73),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Text(
//                       'من 6 خانات',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         color: const Color(0xFF7D7C73),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             /// نص البريد الإلكتروني
//             Positioned(
//               top: 452.h,
//               left: 235.w,
//               child: SizedBox(
//                 width: 102.w,
//                 height: 35.h,
//                 child: Text(
//                   'البريد الإلكتروني',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: const Color(0xFF8F8D7D),
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),

//             /// حقل إدخال البريد الإلكتروني
//             Positioned(
//               top: 512.h,
//               left: 45.w,
//               child: Container(
//                 width: 300.w,
//                 height: 47.13.h,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.r),
//                   border: Border.all(
//                     color: const Color(0xff8F8D7D),
//                     width: 1,
//                   ),
//                 ),
//                 child: TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     hintText: 'youruser123@gmail.com',
//                     hintStyle: TextStyle(
//                       color: const Color(0xff393939),
//                       fontSize: 16.sp,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 12.w,
//                       vertical: 12.h,
//                     ),
//                     border: InputBorder.none,
//                   ),
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: const Color(0xff393939),
//                   ),
//                 ),
//               ),
//             ),

//             /// زر إرسال الرمز
//             Positioned(
//               top: 686.h,
//               left: 39.w,
//               child: SizedBox(
//                 width: 312.w,
//                 height: 54.h,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF088395),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ResetPassword2Page(
//                           email: emailController.text.trim(),
//                         ),
//                       ),
//                     );
//                   },
//                   child: SizedBox(
//                     width: 90.w,
//                     height: 37.h,
//                     child: Center(
//                       child: Text(
//                         'إرسال الرمز',
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
