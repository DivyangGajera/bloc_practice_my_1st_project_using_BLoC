// ignore_for_file: must_be_immutable

import 'package:bloc_practice/Cart/bloc/cart_bloc.dart';
import 'package:bloc_practice/Cart/model/products_model.dart';
import 'package:bloc_practice/data/assets.dart';
import 'package:flutter/material.dart';

class Cart_tile_widget extends StatelessWidget {
  final CartBloc cartBloc;
  IconData fav_icon;
  Cart_tile_widget(
      {super.key,
      required this.cartBloc,
      required this.tileData,
      this.fav_icon = Icons.favorite_border});
  CartProducts tileData;

  @override
  Widget build(BuildContext context) {
    favoritesList.forEach(
      (element) {
        if (element.name == tileData.name) {
          fav_icon = Icons.favorite;
        }
      },
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(tileData.image_url, loadingBuilder:
                  (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Name : ${tileData.name}",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "\n Price : ${tileData.price} \$\n Exp. Date : ${tileData.expiry_date}\n Quantity : ${tileData.quantity}"),
                Text(
                  tileData.quantity.toString() + " Items  ",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
