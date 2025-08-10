import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/coin/req/FavoriteCoinReq.dart';
import '../../../data/coin/res/CoinItem.dart';
import '../../../data/coin/res/FavoriteCoinRes.dart';
import '../../../data/coin/res/PremiumItem.dart';

class CoinRepository {

  final Dio _dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  CoinRepository(this._dio);

  Future<List<PremiumItem>> fetchPremiumList({
    required String domestic, // e.g. 'upbit'
    required String overseas, // e.g. 'binance'
    required PremiumSort sortBy,
  }) async {
    final res = await _dio.get(
      '/api/premium',
      queryParameters: {
        'domestic': domestic,
        'overseas': overseas,
        'sortBy': sortBy.query,
      },
    );
    final data = res.data as List<dynamic>;
    return data.map((e) => PremiumItem.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<List<CoinItem>> fetchCoinList() async {
    try {
      final response = await _dio.get('/api/coin/list');
      return (response.data as List)
          .map((e) => CoinItem.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('코인 리스트 조회 실패: $e');
    }
  }

  Future<List<FavoriteCoinRes>> saveFavoriteCoins(FavoriteCoinReq request) async {
    try {
      final response = await _dio.post('/api/users/favorites', data: request.toJson());
      return (response.data as List)
          .map((e) => FavoriteCoinRes.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('즐겨찾기 저장 실패: $e');
    }
  }

  Future<List<FavoriteCoinRes>> getFavoriteCoins(String email) async {
    try {
      final response = await _dio.get('/api/users/favorites', queryParameters: {'email': email});
      return (response.data as List)
          .map((e) => FavoriteCoinRes.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('즐겨찾기 조회 실패: $e');
    }
  }
}
