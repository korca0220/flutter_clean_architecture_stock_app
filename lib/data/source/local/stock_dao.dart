import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_app/data/source/local/company_listing_entity.dart';

class StockDao {
  static const companyListing = 'companyListing';

  // 추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntities) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.addAll(companyListingEntities);
  }

  // 클리어(캐시)
  Future<void> clearCompanyListings() async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListings(String query) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    final List<CompanyListingEntity> companyListings = box.values.toList();
    return companyListings
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == element.symbol)
        .toList();
  }
}
