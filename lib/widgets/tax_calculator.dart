import 'package:ctc_calc/theme/app_text_style.dart';
import 'package:ctc_calc/theme/appcolor.dart';
import 'package:ctc_calc/widgets/tax_calculator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaxCalculatorForm extends StatefulWidget {
  final Function(Map<String, dynamic>, Map<String, dynamic>) onCalculate;

  const TaxCalculatorForm({super.key, required this.onCalculate});

  @override
  State<TaxCalculatorForm> createState() => _TaxCalculatorFormState();
}

class _TaxCalculatorFormState extends State<TaxCalculatorForm> {
  final TextEditingController _incomeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isCalculating = false;

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Row(
            children: [
              Icon(
                Icons.calculate_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Tax Calculator",
                style: AppTextStyles.custom(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Input label
          Text(
            "Annual Income (₹)",
            style: AppTextStyles.custom(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.heading,
            ),
          ),
          SizedBox(height: 8),

          // Input field with validation
          TextFormField(
            controller: _incomeController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: InputDecoration(
              hintText: "Enter your annual income",
              hintStyle: AppTextStyles.custom(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: AppTextStyles.custom(fontSize: 14),
            validator: _validateIncome,
          ),
          SizedBox(height: 16),

          // Calculate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.linkBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isCalculating ? null : _handleCalculate,
              child: _isCalculating
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("Calculating..."),
                      ],
                    )
                  : Text(
                      "Calculate Tax",
                      style: AppTextStyles.custom(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // Validate income input
  String? _validateIncome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your annual income';
    }

    double? income = double.tryParse(value);
    if (income == null) {
      return 'Please enter a valid number';
    }

    if (income <= 0) {
      return 'Income must be greater than 0';
    }

    if (income > 99999999) {
      return 'Income seems too high';
    }

    return null;
  }

  // Handle calculate button press
  void _handleCalculate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isCalculating = true;
    });

    try {
      double income = double.parse(_incomeController.text);

      // Calculate tax for both years
      Map<String, dynamic> result2024 = TaxCalculationService.calculateTax2024(
        income,
      );
      Map<String, dynamic> result2025 = TaxCalculationService.calculateTax2025(
        income,
      );

      // Simulate calculation delay
      await Future.delayed(Duration(milliseconds: 500));

      // Call parent callback
      widget.onCalculate(result2024, result2025);
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error calculating tax: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isCalculating = false;
      });
    }
  }
}
