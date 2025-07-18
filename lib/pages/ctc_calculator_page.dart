import 'package:flutter/material.dart';
import '../widgets/ctc_calculator_form.dart';

class CtcCalculatorPage extends StatelessWidget {
  const CtcCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('CTC Calculator'),
      ),
      body: const CtcCalculatorForm(),
    );
  }
}
