class BgModel {
  String bgColor;

  BgModel({required this.bgColor});

  factory BgModel.fromColor({required Map data}) {
    return BgModel(bgColor: data['bgColor']);
  }
}
