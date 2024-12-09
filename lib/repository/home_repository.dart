import 'package:depd_mvvm/data/network/network_api_services.dart';
import 'package:depd_mvvm/model/city.dart';
import 'package:depd_mvvm/model/model.dart';
import 'package:depd_mvvm/model/costs/costs.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/province');
      List<Province> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> fetchCityList(var provId) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/city');
      List<City> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      }

      List<City> selectedCities = [];
      for (var c in result) {
        if (c.provinceId == provId) {
          selectedCities.add(c);
        }
      }

      return selectedCities;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Costs>> fetchShippingCosts({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
  }) async {
    try {
      dynamic response = await _apiServices.postApiResponse('/starter/cost', {
        'origin': origin,
        'destination': destination,
        'weight': weight.toString(),
        'courier': courier,
      });

      List<Costs> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'][0]['costs'] as List)
            .map((e) => Costs.fromJson(e))
            .toList();
      }

      return result;
    } catch (e) {
      throw e;
    }
  }
}