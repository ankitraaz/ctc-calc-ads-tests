import 'package:ctc_calc/theme/app_text_style.dart';
import 'package:ctc_calc/theme/appcolor.dart';
import 'package:ctc_calc/widgets/feature_list.dart';
import 'package:ctc_calc/widgets/tax_slab_table.dart';
import 'package:flutter/material.dart';

class TaxYearSection extends StatelessWidget {
  final String year;
  final List<List<String>> taxSlabs;
  final List<Map<String, dynamic>> features;

  const TaxYearSection({
    super.key,
    required this.year,
    required this.taxSlabs,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year header
        Text(
          year,
          style: AppTextStyles.custom(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.heading,
          ),
        ),
        SizedBox(height: 16),

        // Tax slabs section
        Text(
          "Tax Slabs",
          style: AppTextStyles.custom(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        SizedBox(height: 12),

        // Tax table
        TaxSlabTable(data: taxSlabs),
        SizedBox(height: 20),

        // Features section
        FeatureList(features: features),
      ],
    );
  }
}
