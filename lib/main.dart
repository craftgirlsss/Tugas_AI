import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uas_ai/src/views/splash_screen.dart';

String apiKey = "AIzaSyDtAaoHf7trD1-uC-ku91XFI1ITWTUvQQE";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zhfjjcaxzhmrexhkzest.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpoZmpqY2F4emhtcmV4aGt6ZXN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTU2Nzg4MDMsImV4cCI6MjAxMTI1NDgwM30.i1m1xAiYvDYOWLN8YuIMGTF2mu9CfsB_etdfwNd2DBE',
  );
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
      home: const SplashScreenPage()
    );
  }
}