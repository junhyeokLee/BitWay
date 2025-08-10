import 'package:dio/dio.dart';

import '../../../data/coin/res/PremiumItem.dart';

class PremiumService {
  PremiumService(this._dio);
  final Dio _dio;

  Future<List<PremiumItem>> fetchPremiumList({
    required String domestic,
    required String overseas,
    required String sortBy,
  }) async {
    final res = await _dio.get(
      '/api/premium',
      queryParameters: {
        'domestic': domestic,
        'overseas': overseas,
        'sortBy': sortBy,
      },
    );
    final data = res.data as List<dynamic>;
    return data.map((e) => PremiumItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}