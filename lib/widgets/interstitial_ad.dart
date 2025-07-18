import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DownloadWithAd extends StatefulWidget {
  const DownloadWithAd({super.key});

  @override
  State<DownloadWithAd> createState() => _DownloadWithAdState();
}

class _DownloadWithAdState extends State<DownloadWithAd> {
  InterstitialAd? _interstitialAd;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/1033173712', // 👈 Replace with your interstitial ad ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _showAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('❌ Interstitial Ad failed: $error');
          _downloadFile(); // If ad fails, directly download
        },
      ),
    );
  }

  void _showAd() {
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('✅ Ad closed');
        ad.dispose();
        _downloadFile(); // Ad finished -> trigger download
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('❌ Ad failed to show');
        ad.dispose();
        _downloadFile(); // Even if failed, trigger download
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }

  void _downloadFile() {
    // 🟢 Your PDF/Excel download logic here
    print("📥 Download started...");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Your download is starting...")),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Download With Ad")),
      body: Center(
        child: ElevatedButton(
          onPressed: _loadInterstitialAd,
          child: const Text("Download PDF/Excel"),
        ),
      ),
    );
  }
}
