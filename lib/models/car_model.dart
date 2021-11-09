// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  Car({
    required this.brand,
    required this.sort,
  });

  String brand;
  List<Sort> sort;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        brand: json["brand"],
        sort: List<Sort>.from(json["sort"].map((x) => Sort.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "sort": List<dynamic>.from(sort.map((x) => x.toJson())),
      };
}

class Sort {
  Sort({
    required this.serias,
    required this.year,
    required this.price,
  });

  String serias;
  int year;
  double price;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        serias: json["serias"],
        year: json["year"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "serias": serias,
        "year": year,
        "price": price,
      };
}
