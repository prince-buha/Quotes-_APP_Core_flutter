import 'package:flutter/cupertino.dart';

import '../modules/screens/fav-quote/fav-quote.dart';
import '../modules/screens/quote_page/view/quote.dart';
import '../modules/screens/splash-screen/view/splash-screen.dart';

class Routes {
  static String spleshscreen = '/';
  static String qoutepage = 'qoute_page';
  static String favqoute = 'fav_quote';

  static Map<String, WidgetBuilder> myRoutes = {
    spleshscreen: (context) => const SplashScreen(),
    qoutepage: (context) => const QuoteScreen(),
    favqoute: (context) => const FavQuote(),
  };
}
