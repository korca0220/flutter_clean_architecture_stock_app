import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class CompanyListingEntity extends HiveObject {
  @HiveField(0)
  String symbol;

  @HiveField(1)
  String name;

  @HiveField(2)
  String exchange;
  CompanyListingEntity({
    required this.symbol,
    required this.name,
    required this.exchange,
  });
}
