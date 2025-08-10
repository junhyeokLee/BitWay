import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/repository/coin/PremiumRepository.dart';
import '../../../data/coin/res/PremiumItem.dart';
import '../../state/PremiumState.dart';

class PremiumViewModel extends StateNotifier<PremiumState> {
  PremiumViewModel(this._repo) : super(const PremiumState());
  final PremiumRepository _repo;

  Future<void> load({String? domestic, String? overseas, String? sortBy}) async {
    final next = state.copyWith(
      isLoading: true,
      error: null,
      domestic: domestic ?? state.domestic,
      overseas: overseas ?? state.overseas,
      sortBy: sortBy ?? state.sortBy,
    );
    state = next;
    try {
      final list = await _repo.getPremiums(
        domestic: next.domestic,
        overseas: next.overseas,
        sortBy: next.sortBy,
      );
      state = state.copyWith(isLoading: false, items: list, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // 즐겨찾기 토글 (클라이언트 로컬)
  void toggleFavorite(String symbol) {
    final updated = state.items.map((e) {
      if (e.symbol == symbol) {
        return PremiumItem(
          symbol: e.symbol,
          symbolName: e.symbolName,
          domesticExchange: e.domesticExchange,
          domesticPrice: e.domesticPrice,
          overseasExchange: e.overseasExchange,
          overseasPrice: e.overseasPrice,
          exchangeRate: e.exchangeRate,
          premiumRate: e.premiumRate,
          overseasPriceInKrw: e.overseasPriceInKrw,
          priceGap: e.priceGap,
          priceChangePercent24h: e.priceChangePercent24h,
          volume24h: e.volume24h,
          volatilityIndex: e.volatilityIndex,
          imageUrl: e.imageUrl,
          sortPriority: e.sortPriority,
          favorite: !e.favorite,
        );
      }
      return e;
    }).toList();
    state = state.copyWith(items: updated);
  }
}