import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_ai/src/views/login.dart';

String apiKey = "AIzaSyDtAaoHf7trD1-uC-ku91XFI1ITWTUvQQE";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      title: 'Tugas AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          shape: LinearBorder(),
          backgroundColor: Colors.black),
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.sourceCodePro(textStyle: textTheme.bodyMedium, color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: CupertinoColors.activeBlue),
        useMaterial3: true,
      ),
      home: const LoginPage()
    );
  }
}