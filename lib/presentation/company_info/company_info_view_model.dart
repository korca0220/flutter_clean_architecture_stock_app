import 'package:flutter/foundation.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_info/company_info_state.dart';

class CompanyInfoViewModel with ChangeNotifier {
  final StockRepository _repository;
  CompanyInfoViewModel(this._repository);

  var _state = CompanyInfoState();
  CompanyInfoState get state => _state;

  Future<void> loadCompanyInfo(String symbol) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getCompanyInfo(symbol);
    result.when(
      success: (info) {
        _state = state.copyWith(companyInfo: info);
      },
      error: (e) {
        _state = state.copyWith(companyInfo: null);
        print(e);
      },
    );
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
