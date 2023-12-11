import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPerson extends StatefulWidget {
  final String employeeId; // Pass the employee ID to this page

  const EditPerson({super.key, required this.employeeId});

  @override
  _EditPersonState createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {
    Map<String, List<String>> nationalityToStates = {
  'India': ['Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal'],
  'Canada': ['Ontario', 'Quebec', 'British Columbia', 'Alberta', 'Manitoba', 'Saskatchewan', 'Nova Scotia', 'New Brunswick', 'Newfoundland and Labrador', 'Prince Edward Island', 'Northwest Territories', 'Yukon', 'Nunavut'],
  'USA': ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'],
  'Russia': ['Moscow', 'Saint Petersburg', 'Novosibirsk', 'Yekaterinburg', 'Kazan', 'Chelyabinsk', 'Omsk', 'Samara', 'Nizhny Novgorod', 'Rostov-on-Don', 'Ufa', 'Krasnoyarsk', 'Voronezh', 'Perm', 'Volgograd', 'Saratov', 'Krasnodar', 'Tolyatti', 'Izhevsk', 'Yaroslavl', 'Barnaul', 'Vladivostok', 'Irkutsk', 'Khabarovsk', 'Tyumen', 'Orenburg', 'Novokuznetsk', 'Kemerovo', 'Ryazan'],
  'Australia': ['New South Wales', 'Victoria', 'Queensland', 'Western Australia', 'South Australia', 'Tasmania', 'Australian Capital Territory', 'Northern Territory']
};

Map<String, List<String>> keralaDistricts = {
  'Kerala': ['Alappuzha', 'Ernakulam', 'Idukki', 'Kannur', 'Kasaragod', 'Kollam', 'Kottayam', 'Kozhikode', 'Malappuram', 'Palakkad', 'Pathanamthitta', 'Thiruvananthapuram', 'Thrissur', 'Wayanad'],
};
  void _updateEmployeeData() {
    DocumentReference employeeRef =
        _firestore.collection('employees').doc(widget.employeeId);

    Map<String, dynamic> updatedData = {
      'full_name': fullNameController.text,
      'employee_id': empIdController.text,
      'address': _addressController.text,
      'pincode': _pincodeController.text,
      'phone_no': _phoneNoController.text,
      'emergency_no': _emergencyNoController.text,
      'aadhaar_no': _aadhaarNoController.text,
      'email': _emailController.text,
      'username': username.text,
      'password': password.text,
      'dob': _dobController.text,
      'age': _ageController.text,
      'gender': _selectedGender,
      'blood_group': _selectedBloodgroup,
      'nationality': _selectedNationality,
      'state': _selectedState,
      'district': _selectedDistrict,
      'place': place.text,
      'marital_status': _selectedMaritalStatus,
      'spouse_name': _spouseNameController.text,

    };

    employeeRef.update(updatedData).then((value) {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Employee data updated successfully'),
      ));
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating employee data: $error'),
      ));
    });
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emergencyNoController = TextEditingController();
  final TextEditingController _aadhaarNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController place = TextEditingController();
  String _selectedNationality = 'India';

  late String _selectedGender;

  String _selectedBloodgroup = 'A+';
  String _selectedMaritalStatus = 'Single';
  String _selectedState = 'Andhra Pradesh';
  String _selectedDistrict = 'Alappuzha';
  bool _passwordVisible = false; // Flag to control password visibility


  void _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 100),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        _dobController.text = formatDate(selectedDate);

        final DateTime now = DateTime.now();
        final int age = now.year - selectedDate.year;
        if (now.month < selectedDate.month ||
            (now.month == selectedDate.month && now.day < selectedDate.day)) {
          _ageController.text = (age - 1).toString();
        } else {
          _ageController.text = age.toString();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
      _selectedGender = 'Male';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Employee Details"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot>(
            future:
                _firestore.collection('employees').doc(widget.employeeId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.hasData) {
                Map<String, dynamic> employeeData =
                    snapshot.data!.data() as Map<String, dynamic>;
                fullNameController.text = employeeData['full_name'];
                empIdController.text = employeeData['employee_id'];
                _addressController.text = employeeData['address'];
                _pincodeController.text = employeeData['pincode'];
                _phoneNoController.text = employeeData['phone_no'];
                _emergencyNoController.text = employeeData['emergency_no'];
                _aadhaarNoController.text = employeeData['aadhaar_no'];
                _emailController.text = employeeData['email'];
                username.text = employeeData['username'];
                password.text = employeeData['password'];
                _dobController.text = employeeData['dob'] ?? ''; // Set the value or an empty string if it's null
                _ageController.text = employeeData['age'];
                _selectedGender = employeeData['gender'];
                _selectedBloodgroup = employeeData['blood_group'];
                _selectedNationality = employeeData['nationality'];
                _selectedState = employeeData['state'];
                _selectedDistrict = employeeData['district'];
                place.text = employeeData['place'];
                _selectedMaritalStatus = employeeData['marital_status'];
                _spouseNameController.text = employeeData['spouse_name'];


                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Personal Details",
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: fullNameController,
                        decoration:
                            const InputDecoration(labelText: 'Full Name'),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: empIdController,
                        decoration: const InputDecoration(labelText: 'Emp ID'),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _addressController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Address:',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      TextFormField(
                        controller: _pincodeController,
                        decoration: const InputDecoration(
                          labelText: 'Pincode:',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phoneNoController,
                              decoration: const InputDecoration(
                                labelText: 'Phone number:',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 13,),
                          Expanded(
                            child: TextFormField(
                              controller: _emergencyNoController,
                              decoration: const InputDecoration(
                                labelText: 'Emergency Number:',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 25,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _aadhaarNoController,
                              decoration: const InputDecoration(
                                labelText: 'Aadhaar Number:',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 13,),
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email ID:',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 17,),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: username,
                              decoration: const InputDecoration(
                                labelText: 'Username:',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 13,),
                          Expanded(
                            child: TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                labelText: 'Password:',
                                labelStyle: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText:
                                  !_passwordVisible, // Show/hide password based on _passwordVisible
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 17,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _dobController,
                              // onTap: () {
                              //   _selectDate(
                              //       context); // Open a date picker dialog
                              // },
                              decoration: const InputDecoration(
                                labelText: 'Date of Birth:',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        
                          const SizedBox(width: 13,),
                          Expanded(
                            child: TextFormField(
                              controller: _ageController,
                              decoration: const InputDecoration(
                                labelText: 'Age:',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a  value.';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.number,
                              readOnly: false, // Prevent manual editing
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 35,),
                      DropdownButtonFormField<String?>(
                        value: _selectedGender,
                          onChanged: (String? newValue) { // Change the type of newValue
                        setState(() {
                              _selectedGender = newValue!;
                             });
                                },
                          items: ['Male', 'Female', 'Other'].map((gender) {
                          return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                           );
                       }).toList(),
                         decoration: const InputDecoration(
                          labelText: 'Gender',
                           labelStyle: TextStyle(
                            fontSize: 23,
                             fontWeight: FontWeight.bold,
                              ),
                                  ),
                                  ),
                      const SizedBox(height: 30,),
                      DropdownButtonFormField<String>(
                        value: _selectedBloodgroup,
                        onChanged: (value) {
                          setState(() {
                            _selectedBloodgroup = value!;
                          });
                        },
                        items: [
                          'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'
                        ]
                            .map((bloodgroup) => DropdownMenuItem(
                                value: bloodgroup, child: Text(bloodgroup)))
                            .toList(),
                        decoration: const InputDecoration(
                            labelText: "Blood Group",
                            labelStyle: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold)),
                      ),

                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedNationality,
                              onChanged: (value) {
                                setState(() {
                                  _selectedNationality = value!;
                                  // Set the default state based on the selected nationality
                                  if (nationalityToStates.containsKey(value)) {
                                    _selectedState =
                                        nationalityToStates[value]!.first;
                                    // Set the default district if it's India and the selected state has districts
                                    if (_selectedNationality == 'India' &&
                                        keralaDistricts
                                            .containsKey(_selectedState)) {
                                      _selectedDistrict =
                                          keralaDistricts[_selectedState]!
                                              .first;
                                    }
                                  } else {
                                    _selectedState = '';
                                    _selectedDistrict = '';
                                  }
                                });
                              },
                              items: nationalityToStates.keys
                                  .toList()
                                  .map((nationality) {
                                return DropdownMenuItem(
                                  value: nationality,
                                  child: Text(nationality),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Country',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 13,),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value:
                                  _selectedState ?? '', // Set a default value
                              onChanged: (value) {
                                setState(() {
                                  _selectedState = value!;
                                  // Set the default district if it's India and the selected state has districts
                                  if (_selectedNationality == 'India' &&
                                      keralaDistricts
                                          .containsKey(_selectedState)) {
                                    _selectedDistrict =
                                        keralaDistricts[_selectedState]!.first;
                                  }
                                });
                              },
                              items: nationalityToStates[
                                          _selectedNationality ?? '']
                                      ?.map((state) {
                                    return DropdownMenuItem(
                                      value: state,
                                      child: Text(state),
                                    );
                                  }).toList() ??
                                  [], // Use an empty list if the items are null
                              decoration: const InputDecoration(
                                labelText: 'State',
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Display the first district dropdown (if applicable)
                          )
                        ],
                      ),
                       const SizedBox(height: 20,),
                     if (_selectedNationality == 'India' &&
                    keralaDistricts.containsKey(_selectedState))
                  DropdownButtonFormField<String>(
                    value: _selectedDistrict ?? '', // Set a default value
                    onChanged: (value) {
                      setState(() {
                        _selectedDistrict = value!;
                      });
                    },
                    items:
                        keralaDistricts[_selectedState ?? '']?.map((district) {
                              return DropdownMenuItem(
                                value: district,
                                child: Text(district),
                              );
                            }).toList() ??
                            [], // Use an empty list if the items are null
                    decoration: const InputDecoration(
                      labelText: 'District',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: place,
                        decoration: const InputDecoration(
                          labelText: 'Place:',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      DropdownButtonFormField<String>(
                        value: _selectedMaritalStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedMaritalStatus = value!;
                          });
                        },
                        items: [
                          'Single', 'Married', 'Divorced', 'Widowed',
                        ]
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                        decoration: const InputDecoration(
                            labelText: 'Marital Status:',
                            labelStyle: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _spouseNameController,
                        decoration: const InputDecoration(
                          labelText: 'Spouse Name(if have):',
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          _updateEmployeeData();
                        },
                        child: const Text('Save Changes'),
                      ),
                    ],
                  ),
                );
              }
              return const Text("No data available");
            },
          ),
        ),
      ),
    );
  }
}
