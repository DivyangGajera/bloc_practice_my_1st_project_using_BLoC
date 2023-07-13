// ignore_for_file: must_be_immutable

import 'package:bloc_practice/Home/bloc/home_bloc.dart';
import 'package:bloc_practice/Home/models/products_model.dart';
import 'package:bloc_practice/data/assets.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final HomeBloc homeBloc;
  IconData fav_icon;
  ProductTile(
      {super.key,
      required this.homeBloc,
      required this.tileData,
      this.fav_icon = Icons.favorite_border});
  Products tileData;


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
                    "\n Price : ${tileData.price} \$\n Exp. Date : ${tileData.expiry_date}"),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        homeBloc
                            .add(AddToFavoritesEvent(clickedProduct: tileData));
                      },
                      icon: Icon(
                        fav_icon,
                        color: Colors.pink,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        homeBloc.add(AddToCartEvent(clickedProduct: tileData));
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
