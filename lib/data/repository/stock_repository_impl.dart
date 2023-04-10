import 'package:stock_app/data/mapper/company_mapper.dart';
import 'package:stock_app/data/source/local/stock_dao.dart';
import 'package:stock_app/data/source/remote/stock_api.dart';
import 'package:stock_app/domain/model/company_listing.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/util/result.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
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
        final remoteListings = await _api.getListings();
        // TODO : CSV 파싱 변환
        return Result.success([]);
      } catch (e) {
        return Result.error(Exception('데이터 로드 실패!!'));
      }
    }
  }
}
