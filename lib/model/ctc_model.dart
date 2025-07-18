class CtcBreakdown {
  final double netMonthly;
  final double netAnnual;
  final double grossSalary;
  final double totalDeductions;
  final double taxableIncome;
  final double standardDeduction;

  final Map<String, double> earnings; // Earnings Section
  final Map<String, double> deductions; // Deductions Section
  final Map<String, double> employerContribution; // Cost to Company Section

  CtcBreakdown({
    required this.netMonthly,
    required this.netAnnual,
    required this.grossSalary,
    required this.totalDeductions,
    required this.taxableIncome,
    required this.standardDeduction,
    required this.earnings,
    required this.deductions,
    required this.employerContribution,
  });
}
