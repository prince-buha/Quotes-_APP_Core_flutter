class QuoteModel {
  String quote;
  String category;
  int? id;

  QuoteModel({required this.quote, required this.category});

  factory QuoteModel.fromAPI({required Map data}) {
    return QuoteModel(quote: data['quote'], category: data['category']);
  }
  factory QuoteModel.fromDB({required Map data}) {
    return QuoteModel(quote: data['quote'], category: data['category']);
  }
}
