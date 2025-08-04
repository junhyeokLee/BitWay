import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitway/routing/NavigationHistoryManager.dart';
import 'package:bitway/util/color.dart';

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({super.key, required this.navigationShell,});

  final StatefulNavigationShell navigationShell;

  @override
  _ScaffoldWithNestedNavigationState createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState extends State<ScaffoldWithNestedNavigation> with WidgetsBindingObserver {
  final NavigationHistoryManager _historyManager = NavigationHistoryManager();
  bool _isExitWarningShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // 바로 push 실행
    _historyManager.push(widget.navigationShell.currentIndex);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _goBranch(int index) {
    final currentIndex = widget.navigationShell.currentIndex;

    if (currentIndex != index) {
      // 이전 인덱스를 히스토리에 추가
      _historyManager.push(currentIndex);
      // 실제로 브랜치를 이동
      setState(() {
        widget.navigationShell.goBranch(index);
      });
    } else {
      debugPrint("⚠️ Already on index: $index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 시스템 뒤로가기를 막음
      onPopInvokedWithResult: (didPop, result) async {
        await Future.delayed(Duration.zero); // 렌더링 타이밍 이슈 방지

        // GoRouter 스택이 비어있는지 확인
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
          return;
        }

        // 히스토리 스택 확인
        if (_historyManager.canGoBack()) {
          final previousIndex = _historyManager.pop();

          if (previousIndex != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                widget.navigationShell.goBranch(previousIndex);
              });
            });
          }
        } else {

          if (!_isExitWarningShown) {
            _isExitWarningShown = true;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('\'뒤로\' 버튼을 한번 더 누르면 종료됩니다.')),
            );

            Future.delayed(const Duration(seconds: 2), () {
              _isExitWarningShown = false;
            });
          } else {
            SystemNavigator.pop(); // 앱 종료
          }
        }
      },
      child: ScaffoldWithNavigationBar(
        body: widget.navigationShell,
        currentIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (index) {
          if (index == widget.navigationShell.currentIndex) {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            }
          } else {
            _goBranch(index);
          }
        },
      ),
    );
  }
}

class ScaffoldWithNavigationBar extends ConsumerWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(child: body), // ✅ 메인 컨텐츠 영역\\
          // 광고 배너
          // setAdBannerBottom(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: InkRipple.splashFactory,
          splashColor: Colors.white.withOpacity(0.2),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onDestinationSelected,
          backgroundColor: AppColors.background,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          selectedLabelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded, size: 24.w),
              label: '정보',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_rounded, size: 24.w),
              label: '뉴스',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_rounded, size: 24.w),
              label: '마켓',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_rounded, size: 24.w),
              label: '알림',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded, size: 24.w),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
}
