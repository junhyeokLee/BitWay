import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bitway/routing/scaffold_with_nested_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../presentation/screen/main/home_screen2.dart';

enum AppRoute { information, news, market, alarm, setting }

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _informaionNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'information');
final _newsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'news');
final _marketNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'market');
final _alarmNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'alarm');
final _settingNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'setting');

extension GoRouterStateX on GoRouterState {
  int get initialTabIndex {
    if (extra is Map<String, dynamic> &&
        (extra as Map<String, dynamic>).containsKey('initialTabIndex')) {
      return (extra as Map<String, dynamic>)['initialTabIndex'] ?? 0;
    }
    return 0;
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/information',
    // navigatorKey: _rootNavigatorKey,
    navigatorKey: globalNavigatorKey, // global key 사용
    debugLogDiagnostics: true,
    routes: [
      // GoRoute(
      //   path: '/entry', // 푸시 알림 클릭 시 진입하는 경로
      //   name: 'entry',
      //   builder: (context, state) => MainEntryScreen(),
      // ),
      // GoRoute(
      //     path: '/lineup', // 푸시 알림 클릭 시 진입하는 경로
      //     name: 'lineup',
      //     builder: (context, state) {
      //       final gameId = state.uri.queryParameters['gameId'] ?? '';
      //       final leagueId = int.tryParse(
      //           state.uri.queryParameters['leagueId'] ?? '') ?? 1;
      //       final seriesId = int.tryParse(
      //           state.uri.queryParameters['seriesId'] ?? '') ?? 0;
      //       final seasonId = int.tryParse(
      //           state.uri.queryParameters['seasonId'] ?? '') ?? 2025;
      //
      //       return GamePreviewScreen(gameId: gameId,
      //           leagueId: leagueId,
      //           seriesId: seriesId,
      //           seasonId: seasonId);
      //     },
      // ),
      // GoRoute( // record로 올때는 해당 라이브에 경기기록 페이지로
      //   path: '/live',
      //   name: 'live',
      //   builder: (context, state) {
      //     final gameId = state.uri.queryParameters['gameId'] ?? '';
      //     final leagueId = int.tryParse(
      //         state.uri.queryParameters['leagueId'] ?? '') ?? 1;
      //     final seriesId = int.tryParse(
      //         state.uri.queryParameters['seriesId'] ?? '') ?? 0;
      //     final seasonId = int.tryParse(
      //         state.uri.queryParameters['seasonId'] ?? '') ?? 2025;
      //     return GameLiveScreen(
      //       gameId: gameId,
      //       leagueId: leagueId,
      //       seriesId: seriesId,
      //       seasonId: seasonId,
      //     );
      //   },
      // ),
      // GoRoute( // record로 올때는 해당 라이브에 경기기록 페이지로
      //   path: '/record',
      //   name: 'record',
      //   builder: (context, state) {
      //     final gameId = state.uri.queryParameters['gameId'] ?? '';
      //     final leagueId = int.tryParse(
      //         state.uri.queryParameters['leagueId'] ?? '') ?? 1;
      //     final seriesId = int.tryParse(
      //         state.uri.queryParameters['seriesId'] ?? '') ?? 0;
      //     final seasonId = int.tryParse(
      //         state.uri.queryParameters['seasonId'] ?? '') ?? 2025;
      //     return GameLiveScreen(
      //       gameId: gameId,
      //       leagueId: leagueId,
      //       seriesId: seriesId,
      //       seasonId: seasonId,
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: '/gameEnd',
      //   name: 'gameEnd',
      //   builder: (context, state) {
      //     final gameId = state.uri.queryParameters['gameId'] ?? '';
      //     final leagueId = int.tryParse(
      //         state.uri.queryParameters['leagueId'] ?? '') ?? 1;
      //     final seriesId = int.tryParse(
      //         state.uri.queryParameters['seriesId'] ?? '') ?? 0;
      //     final seasonId = int.tryParse(
      //         state.uri.queryParameters['seasonId'] ?? '') ?? 2025;
      //     return GameEndScreen(
      //       gameId: gameId,
      //       leagueId: leagueId,
      //       seriesId: seriesId,
      //       seasonId: seasonId,
      //     );
      //   },
      // ),

      // 바텀네비
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _informaionNavigatorKey,
            routes: [
              GoRoute(
                path: '/information',
                name: AppRoute.information.name,
                builder: (context, state) => const HomeScreen2(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _newsNavigatorKey,
            routes: [
              GoRoute(
                path: '/news',
                name: AppRoute.news.name,
                builder: (context, state) => const HomeScreen2(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _marketNavigatorKey,
            routes: [
              GoRoute(
                path: '/market',
                name: AppRoute.market.name,
                builder: (context, state) => const HomeScreen2(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _alarmNavigatorKey,
            routes: [
              GoRoute(
                path: '/alarm',
                name: AppRoute.alarm.name,
                builder: (context, state) => const HomeScreen2(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingNavigatorKey,
            routes: [
              GoRoute(
                path: '/setting',
                name: AppRoute.setting.name,
                builder: (context, state) => const HomeScreen2(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
