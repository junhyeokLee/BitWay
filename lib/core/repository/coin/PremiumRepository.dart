import '../../../data/coin/res/PremiumItem.dart';
import '../../service/coin/PremiumService.dart';

class PremiumRepository {
  PremiumRepository(this._api);
  final PremiumService _api;

  Future<List<PremiumItem>> getPremiums({
    String domestic = 'upbit',
    String overseas = 'binance',
    String sortBy = 'price_desc',
  }) {
    return _api.fetchPremiumList(domestic: domestic, overseas: overseas, sortBy: sortBy);
  }
}