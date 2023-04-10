import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_app/domain/repository/stock_repository.dart';
import 'package:stock_app/presentation/company_listings/company_listings_event.dart';
import 'package:stock_app/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;
  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  Timer? _debounce;

  var _state = CompanyListingsState();
  CompanyListingsState get state => _state;

  onEvent(CompanyListingsEvent event) {
    event.when(
      refresh: () => _getCompanyListings(fetchFromRemote: true),
      search: (query) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          _getCompanyListings(query: query);
        });
      },
    );
  }

  Future<void> _getCompanyListings(
      {bool fetchFromRemote = false, String query = ''}) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _repository.getCompanyListings(
      fetchFromRemote,
      query,
    );
    result.when(
      success: (listings) {
        _state = state.copyWith(companies: listings);
      },
      error: (e) {
        // TODO : Error 처리
        print(e.toString());
      },
    );
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
