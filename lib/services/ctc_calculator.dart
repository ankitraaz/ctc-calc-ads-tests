import '../model/ctc_model.dart';

class CtcCalculator {
  static CtcBreakdown calculate(double ctc) {
    final basic = ctc * 0.4;
    final hra = ctc * 0.2;
    final da = ctc * 0.1;
    final lta = ctc * 0.05;
    final specialAllowance = ctc * 0.15;
    final performanceBonus = ctc * 0.1;

    final grossSalary =
        basic + hra + da + lta + specialAllowance + performanceBonus;
    final standardDeduction = 75000.0;
    final taxableIncome = grossSalary - standardDeduction;

    final epfEmployee = basic * 0.12;
    final epfEmployer = basic * 0.12;
    final esiEmployee = ctc * 0.0175;
    final esiEmployer = ctc * 0.0325;
    final professionalTax = 2400.0;
    final incomeTax = 0.0; // Placeholder

    final totalDeductions =
        epfEmployee + esiEmployee + professionalTax + incomeTax;
    final netAnnual = grossSalary - totalDeductions;
    final netMonthly = netAnnual / 12;

    return CtcBreakdown(
      netMonthly: netMonthly,
      netAnnual: netAnnual,
      grossSalary: grossSalary,
      totalDeductions: totalDeductions,
      taxableIncome: taxableIncome,
      standardDeduction: standardDeduction,
      earnings: {
        'Basic Salary': basic,
        'HRA': hra,
        'DA': da,
        'LTA': lta,
        'Special Allowance': specialAllowance,
        'Performance Bonus': performanceBonus,
        'Gross Salary': grossSalary,
        'Standard Deduction': -standardDeduction,
        'Taxable Income': taxableIncome,
      },
      deductions: {
        'EPF (Employee)': -epfEmployee,
        'ESI (Employee)': -esiEmployee,
        'Professional Tax': -professionalTax,
        'Income Tax': -incomeTax,
      },
      employerContribution: {
        'Employer EPF Contribution': epfEmployer,
        'Employer ESI Contribution': esiEmployer,
      },
    );
  }
}
