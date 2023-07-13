import '../Cart/model/products_model.dart';
import '../Home/models/products_model.dart';

List<Products> favoritesList = [];
List<CartProducts> cartList = [];


//URI variables for products, favorites, and cart APIs
    Uri productsUrl = Uri.parse(
        "https://fir-a-to-z-default-rtdb.firebaseio.com/Products.json");
    Uri favoritesUrl = Uri.parse(
        "https://fir-a-to-z-default-rtdb.firebaseio.com/Favorites.json");
    Uri cartUrl =
    Uri.parse("https://fir-a-to-z-default-rtdb.firebaseio.com/Cart.json");