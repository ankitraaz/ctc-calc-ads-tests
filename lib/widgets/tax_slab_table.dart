import 'package:ctc_calc/theme/app_text_style.dart';
import 'package:ctc_calc/theme/appcolor.dart';
import 'package:flutter/material.dart';

class TaxSlabTable extends StatelessWidget {
  final List<List<String>> data;

  const TaxSlabTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Income Range (₹)",
                    style: AppTextStyles.custom(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Tax Rate",
                    style: AppTextStyles.custom(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          // Data rows
          ...data.asMap().entries.map((entry) {
            int index = entry.key;
            List<String> row = entry.value;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: index > 0
                      ? BorderSide(color: Colors.grey.shade200)
                      : BorderSide.none,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      row[0],
                      style: AppTextStyles.custom(
                        fontSize: 14,
                        color: AppColors.body,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      row[1],
                      style: AppTextStyles.custom(
                        fontSize: 14,
                        color: AppColors.body,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
