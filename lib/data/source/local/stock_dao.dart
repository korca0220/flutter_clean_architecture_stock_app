import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_app/data/source/local/company_listing_entity.dart';

class StockDao {
  final box = Hive.box('stock.db');

  static const companyListing = 'companyListing';

  // 추가
  Future<void> insertCompanyListings(
      List<CompanyListingEntity> companyListingEntity) async {
    await box.put(companyListing, companyListingEntity);
  }

  // 클리어(캐시)
  Future<void> clearCompanyListings() async {
    await box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListings(String query) async {
    final List<CompanyListingEntity> companyListings =
        await box.get(companyListing, defaultValue: []);
    return companyListings
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == element.symbol)
        .toList();
  }
}
