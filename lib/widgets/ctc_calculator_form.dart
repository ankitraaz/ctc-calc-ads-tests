import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ctc_calc/model/ctc_model.dart';
import 'package:ctc_calc/services/ctc_calculator.dart';

class CtcCalculatorForm extends StatefulWidget {
  const CtcCalculatorForm({super.key});

  @override
  State<CtcCalculatorForm> createState() => _CtcCalculatorFormState();
}

class _CtcCalculatorFormState extends State<CtcCalculatorForm> {
  final TextEditingController _ctcController = TextEditingController();
  bool _isYearly = true;
  CtcBreakdown? _result;
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  InterstitialAd? _interstitialAd;
  VoidCallback? _onAdCompleteCallback;

  @override
  void initState() {
    super.initState();
    MobileAds.instance.initialize();
  }

  void _calculate() {
    final input = double.tryParse(_ctcController.text.replaceAll(',', ''));
    if (input != null && input > 0) {
      final yearlyCtc = _isYearly ? input : input * 12;
      setState(() {
        _result = CtcCalculator.calculate(yearlyCtc);
      });
    }
  }

  Future<void> _exportToPDF() async {
    _showAdThenExecute(_downloadPDF);
  }

  Future<void> _exportToExcel() async {
    _showAdThenExecute(_downloadExcel);
  }

  void _showAdThenExecute(VoidCallback downloadCallback) {
    _onAdCompleteCallback = downloadCallback;

    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/1033173712', // replace with real adUnitId in production
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  _onAdCompleteCallback?.call();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  ad.dispose();
                  _onAdCompleteCallback?.call();
                },
              );
          _interstitialAd?.show();
        },
        onAdFailedToLoad: (error) {
          _onAdCompleteCallback?.call(); // fallback
        },
      ),
    );
  }

  Future<void> _downloadPDF() async {
    if (_result == null || !await _requestPermission()) return;

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Text(
            "CTC Breakdown",
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            "Net Monthly Salary: ${formatter.format(_result!.netMonthly)}",
          ),
          pw.Text("Net Annual Salary: ${formatter.format(_result!.netAnnual)}"),
          pw.SizedBox(height: 16),
          _buildPdfSection("Earnings", _result!.earnings),
          _buildPdfSection("Deductions", _result!.deductions),
          _buildPdfSection("Summary", {
            "Total Deductions": -_result!.totalDeductions,
          }),
          _buildPdfSection(
            "Employer Contribution",
            _result!.employerContribution,
          ),
        ],
      ),
    );

    final dir = Directory('/storage/emulated/0/Download');
    final file = File("${dir.path}/ctc_breakdown.pdf");
    await file.writeAsBytes(await pdf.save());

    _showSnack("PDF saved to Downloads");
  }

  Future<void> _downloadExcel() async {
    if (_result == null || !await _requestPermission()) return;

    final excel = Excel.createExcel();
    final sheet = excel['CTC Breakdown'];

    sheet.appendRow([
      TextCellValue("Net Monthly Salary"),
      TextCellValue(formatter.format(_result!.netMonthly)),
    ]);
    sheet.appendRow([
      TextCellValue("Net Annual Salary"),
      TextCellValue(formatter.format(_result!.netAnnual)),
    ]);
    sheet.appendRow([]);

    _appendExcelSection(sheet, "Earnings", _result!.earnings);
    _appendExcelSection(sheet, "Deductions", _result!.deductions);
    _appendExcelSection(sheet, "Summary", {
      "Total Deductions": -_result!.totalDeductions,
    });
    _appendExcelSection(
      sheet,
      "Employer Contribution",
      _result!.employerContribution,
    );

    final dir = Directory('/storage/emulated/0/Download');
    final file = File("${dir.path}/ctc_breakdown.xlsx")
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    _showSnack("Excel saved to Downloads");
  }

  pw.Widget _buildPdfSection(String title, Map<String, double> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 12),
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        ...items.entries.map(
          (e) => pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [pw.Text(e.key), pw.Text(formatter.format(e.value))],
          ),
        ),
      ],
    );
  }

  void _appendExcelSection(
    Sheet sheet,
    String title,
    Map<String, double> data,
  ) {
    sheet.appendRow([TextCellValue(title)]);
    data.forEach((key, value) {
      sheet.appendRow([
        TextCellValue(key),
        TextCellValue(formatter.format(value)),
      ]);
    });
    sheet.appendRow([]);
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildSection(
    String title,
    Map<String, double> items, {
    bool highlight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        ...items.entries.map(
          (e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e.key),
              Text(
                formatter.format(e.value),
                style: TextStyle(
                  color: e.value < 0 ? Colors.red : null,
                  fontWeight: highlight ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _ctcController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter your CTC (₹)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Monthly"),
                  selected: !_isYearly,
                  onSelected: (val) => setState(() => _isYearly = !val),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text("Yearly"),
                  selected: _isYearly,
                  onSelected: (val) => setState(() => _isYearly = val),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            if (_result != null) ...[
              Text(
                'Net Monthly Salary: ${formatter.format(_result!.netMonthly)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Net Annual Salary: ${formatter.format(_result!.netAnnual)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              _buildSection("Earnings", _result!.earnings),
              _buildSection("Deductions", _result!.deductions),
              _buildSection("Summary", {
                'Total Deductions': -_result!.totalDeductions,
              }, highlight: true),
              _buildSection("Cost to Company", _result!.employerContribution),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    onPressed: _exportToPDF,
                    label: const Text("Download PDF"),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.table_view),
                    onPressed: _exportToExcel,
                    label: const Text("Download Excel"),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
