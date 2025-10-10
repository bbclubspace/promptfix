import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class AdManager {
  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdHelper.bannerUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) => print('Banner Ad Loaded'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Banner Ad Failed to Load: $error');
        },
      ),
    );
  }

  static void loadInterstitialAd({
    required void Function(InterstitialAd ad) onAdLoaded,
    required void Function(LoadAdError error) onAdFailedToLoad,
  }) {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }
}
