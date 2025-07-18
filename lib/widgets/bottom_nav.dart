import 'package:ctc_calc/pages/contact_us.dart';
import 'package:ctc_calc/pages/ctc_calculator_page.dart';
import 'package:ctc_calc/pages/tax_regime_page.dart';
import 'package:ctc_calc/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final List<Widget> _pages = const [
    CtcCalculatorPage(),
    TaxRegimePage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: _pages[navProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: navProvider.updateIndex,
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'CTC'),
          BottomNavigationBarItem(
            icon: Icon(Icons.balance),
            label: 'Tax Regime',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail_outlined),
            label: 'Contact Us',
          ),
        ],
      ),
    );
  }
}
