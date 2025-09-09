class TaxCalculationService {
  // Calculate tax for FY 2024-25
  static Map<String, dynamic> calculateTax2024(double income) {
    double tax = 0;
    double taxableIncome = income - 50000; // Standard deduction

    if (taxableIncome <= 0) {
      return _buildTaxResult(0, 0, income, 50000);
    }

    // Tax slab calculations
    if (taxableIncome > 300000) {
      tax += (taxableIncome - 300000) * 0.05; // 5% on income above 3L
    }
    if (taxableIncome > 600000) {
      tax += (taxableIncome - 600000) * 0.05; // Additional 5% (total 10%)
    }
    if (taxableIncome > 900000) {
      tax += (taxableIncome - 900000) * 0.10; // Additional 10% (total 20%)
    }
    if (taxableIncome > 1200000) {
      tax += (taxableIncome - 1200000) * 0.10; // Additional 10% (total 30%)
    }

    // Apply tax rebate for income up to 7L
    if (income <= 700000) {
      tax = 0;
    }

    return _buildTaxResult(tax, taxableIncome, income, 50000);
  }

  // Calculate tax for FY 2025-26
  static Map<String, dynamic> calculateTax2025(double income) {
    double tax = 0;
    double taxableIncome = income - 75000; // Enhanced standard deduction

    if (taxableIncome <= 0) {
      return _buildTaxResult(0, 0, income, 75000);
    }

    // Tax slab calculations
    if (taxableIncome > 400000) {
      tax += (taxableIncome - 400000) * 0.05; // 5% on income above 4L
    }
    if (taxableIncome > 800000) {
      tax += (taxableIncome - 800000) * 0.05; // Additional 5% (total 10%)
    }
    if (taxableIncome > 1200000) {
      tax += (taxableIncome - 1200000) * 0.05; // Additional 5% (total 15%)
    }
    if (taxableIncome > 1600000) {
      tax += (taxableIncome - 1600000) * 0.05; // Additional 5% (total 20%)
    }
    if (taxableIncome > 2000000) {
      tax += (taxableIncome - 2000000) * 0.05; // Additional 5% (total 25%)
    }
    if (taxableIncome > 2400000) {
      tax += (taxableIncome - 2400000) * 0.05; // Additional 5% (total 30%)
    }

    // Apply tax rebate for income up to 12L
    if (income <= 1200000) {
      tax = 0;
    }

    // Apply marginal relief for income between 12L - 12.75L
    if (income > 1200000 && income <= 1275000) {
      double marginalRelief = (income - 1200000) * 0.15;
      tax = marginalRelief;
    }

    return _buildTaxResult(tax, taxableIncome, income, 75000);
  }

  // Helper method to build tax result
  static Map<String, dynamic> _buildTaxResult(
    double tax,
    double taxableIncome,
    double grossIncome,
    double standardDeduction,
  ) {
    return {
      'grossIncome': grossIncome,
      'standardDeduction': standardDeduction,
      'taxableIncome': taxableIncome,
      'tax': tax,
      'netIncome': grossIncome - tax,
      'effectiveRate': grossIncome > 0 ? (tax / grossIncome) * 100 : 0,
    };
  }
}
