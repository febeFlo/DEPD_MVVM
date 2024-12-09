import 'package:depd_mvvm/data/response/api_response.dart';
import 'package:depd_mvvm/model/city.dart';
import 'package:depd_mvvm/model/model.dart';
import 'package:depd_mvvm/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:depd_mvvm/model/costs/costs.dart';

class HomeViewmodel extends ChangeNotifier {
  final _homeRepo = HomeRepository();

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityList = ApiResponse.loading();
  setCityList(ApiResponse<List<City>> response) {
    cityList = response;
    notifyListeners();
  }

  Future<void> getCityList(var provId) async {
    setCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityList2 = ApiResponse.loading();
  setCityList2(ApiResponse<List<City>> response) {
    cityList2 = response;
    notifyListeners();
  }

  Future<void> getCityList2(var provId) async {
    setCityList2(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityList2(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityList2(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<Costs>> shippingCosts = ApiResponse.loading();
  void setShippingCosts(ApiResponse<List<Costs>> response) {
    shippingCosts = response;
    notifyListeners();
  }

  Future<void> getShippingCosts({required String origin, required String destination, required int weight, required String courier}) async {
    setShippingCosts(ApiResponse.loading());
    try {
      final data = await _homeRepo.fetchShippingCosts(origin: origin, destination: destination, weight: weight, courier: courier); // Replace with your actual API call method
      setShippingCosts(ApiResponse.completed(data));
    } catch (e) {
      setShippingCosts(ApiResponse.error(e.toString()));
    }
  }
}
