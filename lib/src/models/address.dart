import 'dart:convert';

import 'city.dart';
import 'phone.dart';

class Address {
  final String street;
  final int number;
  final String zipcode;
  final City city;
  final Phone phone;

  Address({
    required this.street,
    required this.number,
    required this.zipcode,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'city': city.toMap(),
      'phone': phone.toMap(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      number: map['number'] ?? 0,
      zipcode: map['zipcode'] ?? '',
      city: City.fromMap(map['city'] ?? <String, dynamic>{}),
      phone: Phone.fromMap(map['phone'] ?? <String, dynamic>{}),
    );
  }

  factory Address.fromJson(String json) => Address.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'Address{street: $street, number: $number, zipcode: $zipcode, city: $city, phone: $phone}';
  }
}
