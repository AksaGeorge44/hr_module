import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoundPage extends StatefulWidget {
  const RoundPage({super.key});

  @override
  State<RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController round = TextEditingController();

  bool _showDialog = false;
  List<String> _roundsList = [];
  String _round = 'Select Round';



  @override
  void initState() {
    super.initState();
    _fetchRounds();
  }

  Future<void> _fetchRounds() async {
    try {
      final querySnapshot = await _firestore.collection('rounds').get();
      _roundsList = querySnapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['round'].toString())
          .toList();
      if (_roundsList.isNotEmpty) {
        _round = _roundsList[0]; // Set the first item as default
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching round list: $e');
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rounds'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    const Text(
                      "Add Rounds",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 44, 159, 212),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: round,
                        decoration: const InputDecoration(
                          labelText: 'Name:',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid value.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: const Text(
                        'Add Round',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),

                    // DropdownButton<String>(
                    //   value: _round,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       _round = newValue!;
                    //     });
                    //   },
                    //
                    //   items: _roundsList.map((round) {
                    //     return DropdownMenuItem<String>(
                    //       value: round,
                    //       child: Text(round),
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildRoundList(),
          ),
        ],
      ),
    );
  }
  Widget _buildRoundList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('rounds').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final rounds = snapshot.data!.docs;

        _roundsList = rounds
            .map((round) =>
            (round.data() as Map<String, dynamic>)['round'].toString())
            .toList();

        if (_roundsList.isEmpty) {
          return const Center(child: Text('No list available.'));
        }

        return ListView.builder(
          itemCount: rounds.length,
          itemBuilder: (context, index) {
            final roundData = rounds[index].data() as Map<String, dynamic>;
            final roundName = roundData['round'] ?? '';
            final createdAt = roundData['createdAt']?.toDate() ?? DateTime.now();

            return ListTile(
              title: Text(roundName),
              subtitle: Text('${_formatDate(createdAt)}'),
              trailing: GestureDetector(
                onTap: () {
                  _deleteRound(roundName);

                  // Remove the item from the list.
                  setState(() {
                    rounds.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete,color: Colors.red,),
              ),
            );
          },
        );
      },
    );
  }
  Future<void> _deleteRound(String roundName) async {
    try {
      await _firestore.collection('rounds').where('round', isEqualTo: roundName).get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting list: $e');
      }
    }
  }


  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('dd-MM-yyyy    HH:mm').format(date);
    return formattedDate;
  }



  void _submitForm() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      try {
        await _firestore.collection('rounds').add({
          'round': round.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        _showDialog = true;
        if (_showDialog) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Round added'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      clearForm();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        setState(() {});
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    }
  }





  void clearForm() {
    round.clear();
  }
}


