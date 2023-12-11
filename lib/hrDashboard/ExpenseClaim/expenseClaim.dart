
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/hrDashboard/ExpenseClaim/document.dart';

class ExpenseClaimForm extends StatefulWidget {
  const ExpenseClaimForm({super.key});
  @override
  _ExpenseClaimFormState createState() => _ExpenseClaimFormState();
}
class _ExpenseClaimFormState extends State<ExpenseClaimForm> {
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _totalExpensesController = TextEditingController();
  final TextEditingController _date=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FilePickerResult? result;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Expense> _expenses = [];


  final TextEditingController expenseType = TextEditingController();

  List<String> _expensesList = [];
  String _expTypes = 'Select Position'; // Default selection
  String? expenseText;

  @override
  void initState() {
    super.initState();
    _fetchTypes();
  }

  Future<void> _fetchTypes() async {
    try {
      final querySnapshot = await _firestore.collection('exptypes').get();
      _expensesList = querySnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['expenseType'].toString())
          .toList();
      if (_expensesList.isNotEmpty) {
        _expTypes = _expensesList[0]; // Set the first item as default
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching  list: $e');
      }
    }
  }

  void _addExpense() {
    final expense = Expense(
      description: _descriptionController.text,
      amount: double.parse(_expensesController.text),
      expenseType: _expTypes,
    );

    if (expenseText == null) {
      expenseText = '${expense.expenseType}: ${expense.amount.toStringAsFixed(2)}';
    }
    _expenses.add(expense);
    _expensesController.clear();

    setState(() {});
  }

  void _calculateTotalExpenses() {
    double totalExpenses = 0.0;

    for (final expense in _expenses) {
      totalExpenses += expense.amount;
    }

    setState(() {
      _totalExpensesController.text = totalExpenses.toStringAsFixed(2);
    });
  }
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day
        .toString().padLeft(2, '0')}';
  }

  void _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: DateTime(currentDate.year + 100),
    );

    if (selectedDate != null) {
      setState(() {
        _date.text = formatDate(selectedDate);

        final DateTime now = DateTime.now();
      });
    }
  }
  Future<void> _saveExpenseData() async {
    try {
      DocumentReference expenseRef = await _firestore.collection('expenseClaims').add({
        'date': _date.text,
        'expenses': _expenses.map((expense) => {
          'description': expense.description,
          'amount': expense.amount,
          'expenseType': expense.expenseType,
        }).toList(),
        'totalExpenses': double.parse(_totalExpensesController.text),
      });

      if (kDebugMode) {
        print('Expense data saved with ID: ${expenseRef.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving expense data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Claim Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left: 1200),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const DocumentPage()));

                  },
                      child: const Text("Documentation")),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Employee ID:",
                   labelStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),

                ),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Employee Name:",
                    labelStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),

                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _date,

                  onTap: () {
                    _selectDate(context); // Open a date picker dialog
                  },
                  decoration: const InputDecoration(
                    labelText: 'Date:',
                    labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a  value.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                 Card(
                   child: Column(
                     children: [
                       Row(
                         children: [
                           const Text("Select Expense Type:", style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 17,
                               color: Colors.black
                           ),),
                           const SizedBox(width: 30,),
                           DropdownButton<String>(
                             value: _expTypes,
                             onChanged: (newValue) {
                               setState(() {
                                 _expTypes = newValue!;
                               });
                             },
                             items: _expensesList.map((expenseType) {
                               return DropdownMenuItem<String>(
                                 value: expenseType,
                                 child: Text(expenseType),
                               );
                             }).toList(),
                           ),

                         ],
                       ),
                       const SizedBox(height: 10,),
                       TextFormField(
                         controller: _descriptionController,
                         decoration: const InputDecoration(
                           labelText: "Expense Description:",
                           labelStyle: TextStyle(
                               fontSize: 18.0,
                               color: Colors.black,
                               fontWeight: FontWeight.bold),

                          ),
                       ),

                       const SizedBox(height: 20.0),
                       TextField(
                         controller: _expensesController,
                         decoration: const InputDecoration(
                           labelText: 'Expense amount:',
                           labelStyle: TextStyle(
                               fontSize: 18.0,
                               color: Colors.black,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                       const SizedBox(height: 20,),
                       TextButton(
                         onPressed: _addExpense,
                         child: const Text('Add Expense'),
                       ),
                     ],
                   ),
                 ),
                ListView.builder(
                  itemCount: _expenses.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final expense = _expenses[index];

                    return Card(
                      child: ListTile(
                        title: Text(expense.expenseType), // Use the expense type from the added expense
                        trailing: Text('${expense.amount.toStringAsFixed(2)}'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20,),
                TextField(
                  controller: _totalExpensesController,
                  decoration: const InputDecoration(
                    labelText: 'Total expenses:',
                    labelStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 20,),

                TextButton(
                  onPressed: _calculateTotalExpenses,
                  child: const Text('Calculate Total Expenses'),
                ),
                const SizedBox(height: 20.0),

                const SizedBox(height: 20,),
                TextButton(
                  onPressed: () async {
                    result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);
                    if (result == null) {
                      if (kDebugMode) {
                        print("No file selected");
                      }
                    } else {
                      setState(() {});
                      for (var element in result!.files) {
                        if (kDebugMode) {
                          print(element.name);
                        }
                      }
                    }
                  },
                  child: const Text("Supported Documentation"),
                ),
                if (result != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: result?.files.length ?? 0,
                          itemBuilder: (context, index) {
                            return Text(result?.files[index].name ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold));
                          }, separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5,);
                        },)
                      ],
                    ),
                  ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await _saveExpenseData(); // Save the expense data to Firestore
                    }
                  },
                  child: const Text('Submit Expense Claim'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Expense {
  final String description;
  final double amount;
  final String expenseType;

  Expense(
    {
      required this.description,
    required this.amount,
    required this.expenseType
  });
}
