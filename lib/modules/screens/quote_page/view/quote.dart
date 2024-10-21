import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/modules/helpers/db_helper.dart';
import 'package:quotes_app/modules/helpers/quote_helper.dart';
import 'package:quotes_app/modules/screens/quote_page/controller/bg_controller.dart';
import 'package:quotes_app/modules/screens/quote_page/controller/font_controller.dart';
import 'package:quotes_app/modules/screens/quote_page/model/bg_model.dart';
import 'package:quotes_app/modules/screens/quote_page/model/font_model.dart';
import 'package:quotes_app/modules/screens/quote_page/model/quote_model.dart';
import 'package:quotes_app/Routes/Routes.dart';
import 'package:quotes_app/modules/utils/fonts.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    FontController fontController = Get.put(FontController());
    BgController bgController = Get.put(BgController());
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GetBuilder<BgController>(
          builder: (controller) {
            return Container(
              color: Colors.white,
              child: Scaffold(
                backgroundColor: Color(
                  int.parse(bgController.bgModel.bgColor),
                ).withOpacity(0.5),
                body: FutureBuilder(
                  future: QuoteHelper.quoteHelper.fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      return CardSwiper(
                        backCardOffset: Offset(0, 100),
                        isLoop: true,
                        scale: 0.5,
                        cardsCount: snapshot.data!.length,
                        cardBuilder: (context, index, _, __) {
                          return Center(
                            child: Container(
                              height: h / 1.7,
                              decoration: BoxDecoration(
                                  color: Color(
                                    int.parse(
                                      bgController.bgModel.bgColor,
                                    ),
                                  ).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    width: 3,
                                    color: Color(
                                      int.parse(bgController.bgModel.bgColor),
                                    ),
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(20),
                                    height: h / 2,
                                    child: Text(
                                      snapshot.data![index].quote,
                                      style: GoogleFonts.getFont(
                                        fontController.fontModel.font,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.ios_share_rounded,
                                          size: 28,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          QuoteModel quote = QuoteModel(
                                            quote: snapshot.data![index].quote,
                                            category:
                                                snapshot.data![index].category,
                                          );
                                          int? res = await DBHelper.dbHelper
                                              .insertQuote(m_quote: quote);
                                          log("$res}");
                                        },
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: h / 18,
                width: w / 8,
                child: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "FONT STYLE",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: allFonts.length,
                                  itemBuilder: (context, index) {
                                    List<FontModel> fonts = allFonts
                                        .map((e) =>
                                            FontModel.fromGoogle(data: e))
                                        .toList();
                                    return GestureDetector(
                                      onTap: () {
                                        fontController
                                            .changeFont(fonts[index].font);
                                        Get.back();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        height: h / 100,
                                        width: w / 5,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            width: 2,
                                          ),
                                        ),
                                        child: Text(
                                          "Abc",
                                          style: GoogleFonts.getFont(
                                            fonts[index].font,
                                            fontSize: 26,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: h / 30,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "BACKGROUND COLOR",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: allFonts.length,
                                  itemBuilder: (context, index) {
                                    List<BgModel> bg = allFonts
                                        .map((e) => BgModel.fromColor(data: e))
                                        .toList();
                                    return GestureDetector(
                                      onTap: () {
                                        bgController
                                            .changeColor(bg[index].bgColor);
                                        log(bgController.bgModel.bgColor);
                                        Get.back();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        height: h / 100,
                                        width: w / 5,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(
                                              int.parse(bg[index].bgColor)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: h / 30,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  elevation: 0,
                  child: const Image(
                    image: AssetImage('lib/assets/edit-black.png'),
                    height: 25,
                  ),
                  backgroundColor: Color(
                    int.parse(
                      bgController.bgModel.bgColor,
                    ),
                  ).withOpacity(0.9),
                ),
              ),
              SizedBox(
                height: h / 18,
                width: w / 8,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.favqoute);
                  },
                  elevation: 0,
                  backgroundColor: Color(
                    int.parse(
                      bgController.bgModel.bgColor,
                    ),
                  ).withOpacity(0.9),
                  child: const Image(
                    image: AssetImage("lib/assets/heart.png"),
                    height: 25,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
