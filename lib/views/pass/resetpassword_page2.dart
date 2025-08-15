import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alhekma/views/pass/resetpassword_page3.dart';

class ResetPassword2Page extends StatefulWidget {
  final String? email; 

  const ResetPassword2Page({super.key, this.email});

  @override
  State<ResetPassword2Page> createState() => _ResetPassword2PageState();
}

class _ResetPassword2PageState extends State<ResetPassword2Page> {
  final List<TextEditingController> _codeControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var ctrl in _codeControllers) {
      ctrl.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
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
              top: 248.h,
              left: 116.w,
              child: SizedBox(
                width: 229.w,
                height: 35.h,
                child: Text(
                  'أدخل رمز التحقق الذي تم إرساله',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xFF7D7C73),
                    fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Positioned(
              top: 317.h,
              left: 275.w,
              child: SizedBox(
                width: 66.w,
                height: 28.h,
                child: Text(
                  'رمز التحقق',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF8F8D7D),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 361.h,
              left: 45.w,
              child: SizedBox(
                width: 300.w,
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 42.86.w,
                      height: 50.h,
                      child: TextField(
                        controller: _codeControllers[index],
                        focusNode: _focusNodes[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: BorderSide(color: const Color(0xFF8F8D7D)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            borderSide: BorderSide(color: const Color(0xFF088395)),
                          ),
                          hintText: '•',
                          hintStyle: TextStyle(
                            fontSize: 30.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        onChanged: (value) => _onCodeChanged(value, index),
                      ),
                    );
                  }),
                ),
              ),
            ),

            Positioned(
              top: 481.h,
              left: 93.w,
              child: SizedBox(
                width: 204.w,
                height: 28.h,
                child: Row(
                  children: [
                     Text(
                        'إرسال مرة أخرى',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFFED4141),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    
                    
                    GestureDetector(
                      onTap: () {
                      },
                      child:Text(
                      'لم يصلك الرمز؟ ',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                    ),
                  ],
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResetPassword3Page(), 
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'تحقق',
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


