class TaxData {
  // Tax slabs for FY 2024-25
  static const List<List<String>> taxSlabs2024 = [
    ["Up to ₹3,00,000", "Nil"],
    ["₹3,00,001 - ₹6,00,000", "5%"],
    ["₹6,00,001 - ₹9,00,000", "10%"],
    ["₹12,00,001 - ₹15,00,000", "20%"],
    ["Above ₹15,00,000", "30%"],
  ];

  // Tax slabs for FY 2025-26
  static const List<List<String>> taxSlabs2025 = [
    ["Up to ₹4,00,000", "Nil"],
    ["₹4,00,001 - ₹8,00,000", "5%"],
    ["₹8,00,001 - ₹12,00,000", "10%"],
    ["₹12,00,001 - ₹16,00,000", "15%"],
    ["₹16,00,001 - ₹20,00,000", "20%"],
    ["₹20,00,001 - ₹24,00,000", "25%"],
    ["Above ₹24,00,000", "30%"],
  ];

  // Features for FY 2024-25
  static const List<Map<String, dynamic>> features2024 = [
    {'icon': '✓', 'text': 'Standard Deduction: ₹50,000'},
    {'icon': '✓', 'text': 'Tax Rebate up to ₹7,00,000 income'},
    {'icon': '✗', 'text': 'No marginal relief provision'},
  ];

  // Features for FY 2025-26
  static const List<Map<String, dynamic>> features2025 = [
    {'icon': '✓', 'text': 'Standard Deduction: ₹75,000'},
    {'icon': '✓', 'text': 'Tax Rebate up to ₹12,00,000 income'},
    {'icon': '✓', 'text': 'Marginal Relief Between ₹12L - ₹12.75L'},
    {'icon': '✓', 'text': 'Maximum tax-free income: ₹12,75,000'},
  ];

  // Key changes list
  static const List<String> keyChanges = [
    "Increased basic exemption limit from ₹3L to ₹4L",
    "Added new tax slab of 25% for income between ₹20L - ₹24L",
    "Enhanced Standard Deduction from ₹50,000 to ₹75,000",
    "Increased tax rebate limit from ₹7L to ₹12L",
    "Introduction of marginal relief for income slightly above ₹12L",
    "Restructured tax slabs with wider ranges for better tax distribution",
  ];
}
