import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/DioClient.dart';
import '../../../core/repository/auth/AuthRepository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(DioClient.instance.dio);
});