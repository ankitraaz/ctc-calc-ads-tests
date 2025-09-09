import 'package:ctc_calc/theme/app_text_style.dart';
import 'package:ctc_calc/theme/appcolor.dart';
import 'package:ctc_calc/widgets/appbar_custom.dart';
import 'package:ctc_calc/widgets/banner_ad.dart';
import 'package:ctc_calc/widgets/custom_container.dart';
import 'package:ctc_calc/widgets/tax_calculator.dart';
import 'package:ctc_calc/widgets/tax_data.dart';
import 'package:ctc_calc/widgets/tax_result_dispaly.dart';
import 'package:ctc_calc/widgets/tax_year_section.dart';
import 'package:flutter/material.dart';

// Assuming these are defined elsewhere in your project

class TaxRegimePage extends StatefulWidget {
  const TaxRegimePage({super.key});

  @override
  State<TaxRegimePage> createState() => _TaxRegimePageState();
}

class _TaxRegimePageState extends State<TaxRegimePage> {
  final ScrollController _scrollController = ScrollController();
  Map<String, dynamic>? _taxResult2024;
  Map<String, dynamic>? _taxResult2025;
  bool _showResults = false;
  final GlobalKey _resultsKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Handle tax calculation results
  void _handleTaxCalculation(
    Map<String, dynamic> result2024,
    Map<String, dynamic> result2025,
  ) {
    setState(() {
      _taxResult2024 = result2024;
      _taxResult2025 = result2025;
      _showResults = true;
    });

    // Scroll to results
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_resultsKey.currentContext != null) {
        Scrollable.ensureVisible(
          _resultsKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Header section
  Widget _buildHeaderSection() {
    return Column(
      children: [
        Center(
          child: Text(
            "New Tax Regime Changes: FY 2024-25 vs FY 2025-26",
            style: AppTextStyles.custom(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.linkBlue,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            "Compare tax calculations and savings under the new tax regime for both financial years",
            style: AppTextStyles.custom(fontSize: 14, color: AppColors.body),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Key changes section
  Widget _buildKeyChangesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard_arrow_down, color: AppColors.heading, size: 20),
            const SizedBox(width: 4),
            Text(
              "Key Changes in FY 2025-26",
              style: AppTextStyles.custom(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.heading,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...TaxData.keyChanges
            .map((change) => _buildChangeItem(change))
            .toList(),
      ],
    );
  }

  // Change item builder
  Widget _buildChangeItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "✓",
            style: AppTextStyles.custom(fontSize: 14, color: Colors.green),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.custom(fontSize: 14, color: AppColors.body),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SafeArea(child: AdBanner()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeaderSection(),
                  const SizedBox(height: 24),
                  CustomContainer(
                    padding: const EdgeInsets.all(20),
                    child: TaxCalculatorForm(
                      onCalculate: _handleTaxCalculation,
                    ),
                  ),
                  if (_showResults &&
                      _taxResult2024 != null &&
                      _taxResult2025 != null) ...[
                    const SizedBox(height: 24),
                    CustomContainer(
                      key: _resultsKey,
                      padding: const EdgeInsets.all(20),
                      child: TaxResultDisplay(
                        result2024: _taxResult2024!,
                        result2025: _taxResult2025!,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  CustomContainer(
                    padding: const EdgeInsets.all(20),
                    child: TaxYearSection(
                      year: "FY 2024-25",
                      taxSlabs: TaxData.taxSlabs2024,
                      features: TaxData.features2024,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomContainer(
                    padding: const EdgeInsets.all(20),
                    child: TaxYearSection(
                      year: "FY 2025-26",
                      taxSlabs: TaxData.taxSlabs2025,
                      features: TaxData.features2025,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomContainer(
                    padding: const EdgeInsets.all(20),
                    child: _buildKeyChangesSection(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
