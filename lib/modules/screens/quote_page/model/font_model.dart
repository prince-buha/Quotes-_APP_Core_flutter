class FontModel {
  String font;

  FontModel({required this.font});

  factory FontModel.fromGoogle({required Map data}) {
    return FontModel(font: data['font']);
  }
}
