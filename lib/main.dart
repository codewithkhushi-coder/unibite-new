import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const UniBiteApp());
}

class UniBiteApp extends StatelessWidget {
  const UniBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniBite',
      theme: ThemeData(
        primaryColor: AppColors.primaryPink,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryPink,
          primary: AppColors.primaryPink,
        ),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}