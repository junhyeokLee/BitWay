
import '../../data/coin/res/PremiumItem.dart';

class PremiumState {
  final bool isLoading;
  final String? error;
  final List<PremiumItem> items;
  final String domestic;
  final String overseas;
  final String sortBy;

  const PremiumState({
    this.isLoading = false,
    this.error,
    this.items = const [],
    this.domestic = 'upbit',
    this.overseas = 'binance',
    this.sortBy = 'price_desc',
  });

  PremiumState copyWith({
    bool? isLoading,
    String? error,
    List<PremiumItem>? items,
    String? domestic,
    String? overseas,
    String? sortBy,
  }) {
    return PremiumState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      items: items ?? this.items,
      domestic: domestic ?? this.domestic,
      overseas: overseas ?? this.overseas,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}