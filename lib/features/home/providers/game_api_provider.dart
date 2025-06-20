import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_catalog_app/services/api/dio_client.dart';
import 'package:game_catalog_app/features/home/data/game_api_service.dart';

final gameApiServiceProvider = Provider<GameApiService>((ref) {
  final dio = createDioClient();
  return GameApiService(dio);
});
