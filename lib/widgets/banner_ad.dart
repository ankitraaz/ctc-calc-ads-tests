import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-9423986225196759/6051039428', //  Replace with test ID if needed
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('✅ Ad loaded successfully');
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          print('❌ Failed to load ad: ${error.message}');
          ad.dispose();
          setState(() {
            _bannerAd = null;
          });
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd != null
        ? SizedBox(
            height: _bannerAd!.size.height.toDouble(),
            width: _bannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
