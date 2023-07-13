import 'package:bloc_practice/Favorites/bloc/favorites_bloc.dart';
import 'package:bloc_practice/Home/models/products_model.dart';
import 'package:flutter/material.dart';

class Favorites_tile_widget extends StatelessWidget {
  final Products data;
  final FavoritesBloc fav_bloc;
  const Favorites_tile_widget(
      {super.key, required this.data, required this.fav_bloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(data.image_url, loadingBuilder:
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
              "Name : ${data.name}",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "\n Price : ${data.price} \$ \n Exp. Date : ${data.expiry_date}"),
                IconButton(
                    onPressed: () {
                      fav_bloc.add(RemoveFromFavoritesListEvent(
                          productToBeRemoved: data));
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
