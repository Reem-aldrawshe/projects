
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:test_app/blocs/auth/auth_bloc.dart';
// import 'package:test_app/blocs/auth/auth_event.dart';
// import 'package:test_app/blocs/auth/auth_state.dart';
// import 'package:test_app/models/user_register_model.dart';

// class RegisterPageSimple extends StatefulWidget {
//   @override
//   _RegisterPageSimpleState createState() => _RegisterPageSimpleState();
// }

// class _RegisterPageSimpleState extends State<RegisterPageSimple> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // خلفية المربع الأبيض بقياسات ثابتة حسب طلبك
//     // نسيت تحددي ارتفاع الشاشة لكن حسب المقاسات هذي التصميم هيكون scrollable لو صغير

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocConsumer<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state is AuthAuthenticated) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text('تم إنشاء الحساب بنجاح!')));
//               Navigator.of(context).pushReplacementNamed('/login');
//             } else if (state is AuthError) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.message)));
//             }
//           },
//           builder: (context, state) {
//             return Stack(
//               children: [
//                 // المربع الأبيض في الخلفية
//                 Positioned(
//                   top: 112.h,
//                   left: 20.w,
//                   child: Container(
//                     width: 350.w,
//                     height: 700.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 8.r,
//                           offset: Offset(0, 4.h),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // محتوى الصفحة فوق المربع الأبيض
//                 SingleChildScrollView(
//                   padding: EdgeInsets.only(
//                     top: 152.h,
//                     left: 20.w,
//                     right: 20.w,
//                     bottom: 40.h,
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // عنوان "إنشاء حساب"
//                         Center(
//                           child: Text(
//                             'إنشاء حساب',
//                             style: TextStyle(
//                               fontSize: 20.sp,
//                               color: Color(0xFF088395),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),

//                         SizedBox(
//                           height: 56.h,
//                         ), // فرق المسافة لتمركز باقي الحقول
//                         // الاسم - النص فوق الحقل (يمين الصفحة)
//                         Padding(
//                           padding: EdgeInsets.only(right: 20.w),
//                           child: Text(
//                             'الاسم',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: Color(0xFF8F8D7D),
//                               height: 2.2, // لضبط الارتفاع (تقريبًا 35px)
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),

//                         SizedBox(height: 6.h),

//                         // حقل الاسم
//                         Center(
//                           child: Container(
//                             width: 300.w,
//                             height: 47.13.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(
//                                 color: Color(0xFF8F8D7D),
//                                 width: 1,
//                               ),
//                               color: Colors.white,
//                             ),
//                             child: TextFormField(
//                               controller: nameController,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 12.w,
//                                   vertical: 12.h,
//                                 ),
//                                 hintText: 'أدخل الاسم',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'يرجى إدخال الاسم';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

//                         // البريد الإلكتروني - النص فوق الحقل
//                         Padding(
//                           padding: EdgeInsets.only(right: 20.w),
//                           child: Text(
//                             'البريد الإلكتروني',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: Color(0xFF8F8D7D),
//                               height: 2.2,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),

//                         SizedBox(height: 6.h),

//                         // حقل البريد الإلكتروني
//                         Center(
//                           child: Container(
//                             width: 300.w,
//                             height: 47.13.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(
//                                 color: Color(0xFF8F8D7D),
//                                 width: 1,
//                               ),
//                               color: Colors.white,
//                             ),
//                             child: TextFormField(
//                               controller: emailController,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 12.w,
//                                   vertical: 12.h,
//                                 ),
//                                 hintText: 'أدخل البريد الإلكتروني',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'يرجى إدخال البريد الإلكتروني';
//                                 }
//                                 final emailRegex = RegExp(
//                                   r'^[^@]+@[^@]+\.[^@]+',
//                                 );
//                                 if (!emailRegex.hasMatch(value.trim())) {
//                                   return 'البريد الإلكتروني غير صالح';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

//                         // كلمة المرور - النص فوق الحقل
//                         Padding(
//                           padding: EdgeInsets.only(right: 20.w),
//                           child: Text(
//                             'كلمة المرور',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: Color(0xFF8F8D7D),
//                               height: 2.2,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),

//                         SizedBox(height: 6.h),

//                         // حقل كلمة المرور
//                         Center(
//                           child: Container(
//                             width: 300.w,
//                             height: 47.13.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(
//                                 color: Color(0xFF8F8D7D),
//                                 width: 1,
//                               ),
//                               color: Colors.white,
//                             ),
//                             child: TextFormField(
//                               controller: passwordController,
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 12.w,
//                                   vertical: 12.h,
//                                 ),
//                                 hintText: 'أدخل كلمة المرور',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'يرجى إدخال كلمة المرور';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

                       
//                         SizedBox(height: 32.h),

//                         // جملة الأسفل مع نص ملونين
//                         Center(
//                           child: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'إدخال الرمز الخاص ',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: Color(0xFF4D4D4D),
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: 'إدخال الرمز الخاص',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: Color(0xFFED4141),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

//                         // زر إنشاء حساب
//                         Center(
//                           child: SizedBox(
//                             width: 312.w,
//                             height: 54.h,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFF088395),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.r),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   final user = UserRegisterModel(
//                                     username: nameController.text.trim(),
//                                     email: emailController.text.trim(),
//                                     password: passwordController.text.trim(),
//                                   );

//                                   context.read<AuthBloc>().add(
//                                     RegisterRequested(user),
//                                   );
//                                 }
//                               },
//                               child: Text(
//                                 'إنشاء حساب',
//                                 style: TextStyle(
//                                   fontSize: 20.sp,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 40.h),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:test_app/blocs/auth/auth_bloc.dart';
// import 'package:test_app/blocs/auth/auth_event.dart';
// import 'package:test_app/blocs/auth/auth_state.dart';
// import 'package:test_app/models/user_register_model.dart';
// import 'package:test_app/views/login/login_screen.dart';

// class RegisterPageSimple extends StatefulWidget {
//   const RegisterPageSimple({super.key});

//   @override
//   _RegisterPageSimpleState createState() => _RegisterPageSimpleState();
// }

// class _RegisterPageSimpleState extends State<RegisterPageSimple> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocConsumer<AuthBloc, AuthState>(
//          listener: (context, state) {
//   if (state is AuthRegistered) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
//     );
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginScreen()),
//     );
//   } else if (state is AuthError) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(state.message)),
//     );
//   }
// },

//           builder: (context, state) {
//             return Stack(
//               children: [
//                 // المربع الأبيض في الخلفية
//                 Positioned(
//                   top: 112.h,
//                   left: 20.w,
//                   child: Container(
//                     width: 350.w,
//                     height: 700.h,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 8.r,
//                           offset: Offset(0, 4.h),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // المحتوى فوق المربع
//                 SingleChildScrollView(
//                   padding: EdgeInsets.only(
//                     top: 152.h,
//                     left: 20.w,
//                     right: 20.w,
//                     bottom: 40.h,
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // العنوان
//                         Center(
//                           child: Text(
//                             'إنشاء حساب',
//                             style: TextStyle(
//                               fontSize: 20.sp,
//                               color: const Color(0xFF088395),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 56.h),

//                         // الاسم
//                         Padding(
//                           padding: EdgeInsets.only(right: 20.w),
//                           child: Text(
//                             'الاسم',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: const Color(0xFF8F8D7D),
//                               height: 2.2,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                         SizedBox(height: 6.h),
//                         Center(
//                           child: Container(
//                             width: 300.w,
//                             height: 47.13.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(
//                                 color: const Color(0xFF8F8D7D),
//                                 width: 1,
//                               ),
//                             ),
//                             child: TextFormField(
//                               controller: nameController,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 12.w,
//                                   vertical: 12.h,
//                                 ),
//                                 hintText: 'أدخل الاسم',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'يرجى إدخال الاسم';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

//                         // البريد الإلكتروني
//                         Padding(
//                           padding: EdgeInsets.only(right: 20.w),
//                           child: Text(
//                             'البريد الإلكتروني',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: const Color(0xFF8F8D7D),
//                               height: 2.2,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                         SizedBox(height: 6.h),
//                         Center(
//                           child: Container(
//                             width: 300.w,
//                             height: 47.13.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(
//                                 color: const Color(0xFF8F8D7D),
//                                 width: 1,
//                               ),
//                             ),
//                             child: TextFormField(
//                               controller: emailController,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 12.w,
//                                   vertical: 12.h,
//                                 ),
//                                 hintText: 'أدخل البريد الإلكتروني',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'يرجى إدخال البريد الإلكتروني';
//                                 }
//                                 final emailRegex =
//                                     RegExp(r'^[^@]+@[^@]+\.[^@]+');
//                                 if (!emailRegex.hasMatch(value.trim())) {
//                                   return 'البريد الإلكتروني غير صالح';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

//                         // كلمة المرور
//                         Padding(
//                           padding: EdgeInsets.only(right: 20.w),
//                           child: Text(
//                             'كلمة المرور',
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               color: const Color(0xFF8F8D7D),
//                               height: 2.2,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                         SizedBox(height: 6.h),
//                         Center(
//                           child: Container(
//                             width: 300.w,
//                             height: 47.13.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.r),
//                               border: Border.all(
//                                 color: const Color(0xFF8F8D7D),
//                                 width: 1,
//                               ),
//                             ),
//                             child: TextFormField(
//                               controller: passwordController,
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 12.w,
//                                   vertical: 12.h,
//                                 ),
//                                 hintText: 'أدخل كلمة المرور',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'يرجى إدخال كلمة المرور';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 32.h),

//                         // جملة في الأسفل
//                         Center(
//                           child: RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'إدخال الرمز الخاص ',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: const Color(0xFF4D4D4D),
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: 'إدخال الرمز الخاص',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: const Color(0xFFED4141),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 24.h),

//                         // زر إنشاء حساب
//                         Center(
//                           child: SizedBox(
//                             width: 312.w,
//                             height: 54.h,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF088395),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.r),
//                                 ),
//                               ),
//                               onPressed: state is AuthLoading
//                                   ? null
//                                   : () {
//                                       if (_formKey.currentState!.validate()) {
//                                         final user = UserRegisterModel(
//                                           username:
//                                               nameController.text.trim(),
//                                           email:
//                                               emailController.text.trim(),
//                                           password:
//                                               passwordController.text.trim(),
//                                         );

//                                         context
//                                             .read<AuthBloc>()
//                                             .add(RegisterRequested(user));
//                                       }
//                                     },
//                               child: state is AuthLoading
//                                   ? const CircularProgressIndicator(
//                                       color: Colors.white,
//                                     )
//                                   : Text(
//                                       'إنشاء حساب',
//                                       style: TextStyle(
//                                         fontSize: 20.sp,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 40.h),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/blocs/auth/auth_bloc.dart';
import 'package:test_app/blocs/auth/auth_event.dart';
import 'package:test_app/blocs/auth/auth_state.dart';
import 'package:test_app/models/user_register_model.dart';
import 'package:test_app/views/login/login_screen.dart';

class RegisterPageSimple extends StatefulWidget {
  const RegisterPageSimple({super.key});

  @override
  _RegisterPageSimpleState createState() => _RegisterPageSimpleState();
}

class _RegisterPageSimpleState extends State<RegisterPageSimple> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegistered) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // المربع الأبيض الخلفي
                Positioned(
                  top: 112.h,
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

                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 152.h,
                    left: 20.w,
                    right: 20.w,
                    bottom: 40.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // العنوان
                        Center(
                          child: Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xFF088395),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 56.h),

                        // الاسم
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الاسم',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF8F8D7D),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Center(
                          child: Container(
                            width: 300.w,
                            height: 47.13.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: const Color(0xFF8F8D7D),
                                width: 1,
                              ),
                            ),
                            child: TextFormField(
                              controller: nameController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                hintText: 'أدخل الاسم',
                                hintTextDirection: TextDirection.rtl,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'يرجى إدخال الاسم';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // البريد الإلكتروني
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'البريد الإلكتروني',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF8F8D7D),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Center(
                          child: Container(
                            width: 300.w,
                            height: 47.13.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: const Color(0xFF8F8D7D),
                                width: 1,
                              ),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                hintText: 'أدخل البريد الإلكتروني',
                                hintTextDirection: TextDirection.rtl,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'يرجى إدخال البريد الإلكتروني';
                                }
                                final emailRegex =
                                    RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return 'البريد الإلكتروني غير صالح';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // كلمة المرور
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'كلمة المرور',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFF8F8D7D),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Center(
                          child: Container(
                            width: 300.w,
                            height: 47.13.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: const Color(0xFF8F8D7D),
                                width: 1,
                              ),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              textAlign: TextAlign.right,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                hintText: 'أدخل كلمة المرور',
                                hintTextDirection: TextDirection.rtl,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'يرجى إدخال كلمة المرور';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // جملة أسفل الحقول
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'منتسب لمعهد ما؟',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xFF4D4D4D),
                              ),
                            ),
                            Text(
                              'إدخال الرمز الخاص',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xFFED4141),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // زر إنشاء الحساب
                        Center(
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
                              onPressed: state is AuthLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        final user = UserRegisterModel(
                                          username: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        );
                                        context
                                            .read<AuthBloc>()
                                            .add(RegisterRequested(user));
                                      }
                                    },
                              child: state is AuthLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'إنشاء حساب',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
