import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quotes_app/modules/screens/quote_page/controller/bg_controller.dart';

import 'Routes/Routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BgController bgController = Get.put(BgController());
  runApp(
    Myapp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color(
          int.parse(bgController.bgModel.bgColor),
        ),
      ),
    ),
  );
}

class Myapp extends StatefulWidget {
  const Myapp({super.key, required ThemeData theme});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.myRoutes,
    );
  }
}
