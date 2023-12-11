import 'package:flutter/material.dart';


class SalaryCalculatorScreen extends StatefulWidget {
  @override
  _SalaryCalculatorScreenState createState() => _SalaryCalculatorScreenState();
}

class _SalaryCalculatorScreenState extends State<SalaryCalculatorScreen> {
  double ctc = 0.0;
  double basicSalary = 0.0;
  double bonus = 0.0;
  double mpt = 0.0;
  double merpf = 0.0;
  double meepf = 0.0;
  double mad = 0.0;

  double hra = 0.0;
  double specialAllowance = 0.0;
  double otherAllowances = 0.0;
  double deductions = 0.0;

  // Calculated values
  double grossSalary = 0.0;
  double providentFund = 0.0;
  double professionalTax = 0.0;
  double incomeTax = 0.0;
  double netSalary = 0.0;

void calculateSalary() {
  grossSalary = basicSalary + hra + specialAllowance + otherAllowances;

  double pfRate = 0.12;
  double pfEmployee = grossSalary * pfRate;

  double ptRate = 200;
  professionalTax = ptRate;

  if (grossSalary > 500000) {
    incomeTax = (grossSalary - 500000) * 0.1;
  }

  netSalary =
      grossSalary - pfEmployee - professionalTax - incomeTax - deductions;

  setState(() {
    grossSalary = grossSalary;
    providentFund = pfEmployee;
    professionalTax = professionalTax;
    incomeTax = incomeTax;
    deductions = deductions;
    netSalary = netSalary;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Salary:',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('Cost to Company:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  ctc = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Basic Salary:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  basicSalary = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Bonus Included in CTC (Amount):'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  bonus = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Monthly Professional Tax:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  mpt = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Bonus Included in CTC (Amount):'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  bonus = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Monthly Employer PF:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  merpf = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Monthly Employee PF:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  meepf = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Monthly Additional Deduction:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  deductions = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Special Allowance:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  specialAllowance = double.tryParse(value) ?? 0.0;
                },
              ),
              const Text('Other Allowances:'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  otherAllowances = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    calculateSalary();
                  });
                },
                child: const Text('Calculate Salary'),
              ),
              const SizedBox(height: 16),
              Text('Gross Salary: $grossSalary'),
              Text('Provident Fund (PF) (Employee Share): $providentFund'),
              Text('Professional Tax (PT): $professionalTax'),
              Text('Income Tax: $incomeTax'),
              Text('Deductions: $deductions'),
              Text('Net Salary: $netSalary'),
            ],
          ),
        ),
      ),
    );
  }
}
