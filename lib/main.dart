import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // ← Add this

import 'provider/navigation_provider.dart';
import 'package:ctc_calc/widgets/home_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ← Required before initializing plugins
  await MobileAds.instance.initialize(); // ← Initialize Google Mobile Ads SDK
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CTC Calculator',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const HomeNavigation(),
      ),
    );
  }
}
