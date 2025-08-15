import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:alhekma/views/login/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleForward;
  late Animation<double> _scaleBackward;
  late Animation<Offset> _moveLeft;
  late Animation<double> _fadeText;
  late Animation<Color?> _bgColor;

  bool _showText = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    _scaleForward = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );

    _scaleBackward = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5, curve: Curves.easeIn),
      ),
    );

    _moveLeft =
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.0, 0), 
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
          ),
        );

    _fadeText = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.625, 0.875, curve: Curves.easeIn),
      ),
    );

    _bgColor =
        ColorTween(
          begin: const Color(0xFF004D59),
          end: const Color(0xFF73E6D7),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.75, 1.0, curve: Curves.easeInOut),
          ),
        );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showText = true;
      });
    });

    Future.delayed(const Duration(seconds: 6), () {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => SignUpScreen()),
  );
});

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get scale {
    if (_controller.value <= 0.25) {
      return _scaleForward.value;
    } else if (_controller.value <= 0.5) {
      return _scaleBackward.value;
    }
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Scaffold(
          backgroundColor: _bgColor.value ?? const Color(0xFF004D59),
          body: Center(
            child: SlideTransition(
              position: _moveLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: scale,
                    child: Image.asset(
                      'assets/images/lamp.png',
                      width: 60,
                      height: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  AnimatedOpacity(
                    opacity: _fadeText.value,
                    duration: const Duration(milliseconds: 500),
                    child: _showText
                        ? DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'الحكمة',
                                  speed: const Duration(milliseconds: 200),
                                  cursor: '',
                                ),
                              ],
                              totalRepeatCount: 1,
                              pause: Duration.zero,
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
