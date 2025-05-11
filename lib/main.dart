import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ai_prompt_duzenleyici/pages/home_page.dart';
import 'package:ai_prompt_duzenleyici/services/ai_service.dart';
import 'package:ai_prompt_duzenleyici/services/themes_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print("Env başlatıldı");
  final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AiService()),
        ChangeNotifierProvider(create: (_) => ThemeService(brightness: brightness)),
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
      home: const HomePage(),
    );
  }
}
