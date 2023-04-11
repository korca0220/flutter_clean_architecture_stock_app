import 'package:freezed_annotation/freezed_annotation.dart';

part 'intraday_info.freezed.dart';
part 'intraday_info.g.dart';

@freezed
class IntradayInfo with _$IntradayInfo {
  factory IntradayInfo({
    required DateTime data,
    required double close,
  }) = _IntradayInfo;

  factory IntradayInfo.fromJson(Map<String, dynamic> json) =>
      _$IntradayInfoFromJson(json);
}
