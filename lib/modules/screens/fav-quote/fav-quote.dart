import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:quotes_app/modules/helpers/db_helper.dart';
import 'package:quotes_app/modules/utils/fonts.dart';

class FavQuote extends StatefulWidget {
  const FavQuote({Key? key}) : super(key: key);

  @override
  State<FavQuote> createState() => _FavQuoteState();
}

class _FavQuoteState extends State<FavQuote> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fav Quotes"),
      ),
      body: FutureBuilder(
        future: DBHelper.dbHelper.fetchQuote(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(int.parse(allFonts[index]['bgColor']!)),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  height: h / 3,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          snapshot.data![index].quote,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _copyToClipboard(snapshot.data![index].quote);
                            },
                            icon: const Icon(Icons.copy),
                          ),
                          IconButton(
                            onPressed: () {
                              _shareQupte(snapshot.data![index].quote);
                            },
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      ),
                    ],
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
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Quote copied to clipboard"),
      ),
    );
  }

  void _shareQupte(String quote) async {
    try {
      await FlutterShare.share(
          title: 'Share Quote', text: quote, chooserTitle: 'Share via');
    } catch (e) {
      log('Error sharing : $e');
    }
  }
}
