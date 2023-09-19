import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pos_machine/components/main_screen.dart';
import 'package:pos_machine/providers/cart.dart';
import 'package:provider/provider.dart';

import 'controllers/sidebar_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(SideBarController());
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
  //     .then((_) {
  //   runApp(const MyApp());
  // });
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter POS Machine',
        theme: ThemeData(),
        home: const MainScreen(),
      ),
    );
  }
}
