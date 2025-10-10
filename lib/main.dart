import 'package:promptfix/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:promptfix/services/ai_service.dart';
import 'package:promptfix/services/themes_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await dotenv.load(fileName: ".env");
  debugPrint("Env başlatıldı");
  final aiService = AiService();
  await aiService.loadAdsCounter();

  final themeService = await ThemeService.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AiService()),
        ChangeNotifierProvider(create: (_) => themeService),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeService.themeData,
      home: const SplashScreen(),
    );
  }
}
