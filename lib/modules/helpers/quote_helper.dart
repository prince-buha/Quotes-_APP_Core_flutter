import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_app/modules/screens/quote_page/model/quote_model.dart';

class QuoteHelper {
  //todo:single_turn var
  QuoteHelper._();
  static final QuoteHelper quoteHelper = QuoteHelper._();
  //todo:api_fetch_data
  Future<List<QuoteModel>?> fetchData() async {
    String api =
        "https://quote-generator-api-six.vercel.app/api/quotes/?limit=2000";

    http.Response response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);
      List allQuote = decodedData['data'];
      List<QuoteModel> quote =
          allQuote.map((e) => QuoteModel.fromAPI(data: e)).toList();
      return quote;
    } else {
      return null;
    }
  }
}
