import 'package:b2w/services/uno_service.dart';

import '../models/banner.dart';

class BannerService {
  final UnoService unoService;

  const BannerService(this.unoService);

  Future<List<BannerModel>> findAll() async {
    final response = await unoService.get('/banner');
    final banners = response['data'] as List;
    return banners.map((b) => BannerModel.fromMap(b)).toList();
  }
}
