import 'package:stock_app/data/csv/company_listings_parse.dart';
import 'package:stock_app/data/mapper/company_mapper.dart';
import 'package:stock_app/data/source/local/stock_dao.dart';
import 'package:stock_app/data/source/remote/stock_api.dart';
import 'package:stock_app/domain/model/company_info.dart';
import 'package:stock_app/domain/model/company_listing.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/util/result.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final _parser = CompanyListingsParser();
  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query) async {
    // Cache
    final localListings = await _dao.searchCompanyListings(query);

    // 빈 검색
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    if (shouldJustLoadFromCache) {
      return Result.success(
        localListings.map((e) => e.toCompanyListing()).toList(),
      );
    } else {
      try {
        final response = await _api.getListings();
        final remoteListings = await _parser.parse(response.body);

        // Cache clear
        await _dao.clearCompanyListings();

        // Add Cache
        await _dao.insertCompanyListings(
            remoteListings.map((e) => e.toCompanyListingEntity()).toList());

        return Result.success(remoteListings);
      } catch (e) {
        return Result.error(Exception('데이터 로드 실패!!'));
      }
    }
  }

  @override
  Future<Result<CompanyInfo>> getCompanyInfo(String symbol) async {
    try {
      final dto = await _api.getCompanyInfo(symbol: symbol);
      return Result.success(dto.toCompanyInfo());
    } catch (e) {
      return Result.error(Exception('회사 정보 로드 실패!!'));
    }
  }
}
