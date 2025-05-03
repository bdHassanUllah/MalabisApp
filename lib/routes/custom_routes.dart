import 'package:flutter/material.dart';
import 'package:malabis_app/data/model/cart_model.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/views/invoice/invoicescreen.dart';
import 'package:malabis_app/views/account/accounts.dart';
import 'package:malabis_app/views/authentication/signup/welcome_screen.dart';
import 'package:malabis_app/views/cart/cart.dart';
import 'package:malabis_app/views/home/home_page.dart';
import 'package:malabis_app/views/order/order_history.dart';
import 'package:malabis_app/views/splash_screen.dart';
import 'package:malabis_app/views/sub_views/productfull_view.dart';
import 'package:malabis_app/views/summaryscreen/summary.dart';
import 'package:malabis_app/views/thanku/thankyou.dart';
import 'package:malabis_app/views/wishlist/wishlistscreen.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case "/": // Add default root route
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case welcomescreen:
        return MaterialPageRoute(builder: (_) =>  WelcomeScreen());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case detailscreen:
        final productMap = setting.arguments as Map<String, dynamic>;
        final product = Product.fromJson(productMap);
        return MaterialPageRoute(
          builder: (_) => ProductDetailPage(product: product.toJson()),
        );
      case cartscreen:
        return MaterialPageRoute(builder: (_) => CartScreen());

      case wishlistscreen:
        return MaterialPageRoute(builder: (_) => WishlistScreen());

      case invoicescreen:
        final cartItems = setting.arguments as List<CartModel>;
        return MaterialPageRoute(builder: (_) => InvoiceScreen(cartItems: cartItems));

      case summary:
        final cartItems = setting.arguments as List<CartModel>;
        return MaterialPageRoute(
          builder: (_) => SummaryScreen(cartItems: cartItems), // 👈 Pass to screen
        );

      case accounts:
        return MaterialPageRoute(builder: (_) => AccountsScreen());

      case orderscreen:
        return MaterialPageRoute(builder: (_) => OrderHistoryScreen());

      case thanku:
        return MaterialPageRoute(builder: (_) => ThankYouScreen());

      default:
        throw Exception('Route not found: ${setting.name}');
    }
  }
}
