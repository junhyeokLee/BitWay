import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPageRoute<T> extends CupertinoPageRoute<T> {
  final Widget page;
  final bool isBottomNavVisible; // 바텀 네비게이션의 가시성 여부
  final VoidCallback onPageTransition; // 페이지 전환 시 실행할 콜백
  final VoidCallback onPopCallback; // 페이지가 pop될 때 실행할 콜백

  // CustomPageRoute({
  //   required this.page,
  //   this.isBottomNavVisible = true,
  //   required this.onPageTransition,
  //   required this.onPopCallback,
  // }) : super(
  //   builder: (context) => page,
  //   fullscreenDialog: false, // ✅ 전체화면으로 렌더링 강제
  // );
  CustomPageRoute({
    required this.page,
    this.isBottomNavVisible = true,
    required this.onPageTransition,
    required this.onPopCallback,
  }) : super(
    builder: (context) => Material(
      type: MaterialType.canvas,
      child: page,
    ),
    fullscreenDialog: false,
  );

  @override
  void dispose() {
    // 페이지가 pop될 때 콜백 실행
    onPopCallback();
    super.dispose();
  }

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    // 애니메이션 상태 리스너
    animation.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        // 페이지 전환 시작 시 네비게이션 바 숨기기
        if (isBottomNavVisible) {
          onPageTransition();
        }
      } else if (status == AnimationStatus.reverse) {
        // 페이지가 pop될 때 네비게이션 바 보이기
        if (isBottomNavVisible) {
          onPopCallback();
        }
      }
    });

    // 기본 CupertinoPageRoute의 전환 애니메이션 사용
    return super.buildTransitions(context, animation, secondaryAnimation, child);
  }

  // 페이지 전환을 위한 정적 메서드
  static Future<T?> push<T>(BuildContext context, Widget page, {
    bool isBottomNavVisible = true,
    required VoidCallback onPageTransition,
    required VoidCallback onPopCallback,
  }) {
    return Navigator.of(context).push<T>(
      CustomPageRoute<T>(
        page: page,
        isBottomNavVisible: isBottomNavVisible,
        onPageTransition: onPageTransition,
        onPopCallback: onPopCallback,
      ),
    );
  }

  // CustomPageRoute 내부에 뒤로가기를 제어하는 메서드를 추가
  static Future<T?> pushAndRemoveUntil<T>(
      BuildContext context,
      Widget page, {
        bool isBottomNavVisible = true,
        required VoidCallback onPageTransition,
        required VoidCallback onPopCallback,
        int removePages = 1, // 제거할 페이지 수를 설정 (기본 1단계)
      }) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      CustomPageRoute<T>(
        page: page,
        isBottomNavVisible: isBottomNavVisible,
        onPageTransition: onPageTransition,
        onPopCallback: onPopCallback,
      ),
          (Route<dynamic> route) {
        // 남길 페이지 조건
        return route.isFirst || --removePages <= 0;
      },
    );
  }

  // 페이지를 pop하면서 BottomNavigation 애니메이션과 인덱스 이동하기 위한 메서드
  static void popTransitionAndNavigate<T>(
      BuildContext context, {
        bool isBottomNavVisible = true,
        T? result,
        required VoidCallback onPopCallback,
        required String routeName, // 이동할 route path
        Map<String, dynamic>? arguments, // arguments 추가
      }) {
    if (isBottomNavVisible) {
      onPopCallback(); // 네비게이션 바 설정
    }
    Navigator.of(context).pop(result); // 현재 페이지 pop
    // context.go(routeName); // context.go로 지정된 경로로 이동
    // context.go로 이동 시 arguments 전달
    context.go(routeName, extra: arguments);
  }
}