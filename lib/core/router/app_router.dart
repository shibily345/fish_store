import 'package:betta_store/core/exceptions/route_exception.dart';
import 'package:betta_store/features/skeleton/skeleton.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const initial = '/';
  static const splash = '/splash';
  static const fishDetails = '/fish-details';

  static const cartPage = '/cart-page';
  static const signUpPage = '/up-page';
  static const signInPage = '/in-page';
  static const addressPage = '/address-page';
  static const addBettaPage = '/addBetta-page';
  static const addOthersPage = '/addOthers-page';
  static const searchPage = '/search-page';
  static const breederDetailPage = '/breederDetail-page';
  static const orderProgressPage = '/orderProgress-page';
  static const shopsOrderProgressPage = '/orderProgress-page';
  static const myProductEdit = '/myproductedit-page';
  static const editProductPage = '/editProductPage-page';
  static String getinitial() => initial;
  static String getSplash() => splash;
  static String getCartPage() => cartPage;
  static String getUpPage() => signUpPage;
  static String getInPage() => signInPage;
  static String getAddressPage() => addressPage;
  static String getAddBettaPage(int pageId) => '$addBettaPage?pageId=$pageId';
  static String getAddOthersPage(int pageId) => '$addOthersPage?pageId=$pageId';
  static String getProductDetailPage(int pageId) =>
      '$fishDetails?pageId=$pageId';

  static String getBreederDetails(int pageId) =>
      '$breederDetailPage?pageId=$pageId';

  static String getOrderProgress(int pageId) =>
      '$orderProgressPage?pageId=$pageId';
  static String getShopsOrderProgress(int pageId) =>
      '$shopsOrderProgressPage?pageId=$pageId';
  static String getMyproductEditPage(int pageId) =>
      '$myProductEdit?pageId=$pageId';
  static String getEditProductPagePage(int pageId) =>
      '$editProductPage?pageId=$pageId';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          //  settings: ,
          builder: (_) => Skeleton(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
