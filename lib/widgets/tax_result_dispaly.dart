import 'package:ctc_calc/theme/app_text_style.dart';
import 'package:ctc_calc/theme/appcolor.dart';
import 'package:flutter/material.dart';

class TaxResultDisplay extends StatelessWidget {
  final Map<String, dynamic> result2024;
  final Map<String, dynamic> result2025;

  const TaxResultDisplay({
    super.key,
    required this.result2024,
    required this.result2025,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results header
        Text(
          "Tax Calculation Results",
          style: AppTextStyles.custom(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.heading,
          ),
        ),
        SizedBox(height: 16),

        // Comparison table
        _buildComparisonTable(),
        SizedBox(height: 16),

        // Savings summary
        _buildSavingsSummary(),
      ],
    );
  }

  // Build comparison table
  Widget _buildComparisonTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        // Header row
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: [
            _buildTableCell("Details", isHeader: true),
            _buildTableCell("FY 2024-25", isHeader: true),
            _buildTableCell("FY 2025-26", isHeader: true),
          ],
        ),
        // Data rows
        _buildTableRow(
          "Gross Income",
          result2024['grossIncome'],
          result2025['grossIncome'],
        ),
        _buildTableRow(
          "Standard Deduction",
          result2024['standardDeduction'],
          result2025['standardDeduction'],
        ),
        _buildTableRow(
          "Taxable Income",
          result2024['taxableIncome'],
          result2025['taxableIncome'],
        ),
        _buildTableRow("Tax Amount", result2024['tax'], result2025['tax']),
        _buildTableRow(
          "Net Income",
          result2024['netIncome'],
          result2025['netIncome'],
        ),
        _buildTableRow(
          "Effective Rate (%)",
          result2024['effectiveRate'],
          result2025['effectiveRate'],
        ),
      ],
    );
  }

  // Build table row
  TableRow _buildTableRow(String label, dynamic value1, dynamic value2) {
    return TableRow(
      children: [
        _buildTableCell(label),
        _buildTableCell(_formatValue(value1)),
        _buildTableCell(_formatValue(value2)),
      ],
    );
  }

  // Build table cell
  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: AppTextStyles.custom(
          fontSize: 14,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? AppColors.heading : AppColors.body,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Build savings summary
  Widget _buildSavingsSummary() {
    double savings = result2024['tax'] - result2025['tax'];
    bool isSaving = savings > 0;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSaving ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSaving ? Colors.green.shade300 : Colors.red.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSaving ? Icons.trending_down : Icons.trending_up,
            color: isSaving ? Colors.green : Colors.red,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSaving
                      ? "Tax Savings in FY 2025-26"
                      : "Additional Tax in FY 2025-26",
                  style: AppTextStyles.custom(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSaving
                        ? Colors.green.shade800
                        : Colors.red.shade800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "₹${savings.abs().toStringAsFixed(0)}",
                  style: AppTextStyles.custom(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSaving ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Format value for display
  String _formatValue(dynamic value) {
    if (value is double) {
      if (value == value.roundToDouble()) {
        return value.toStringAsFixed(0);
      }
      return value.toStringAsFixed(2);
    }
    return value.toString();
  }
}
