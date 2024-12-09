import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String cityId;
  final String? provinceId;
  final String? province;
  final String? type;
  final String? cityName;
  final String? postalCode;

  const City({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['city_id'],
      provinceId: json['province_id'],
      province: json['province'],
      type: json['type'],
      cityName: json['city_name'],
      postalCode: json['postal_code'],
    );
  }

  Map<String, dynamic> toJson() => {
        'city_id': cityId,
        'province_id': provinceId,
        'province': province,
        'type': type,
        'city_name': cityName,
        'postal_code': postalCode,
      };

  @override
  List<Object?> get props => [
    cityId,
    provinceId,
    province,
    type,
    cityName,
    postalCode,
  ];
}
