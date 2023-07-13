import 'dart:convert';

List<Products> jsonToProducts({required String json}) =>
    jsonDecode(json).map((e) => Products.fromJson(e)).toList();

class Products {
  final String name;
  final String expiry_date;
  final double price;
  final String image_url;

  Products(
      {required this.image_url,
      required this.name,

      required this.expiry_date,
      required this.price});

  factory Products.fromJson(Map jsonData) {
    return Products(
        image_url: jsonData['image_url'] ?? "No Data",
        name: jsonData['name'] ?? "No Data",
        expiry_date: jsonData['expiry_date'] ?? "No Data",
        price: double.tryParse("${jsonData['price']}") ?? 0.00);
  }

  static Map productsToJson(Products products) {
    Map data = {
      "name": products.name,
      "expiry_date": products.expiry_date,
      "price": products.price,
      "image_url": products.image_url
    };

    return data;
  }
}
