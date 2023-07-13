import 'dart:convert';

List<CartProducts> jsonToProducts({required String json}) =>
    jsonDecode(json).map((e) => CartProducts.fromJson(e)).toList();

class CartProducts {
  final String name;
  final int quantity;
  final String expiry_date;
  final double price;

  final String image_url;

  CartProducts(
      {required this.image_url,
      required this.name,
      required this.quantity,
      required this.expiry_date,
      required this.price});

  factory CartProducts.fromJson(Map jsonData) {
    return CartProducts(
        image_url: jsonData['image_url'] ?? "No Data",
        name: jsonData['name'] ?? "No Data",
        quantity: int.tryParse("${jsonData['quantity']}") ?? 0,
        expiry_date: jsonData['expiry_date'] ?? "No Data",
        price: double.tryParse("${jsonData['price']}") ?? 0.00);
  }

  static Map productsToJson(CartProducts products) {
    Map data = {
      "name": products.name,
      "expiry_date": products.expiry_date,
      "price": products.price,
      "quantity": products.quantity,
      "image_url": products.image_url
    };

    return data;
  }
}
