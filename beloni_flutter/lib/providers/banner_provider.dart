import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/banner_model.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final bannersProvider = FutureProvider<List<BannerModel>>((ref) async {
  return ref.watch(apiServiceProvider).getBanners();
});
