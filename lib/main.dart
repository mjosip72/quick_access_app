
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:quick_access/screens/main_screen.dart';
import 'controllers/main_app.dart';

const appTitle = 'Quick access';

void main() async{

  Get.put(MainAppController());

  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(effect: WindowEffect.aero);

  ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    //scaffoldBackgroundColor: const Color.fromRGBO(230, 230, 230, 0.6),
    scaffoldBackgroundColor: Colors.white.withOpacity(0.6),
    //scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
  );

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    darkTheme: theme,
    themeMode: ThemeMode.light,
    defaultTransition: Transition.noTransition,
    transitionDuration: 0.milliseconds,
    home: const MainPage(),
  ));

  doWhenWindowReady(() {
    appWindow.size = const Size(1280, 720);
    appWindow.title = appTitle;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });

}
