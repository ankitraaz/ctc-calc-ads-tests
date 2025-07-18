import 'package:ctc_calc/widgets/banner_ad.dart';
import 'package:flutter/material.dart';

class TaxRegimePage extends StatelessWidget {
  const TaxRegimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: const AdBanner()), // Banner at the top
          const Expanded(child: Center(child: Text('Tax regime'))),
        ],
      ),
    );
  }
}
