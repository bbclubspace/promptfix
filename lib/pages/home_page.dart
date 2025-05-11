import 'package:ai_prompt_duzenleyici/services/themes_service.dart';
import 'package:ai_prompt_duzenleyici/themes/app_colors.dart';
import 'package:ai_prompt_duzenleyici/widget/change_language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/ai_service.dart';
import '../widget/button/change_theme_mode_button.dart';
import '../widget/button/result_button.dart';
import '../widget/container/result_container.dart';
import '../widget/option_chip.dart';
import 'package:ai_prompt_duzenleyici/model/ai_model.dart';
import '../widget/text/text_widget.dart';
import '../widget/textfield/prompt_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController promptController = TextEditingController();
  late AiService aiService;
  late ThemeService themeService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    aiService = Provider.of<AiService>(context);
    themeService = Provider.of<ThemeService>(context);
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: "Merhaba", isDark: isDark),
                  //dark mode or light mode
                  ChangeThemeModeButton(
                      themeService: themeService, isDark: isDark),
                ],
              ),
              const SizedBox(height: 100),
              TextWidget(
                  text: "Cevapları değil, soruları\niyileştiriyoruz.",
                  isDark: isDark),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkContainerColor
                      : AppColors.lightContainerColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TextField & Gönder Butonu
                    Row(
                      children: [
                        //users prompt
                        PromptTextField(
                            promptController: promptController, isDark: isDark),
                        //go result
                        ResultButton(
                            isDark: isDark,
                            aiService: aiService,
                            promptController: promptController),
                      ],
                    ),
                    const SizedBox(height: 16),
                    /// İçerik ve Dil Seçenekleri
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// İçerik: Görsel, Kod, Yazı
                        Row(
                          children: [
                            OptionChip(
                                label: "Görsel",
                                contentType: ContentType.visual,
                                aiService: aiService),
                            SizedBox(width: 5),
                            OptionChip(
                                label: "Kod",
                                contentType: ContentType.code,
                                aiService: aiService),
                            SizedBox(width: 5),
                            OptionChip(
                                label: "Yazı",
                                contentType: ContentType.text,
                                aiService: aiService),
                            SizedBox(width: 5),
                          ],
                        ),
                        Change(
                          aiService: aiService,
                          isDark: isDark,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              aiService.aiModel.isResultget
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "Sonuç", isDark: isDark),
                        SizedBox(height: 10),
                        Center(
                            child: ResultContainer(
                                isDark: isDark, aiService: aiService)),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
