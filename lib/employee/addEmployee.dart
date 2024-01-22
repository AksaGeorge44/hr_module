import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee>
    with SingleTickerProviderStateMixin {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController empid = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController emergencyno = TextEditingController();
  TextEditingController aadhaarno = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController bloodgroup = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController spousename = TextEditingController();
  TextEditingController workphoneNo = TextEditingController();
  TextEditingController workemail = TextEditingController();
  TextEditingController ssn = TextEditingController();
  TextEditingController joblocation = TextEditingController();
  TextEditingController dor = TextEditingController();
  TextEditingController doi = TextEditingController();
  TextEditingController doj = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController doh = TextEditingController();
  TextEditingController salaryStartDate = TextEditingController();
  TextEditingController salaryEndDate = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController othereducation = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController courseStart = TextEditingController();
  TextEditingController courseEnd = TextEditingController();
  TextEditingController college = TextEditingController();
  TextEditingController marks = TextEditingController();
  TextEditingController anyother = TextEditingController();

  bool _passwordVisible = false;

  String _selectedGender = 'Male';
  String _selectedNationality = 'India';
  String _selectedBloodgroup = 'A+';
  String _selectedStatus = 'Intern';
  String _selectedRole = 'admin';
  String _selectedShift = 'morning';
  String _selectedDepartment = 'IT';
  String _selectedMaritalStatus = 'Single';
  String _selectedState = 'Andhra Pradesh';
  String _selectedDistrict = 'Alappuzha';
  String _selectedEducation = 'PG';

  List<String> _rolesList = [];
  List<String> _departmentList = [];

  Future<void> _selectCourseStart(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        courseStart.text = formatDate(selectedDate);
      });
    }
  }

  Future<void> _selectCourseEnd(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        courseEnd.text = formatDate(selectedDate);
      });
    }
  }

  void _fetchRolesFromFirebase() async {
    final rolesQuery =
        await FirebaseFirestore.instance.collection('roles').get();
    final rolesData = rolesQuery.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    final rolesList = rolesData.map((data) => data['role'] as String).toList();

    setState(() {
      _rolesList = rolesList;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRolesFromFirebase();
    _fetchDepartments();
  }

  Future<void> _fetchDepartments() async {
    try {
      final querySnapshot = await _firestore.collection('departments').get();
      _departmentList = querySnapshot.docs
          .map((doc) =>
              (doc.data() as Map<String, dynamic>)['department'].toString())
          .toList();
      if (_departmentList.isNotEmpty) {
        department = _departmentList[0] as TextEditingController;
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

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }



  Future<void> _selectDateofJoin(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        doj.text = formatDate(selectedDate);
      });
    }
  }

  Future<void> _selectSalaryStart(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        salaryStartDate.text = formatDate(selectedDate);
      });
    }
  }

  Future<void> _selectSalaryEnd(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 50),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        salaryEndDate.text = formatDate(selectedDate);
      });
    }
  }

  Future<void> _selectDateofResign(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(currentDate.year - 50),
        lastDate: currentDate);
    if (selectedDate != null) {
      setState(() {
        dor.text = formatDate(selectedDate);
      });
    }
  }

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
        dob.text = formatDate(selectedDate);

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

  Map<String, List<String>> nationalityToStates = {
    'India': ['Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala','Madhya Pradesh',
      'Maharashtra','Manipur','Meghalaya','Mizoram','Nagaland','Odisha','Punjab','Rajasthan','Sikkim','Tamil Nadu','Telangana','Tripura','Uttar Pradesh', 'Uttarakhand', 'West Bengal'
    ],
    'Canada': [ 'Ontario','Quebec','British Columbia', 'Alberta', 'Manitoba', 'Saskatchewan',
      'Nova Scotia','New Brunswick','Newfoundland and Labrador', 'Prince Edward Island','Northwest Territories', 'Yukon','Nunavut'
    ],
    'USA': [
      'Alabama','Alaska', 'Arizona','Arkansas', 'California','Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia','Hawaii', 'Idaho','Illinois',
      'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine',  'Maryland',  'Massachusetts',  'Michigan',  'Minnesota','Mississippi','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio',
      'Oklahoma','Oregon','Pennsylvania','Rhode Island', 'South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming'
    ],
    'Russia': [
      'Moscow','Saint Petersburg','Novosibirsk','Yekaterinburg', 'Kazan','Chelyabinsk','Omsk','Samara','Nizhny Novgorod','Rostov-on-Don','Ufa','Krasnoyarsk','Voronezh','Perm','Volgograd', 'Saratov','Krasnodar', 'Tolyatti', 'Izhevsk', 'Yaroslavl',
      'Barnaul','Vladivostok', 'Irkutsk', 'Khabarovsk', 'Tyumen', 'Orenburg','Novokuznetsk', 'Kemerovo',  'Ryazan'
    ],
    'Australia': [ 'New South Wales', 'Victoria', 'Queensland', 'Western Australia', 'South Australia', 'Tasmania','Australian Capital Territory',  'Northern Territory'
    ]
  };

  Map<String, List<String>> keralaDistricts = {
    'Kerala': ['Alappuzha', 'Ernakulam','Idukki', 'Kannur', 'Kasaragod', 'Kollam', 'Kottayam', 'Kozhikode', 'Malappuram', 'Palakkad','Pathanamthitta', 'Thiruvananthapuram', 'Thrissur', 'Wayanad'
    ],
  };

  Future<void> saveDetailsToFirebase() async {
    try {
      if (fullname.text.isEmpty || password.text.isEmpty||address.text.isEmpty||empid.text.isEmpty||pincode.text.isEmpty
      ||email.text.isEmpty||uname.text.isEmpty||password.text.isEmpty||dob.text.isEmpty||phoneno.text.isEmpty||emergencyno.text.isEmpty
      
      ||aadhaarno.text.isEmpty||bloodgroup.text.isEmpty||gender.text.isEmpty||email.text.isEmpty
      ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill in all fields')),
          );
          return;
        }


      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference employeeCollection =
          firestore.collection('employees');

      Map<String, dynamic> employeeData = {
        'fullname': fullname.text,
        'address': address.text,
        'empid': empid.text,
        'pincode': pincode.text,
        'email': email.text,
        'uname': uname.text,
        'password': password.text,
        'dob': dob.text,
        'phoneno': phoneno.text,
        'emergencyno': emergencyno.text,
        'aadhaarno': aadhaarno.text,
        'bloodgrp': bloodgroup.text.isNotEmpty ? bloodgroup.text : _selectedBloodgroup,
        'gender': gender.text.isNotEmpty ? gender.text : _selectedGender,
        'district':district.text.isNotEmpty ? district.text : _selectedDistrict,
        'nationality': _selectedNationality,
        'state': _selectedState,
        'place': place.text,
        'spousename': spousename.text,
        'maritalstatus': _selectedMaritalStatus,
        'role': _selectedRole,
        'department': _selectedDepartment,
        'position': position.text,
        'salary': salary.text,
        "age": _ageController.text,
        'salary_start': salaryStartDate.text,
        'salary_end': salaryEndDate.text,
        'date_of_hire': doh.text,
        'date_of_resign': dor.text,
        'ssn': ssn.text,
        'joblocation': joblocation.text,
        'empstatus': _selectedStatus,
        'shift': _selectedShift,
        'workno': workphoneNo.text,
        'workemail': workemail.text,
        'education': _selectedEducation,
        'Education': othereducation.text,
        'course': course.text,
        'college_name': college.text,
        'course_start': courseStart.text,
        'course_end': courseEnd.text,
        'marks': marks.text,
        'any_other_certificates': anyother.text,
      };

      await employeeCollection.add(employeeData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Employee details added to Firestore.'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Employee"),),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            const SizedBox(height:20,),
            const Text(
              "Personal Details",
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 44, 159, 212),),),
            const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: fullname,
                    decoration: const InputDecoration(
                      labelText: 'Full Name:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Please enter a valid name with only letters and spaces.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    controller: empid,
                    decoration: InputDecoration(
                      labelText: "empid",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
           const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      labelText: "address",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a  value.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: TextFormField(
                    controller: pincode,
                    decoration: InputDecoration(
                      labelText: "pincode",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return 'Please enter a 6-digit number.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: phoneno,
                    decoration: InputDecoration(
                      labelText: "phoneno",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a 10-digit number.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox( width: 20,),
                Expanded(
                  child: TextFormField(
                    controller: emergencyno,
                    decoration: InputDecoration(
                      labelText: "emergencyno",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a 10-digit number.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: aadhaarno,
                    decoration: InputDecoration(
                      labelText: "aadhaarno",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                        return 'Please enter a 12-digit number.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid email address.';
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: uname,
                    decoration: InputDecoration(
                      labelText: "uname",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20,),
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
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (value.length < 8 ||
                          !RegExp(r'[0-9]').hasMatch(value) ||
                          !RegExp(r'[!@#$%^&*]').hasMatch(value)) {
                        return 'Password should contain a minimum of 8 characters, \n one number, and one special character.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dob,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth:',
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
                  ),
                ),
                const SizedBox( width: 20, ),
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
                    readOnly: false,
                  ),)],),
            const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: gender,
                    decoration: InputDecoration(
                        labelText: 'Gender:',
                        labelStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        suffixIcon: PopupMenuButton(
                          itemBuilder: (BuildContext context) =>
                              ['Male', 'Female', 'Other']
                                  .map((gender) => PopupMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),

                          onSelected: (String value) {
                            setState(() {
                              _selectedGender = value;
                              gender.text = value;
                            });
                          },
                        )),),),
                const SizedBox( width: 30, ),
                Expanded(
                  child: TextFormField(
                    controller: bloodgroup,
                    decoration: InputDecoration(
                      labelText: 'Blood Group:',
                      labelStyle: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                      suffixIcon: PopupMenuButton(
                        itemBuilder: (BuildContext context) =>
                            ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                                .map((bloodgroup) => PopupMenuItem<String>(
                                      value: bloodgroup,
                                      child: Text(bloodgroup),
                                    ))
                                .toList(),
                        onSelected: (String value) {
                          setState(() {
                            _selectedBloodgroup = value;
                            bloodgroup.text = value;
                          });
                        },
                      ),
                    ),
                  ),),],),
            const SizedBox(height:20,),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value:
                        _selectedNationality ?? nationalityToStates.keys.first,
                    onChanged: (value) {
                      setState(() {
                        _selectedNationality = value!;
                        if (nationalityToStates.containsKey(value)) {
                          _selectedState = nationalityToStates[value]!.first;
                          if (_selectedNationality == 'India' &&
                              keralaDistricts.containsKey(_selectedState)) {
                            _selectedDistrict =
                                keralaDistricts[_selectedState]!.first;
                          }
                        } else {
                          _selectedState = '';
                          _selectedDistrict = '';
                        }
                      });
                    },
                    items: nationalityToStates.keys.toList().map((nationality) {
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
                    value: _selectedState ?? '',
                    onChanged: (value) {
                      setState(() {
                        _selectedState = value!;
                        if (_selectedNationality == 'India' &&
                            keralaDistricts.containsKey(_selectedState)) {
                          _selectedDistrict =
                              keralaDistricts[_selectedState]!.first;
                        }
                      });
                    },
                    items: nationalityToStates[_selectedNationality ?? '']
                            ?.map((state) {
                          return DropdownMenuItem(
                            value: state,
                            child: Text(state),
                          );
                        }).toList() ??
                        [],
                    decoration: const InputDecoration(
                      labelText: 'State',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height:20,),
            if (_selectedNationality == 'India' &&
                keralaDistricts.containsKey(_selectedState))
              DropdownButtonFormField<String>(
                value: _selectedDistrict ?? '',
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value!;
                  });
                },
                items: keralaDistricts[_selectedState ?? '']?.map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      );
                    }).toList() ??
                    [],
                decoration: const InputDecoration(
                  labelText: 'District:',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              TextFormField(
                controller: district,
                decoration: const InputDecoration(
                  labelText: 'District:',
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid value.';
                  }
                  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return 'Please enter a valid name with only letters and spaces.';
                  }
                  return null;
                },
              ),
            const SizedBox(height:20,),
            TextFormField(
              controller: place,
              decoration: const InputDecoration(
                labelText: 'Place:',
                labelStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid value.';
                }
                if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                  return 'Please enter a valid name with only letters and spaces.';
                }
                return null;
              },
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
                'Single',
                'Married',
                'Divorced',
                'Widowed',
              ]
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Marital Status:',
                  labelStyle:
                      TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height:20,),
            TextFormField(
              controller: spousename,
              decoration: const InputDecoration(
                labelText: 'Spouse Name(if have):',
                labelStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid value.';
                }
                if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                  return 'Please enter a valid name with only letters and spaces.';
                }
                return null;
              },
            ),
            const SizedBox(height:20,),
            const Text(
              "Work Details",
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 44, 159, 212),
              ),
            ),
            const SizedBox(height:20,),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              items: _rolesList
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Role:",
                labelStyle:
                    TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height:20,),
            DropdownButtonFormField<String>(
              value: _selectedDepartment,
              items: _departmentList
                  .map((department) => DropdownMenuItem(
                        value: department,
                        child: Text(department),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDepartment = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Department:",
                labelStyle:
                    TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: position,
                    decoration: const InputDecoration(
                      labelText: 'Enter Position/Job title:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Please enter a valid name with only letters and spaces.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox( width: 17,),
                Expanded(
                  child: TextFormField(
                    controller: salary,
                    decoration: const InputDecoration(
                      labelText: 'Enter Salary:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid salary as a number.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: salaryStartDate,
                    onTap: () {
                      _selectSalaryStart(context);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Salary start:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:20,),
                Expanded(
                  child: TextFormField(
                    controller: salaryEndDate,
                    onTap: () {
                      _selectSalaryEnd(context);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Salary end:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: doj,
                    onTap: () {
                      _selectDateofJoin(context);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Date of Join:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid date.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TextFormField(
                    controller: dor,
                    onTap: () {
                      _selectDateofResign(context);
                    },
                    decoration: const InputDecoration(
                        labelText: "Date of Resign:",
                        labelStyle: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: ssn,
                    decoration: const InputDecoration(
                      labelText: 'SSN:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid SSN.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TextFormField(
                    controller: joblocation,
                    decoration: const InputDecoration(
                      labelText: 'Job Location:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid job location.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
              items:
                  ['Intern', 'Permanent', 'Part Time', 'Temporary', 'Seasonal']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
              decoration: const InputDecoration(
                labelText: 'Employee Status:',
                labelStyle: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
                value: _selectedShift,
                items: ['morning', 'evening', 'night']
                    .map((shift) =>
                        DropdownMenuItem(value: shift, child: Text(shift)))
                    .toList(),
                decoration: const InputDecoration(
                    labelText: "Shift:",
                    labelStyle:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                onChanged: (value) {
                  setState(() {
                    _selectedShift = value!;
                  });
                }),
            const SizedBox(height: 20),
            TextFormField(
              controller: workphoneNo,
              decoration: const InputDecoration(
                labelText: 'Work Phone number:',
                labelStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid phone number.';
                }
                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  return 'Please enter a 10-digit phone number.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: workemail,
              decoration: const InputDecoration(
                labelText: 'Work Email ID:',
                labelStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid email address.';
                }
                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
            ),
            const SizedBox(height:20,),
            const Text(
              "Educational Details",
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 44, 159, 212),
              ),
            ),
                      const SizedBox(height:20,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedEducation,
                    items: [
                      'PG',
                      'UG',
                      'Diploma',
                      '12',
                      '10',
                      'Other',
                    ]
                        .map((education) => DropdownMenuItem(
                              value: education,
                              child: Text(education),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedEducation = value!;
                        course.clear();
                        college.clear();
                        courseStart.clear();
                        courseEnd.clear();
                        marks.clear();
                        anyother.clear();
                      });
                    },
                    decoration: const InputDecoration(
                        labelText: "Education",
                        labelStyle: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  if (_selectedEducation == 'Other')
                    TextFormField(
                      controller: othereducation,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Enter Education',
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid value.';
                        }
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Please enter a valid name with only letters and spaces.';
                        }
                        return null;
                      },
                    ),
                              const SizedBox(height:20,),
                  TextFormField(
                    controller: course,
                    decoration: const InputDecoration(
                      labelText: 'Course:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Please enter a valid name with only letters and spaces.';
                      }
                      return null;
                    },
                  ),
                    const SizedBox(height:20,),
                  TextFormField(
                    controller: college,
                    decoration: const InputDecoration(
                      labelText: 'College /School Name:',
                      labelStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid value.';
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Please enter a valid name with only letters and spaces.';
                      }
                      return null;
                    },
                  ),
                   const SizedBox(height:20,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: courseStart,
                          onTap: () {
                            _selectCourseStart(context);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Course Start:',
                            labelStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid date.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: courseEnd,
                          onTap: () {
                            _selectCourseEnd(context);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Course End:',
                            labelStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid date.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height:20,),
                  TextFormField(
                    controller: marks,
                    decoration: const InputDecoration(
                      labelText: 'Marks (cgpa,ccpa,gpa or %):',
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
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: anyother,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Any Other Certifications?',
                      labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 83, 188, 236)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height:20,),
            ElevatedButton(
                onPressed: () {
                  saveDetailsToFirebase();
                },
                child: const Text("Submit")),
          ]),)));
  }
}
