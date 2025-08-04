import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../signup/SignUpScreen.dart';

class IntroPageViewScreen extends StatefulWidget {
  @override
  State<IntroPageViewScreen> createState() => _IntroPageViewScreenState();
}

class _IntroPageViewScreenState extends State<IntroPageViewScreen> with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  late AnimationController _buttonController;
  late Animation<Offset> _buttonOffset;

  final List<Map<String, String>> introPages = [
    {
      'title': '시세 & 김프 분석',
      'desc': '국내외 시세 비교, 김치프리미엄, 투자심리 지표를 한 눈에!',
      'animation': 'assets/lottie/crypto2_ani.json'
    },
    {
      'title': '뉴스 요약 + AI 분석',
      'desc': '업비트 공지, 코인 뉴스와 함께 AI 기반 요약도 제공!',
      'animation': 'assets/lottie/bit_ani.json'
    },
    {
      'title': '차트 패턴 & 커뮤니티',
      'desc': 'AI 차트 분석 + 예측 투표 커뮤니티 기능을 만나보세요!',
      'animation': 'assets/lottie/bench_ani.json'
    },
  ];

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _buttonOffset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: introPages.length,
                onPageChanged: (index) {
                  setState(() => _pageIndex = index);
                  if (index == introPages.length - 1) {
                    _buttonController.forward();
                  } else {
                    _buttonController.reverse();
                  }
                },
                itemBuilder: (context, index) {
                  final page = introPages[index];
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          page['animation']!,
                          width: 500,
                          height: 500,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page['title']!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['desc']!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SmoothPageIndicator(
                controller: _controller,
                count: introPages.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.blueAccent,
                  dotColor: Colors.grey.shade300,
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _buttonController,
              axis: Axis.vertical,
              axisAlignment: -1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: SlideTransition(
                  position: _buttonOffset,
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(child: CircularProgressIndicator()),
                      );

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isFirstRun', false);

                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpEmailScreen()),
                      );
                    },
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlueAccent],
                          ),
                        ),
                        child: const Text(
                          '시작하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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