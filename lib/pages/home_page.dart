import 'package:promptfix/services/themes_service.dart';
import 'package:promptfix/themes/app_colors.dart';
import 'package:promptfix/widget/change_language.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../services/ai_service.dart';
import '../widget/button/change_theme_mode_button.dart';
import '../widget/button/result_button.dart';
import '../widget/container/result_container.dart';
import '../widget/option_chip.dart';
import 'package:promptfix/model/ai_model.dart';
import '../widget/text/text_widget.dart';
import '../widget/textfield/prompt_textfield.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../ad_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController promptController = TextEditingController();
  late AiService aiService;
  late ThemeService themeService;
  Indicator indicator = Indicator.ballPulse;
  InterstitialAd? interstitialAd;
  bool isLoading = false;

  late BannerAd bannerAd;

  @override
  void initState() {
    super.initState();
    bannerAd = AdManager.createBannerAd();
    bannerAd.load();
    AdManager.loadInterstitialAd(
      onAdLoaded: (ad) => interstitialAd = ad,
      onAdFailedToLoad: (error) =>
          debugPrint('Interstitial Failed to Load: $error'),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      debugPrint("reklam oluşturuldu");
      interstitialAd!.show();
      interstitialAd = null;
      AdManager.loadInterstitialAd(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (error) =>
            debugPrint('Interstitial Failed to Load: $error'),
      );
    }
  }

  final List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

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
              ///banner ads
              BannerAds(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Merhaba",
                    isDark: isDark,
                    isWelcomeText: true,
                  ),
                  //dark mode or light mode
                  ChangeThemeModeButton(
                      themeService: themeService, isDark: isDark),
                ],
              ),
              const SizedBox(height: 75),
              TextWidget(
                text: "Cevapları değil, soruları\niyileştiriyoruz.",
                isDark: isDark,
                isWelcomeText: false,
              ),
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
                          promptController: promptController,
                          onTap: () async {
                            if (promptController.text.trim().isEmpty) return;
                            // close the keyboard
                            FocusScope.of(context).unfocus();
                            setState(() => isLoading = true);
                            await aiService
                                .fetchAiResult(promptController.text);
                            setState(() => isLoading = false);

                            if (aiService.adsCounter == 4) {
                              Future.delayed(const Duration(seconds: 2), () {
                                showInterstitialAd();
                              });
                            }
                            promptController.clear();
                          },
                        ),
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
                            const SizedBox(width: 5),
                            OptionChip(
                                label: "Kod",
                                contentType: ContentType.code,
                                aiService: aiService),
                            const SizedBox(width: 5),
                            OptionChip(
                                label: "Yazı",
                                contentType: ContentType.text,
                                aiService: aiService),
                            const SizedBox(width: 5),
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
              const SizedBox(
                height: 40,
              ),
              if (isLoading)
                Center(
                  child: SizedBox(
                    height: 50,
                    child: LoadingIndicator(
                      indicatorType: indicator,
                      colors: _kDefaultRainbowColors,
                      strokeWidth: 4.0,
                    ),
                  ),
                )
              else if (aiService.aiModel.isResultget)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Sonuç",
                      isDark: isDark,
                      isWelcomeText: false,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ResultContainer(
                        isDark: isDark,
                        aiService: aiService,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Container BannerAds() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: AdWidget(ad: bannerAd),
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
    );
  }
}
