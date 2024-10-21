import 'package:get/get.dart';
import 'package:quotes_app/modules/screens/quote_page/model/font_model.dart';

class FontController extends GetxController {
  FontModel fontModel = FontModel(
    font: 'Poppins',
  );

  changeFont(String family) {
    fontModel.font = family;
    update();
  }
}
