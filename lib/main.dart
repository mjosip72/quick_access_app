
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:get/get.dart';
import 'package:quick_access/screens/main_screen.dart';
import 'controllers/main_app.dart';
import 'package:win_titlebar/win_titlebar.dart';

const appTitle = 'Quick access';

void main() async{

  Get.put(MainAppController());

  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(effect: WindowEffect.transparent);

  ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black.withOpacity(0.64),
    useMaterial3: true,
  );

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    darkTheme: theme,
    themeMode: ThemeMode.dark,
    defaultTransition: Transition.noTransition,
    transitionDuration: 0.milliseconds,
    home: const MainPage(),
  ));

  initializeWindow(
    title: appTitle,
    onAppClose: () {
      MainAppController.instance.onAppClose();
      return true;
    },
  );

}
