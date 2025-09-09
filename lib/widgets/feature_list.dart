import 'package:ctc_calc/theme/app_text_style.dart';
import 'package:ctc_calc/theme/appcolor.dart';
import 'package:flutter/material.dart';

class FeatureList extends StatelessWidget {
  final List<Map<String, dynamic>> features;

  const FeatureList({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Features",
          style: AppTextStyles.custom(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        SizedBox(height: 12),

        // Feature items
        ...features
            .map(
              (feature) => _buildFeatureItem(feature['icon'], feature['text']),
            )
            .toList(),
      ],
    );
  }

  // Build individual feature item
  Widget _buildFeatureItem(String icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            icon,
            style: AppTextStyles.custom(
              fontSize: 16,
              color: icon == "✓" ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 8),
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
}
