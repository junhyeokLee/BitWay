import 'package:dio/dio.dart';

import '../../../core/network/DioClient.dart';
import '../../../data/coin/req/FavoriteCoinReq.dart';
import '../../../data/coin/res/CoinItem.dart';
import '../../../data/coin/res/FavoriteCoinRes.dart';

class CoinRepository {
  final Dio _dio = DioClient().dio;

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
