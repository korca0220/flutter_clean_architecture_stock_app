import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_app/data/source/remote/dto/company_info_dto.dart';

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co/';
  static const apiKey = '4OI4OL6G00AVMSGM';
  final http.Client _client;
  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getListings() async {
    return await _client.get(
        Uri.parse('$baseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  Future<CompanyInfoDto> getCompanyInfo({required String symbol}) async {
    final response = await _client.get(Uri.parse(
        '$baseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));
    return CompanyInfoDto.fromJson(jsonDecode(response.body));
  }
}
