import 'package:flutter/cupertino.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/DioProvider.dart';
import '../../core/repository/coin/PremiumRepository.dart';
import '../../core/service/coin/PremiumService.dart';
import '../viewmodel/coin/PremiumViewModel.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// UI 전역 설정 상태
class AppConfig {
  final bool compact;
  const AppConfig({this.compact = false});

  AppConfig copyWith({bool? compact}) =>
      AppConfig(compact: compact ?? this.compact);
}

/// 설정 변경 Notifier
class AppConfigNotifier extends Notifier<AppConfig> {
  @override
  AppConfig build() => const AppConfig();

  void toggleCompact() {
    state = state.copyWith(compact: !state.compact);
  }
}

/// 프리미엄 리스트에서 사용 중인 프로바이더
final appConfigProvider =
NotifierProvider<AppConfigNotifier, AppConfig>(AppConfigNotifier.new);

// Riverpod: DI & 상태
final premiumApiServiceProvider = Provider<PremiumService>((ref) {
  final dio = ref.watch(dioProvider);
  return PremiumService(dio);
});

final premiumRepositoryProvider = Provider<PremiumRepository>((ref) {
  final api = ref.watch(premiumApiServiceProvider);
  return PremiumRepository(api);
});

final premiumViewModelProvider =
StateNotifierProvider<PremiumViewModel, dynamic>((ref) {
  final repo = ref.watch(premiumRepositoryProvider);
  return PremiumViewModel(repo);
});
