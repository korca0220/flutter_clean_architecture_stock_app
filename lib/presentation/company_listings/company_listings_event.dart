import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listings_event.freezed.dart';

@freezed
class CompanyListingsEvent with _$CompanyListingsEvent {
  const factory CompanyListingsEvent.refresh() = Refresh;
  const factory CompanyListingsEvent.search(String query) = Search;
}
