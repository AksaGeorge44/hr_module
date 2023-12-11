import 'package:flutter/material.dart';

class AddPermissionPage extends StatefulWidget {
  const AddPermissionPage({super.key});
  @override
  State<AddPermissionPage> createState() => _AddPermissionPageState();
}
class _AddPermissionPageState extends State<AddPermissionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController permission = TextEditingController();
  bool isChecked = false;  bool isChecked1 = false;  bool isChecked2 =false; bool isChecked3 = false;bool isChecked4 =false;  bool isChecked5 = false;bool isChecked6 =  false;bool isChecked7 = false;bool isChecked8 = false; 
  bool isChecked9 = false;bool isChecked10 =false; bool isChecked11 = false; bool isChecked12 = false;  bool isChecked13 = false; bool isChecked14 = false; 
  bool isChecked15 = false;  bool isChecked16 =  false;  bool isChecked17 = false;bool isChecked18 = false;bool isChecked19 = false;  bool isChecked20 = false;   bool isChecked21 = false;bool isChecked22 = false; bool isChecked23 = false;bool isChecked24 =false; 
  bool isChecked25 = false;bool isChecked26 =false;  bool isChecked27 = false;bool isChecked28 = false; bool isChecked29 = false; bool isChecked30 =false; 
  bool isChecked31 = false; bool isChecked32 = false;   bool isChecked33 = false;  bool isChecked34 =  false; bool isChecked35 = false; bool isChecked36 = false; bool isChecked37 = false; bool isChecked38 = false; bool isChecked39 = false;
  bool isChecked40 = false; bool isChecked41 = false; bool isChecked42 =false; bool isChecked43 = false; bool isChecked44 =  false;  bool isChecked45 = false;bool isChecked46 =false; bool isChecked47 = false;
  bool isChecked48 =  false;  bool isChecked49 = false; bool isChecked50 = false;  bool isChecked51 = false; bool isChecked52 = false;  bool isChecked53 = false;bool isChecked54 =false;
  bool isChecked55 = false; bool isChecked56 =false;bool isChecked57 = false;  bool isChecked58 =false; bool isChecked59 = false; bool isChecked60 =false;
  bool isChecked61 = false; bool isChecked62 =false; bool isChecked63 = false; bool isChecked64 =false;bool isChecked65 = false; bool isChecked66 =false;
  bool isChecked67 = false;bool isChecked68 =false; bool isChecked69 = false; bool isChecked70 =false;bool isChecked71 = false;bool isChecked72 =false;bool isChecked73 = false;
  bool isChecked74 =false;bool isChecked75 = false; bool isChecked76 =false; bool isChecked77 = false;bool isChecked78 =false;
  bool isChecked79 = false;bool isChecked80 =false; bool isChecked81 = false;bool isChecked82 =false;  bool isChecked83 = false; bool isChecked84 =false;
  bool isChecked85 = false;bool isChecked86 =false;bool isChecked87 = false; bool isChecked88 =false; bool isChecked89 = false; bool isChecked90 =false;
  bool isChecked91 = false;bool isChecked92 =false;bool isChecked93 = false;bool isChecked94 =false;bool isChecked95 = false;bool isChecked96 =false;bool isChecked97 = false;
  bool isChecked98 =false;bool isChecked99 = false;bool isChecked100 =false; bool isChecked101 = false;
  bool isChecked102 =false; bool isChecked105 = false; bool isChecked103 =false;bool isChecked104 = false; bool isChecked110 =false;
  bool isChecked106 = false;bool isChecked107 =false; bool isChecked108 = false; bool isChecked109 =false;bool isChecked111 = false;bool isChecked112 =false;bool isChecked113 = false;bool isChecked114 =false;bool isChecked115 = false;bool isChecked116 =false;bool isChecked117 = false;
  bool isChecked118 =false;bool isChecked119 = false;bool isChecked200 =false;bool isChecked201 = false;bool isChecked202 =false;  bool isChecked203 = false;bool isChecked204 =false;bool isChecked205 = false;
  bool isChecked206 =false;bool isChecked207 = false;bool isChecked208 =false;bool isChecked209 = false; bool isChecked210 =false;
  bool isChecked211 = false;bool isChecked212 =false; bool isChecked213 = false;bool isChecked214 =false;bool isChecked215 = false;bool isChecked216 =false;bool isChecked217 = false;
  bool isChecked218 =false;bool isChecked219 = false;bool isChecked220 =false;bool isChecked221 = false;bool isChecked222 =false; 
  bool isChecked223 = false;bool isChecked224 =false;bool isChecked225 = false;bool isChecked226 =false;bool isChecked227 = false;bool isChecked228 =false;
  bool isChecked229 = false;bool isChecked230 =false;bool isChecked231 = false;bool isChecked232 =false;bool isChecked233 = false;
  bool isChecked234 =false; bool isChecked235 = false; bool isChecked236 = false;  bool isChecked237 = false; bool isChecked238 =false; bool isChecked239 = false; bool isChecked240 =false; 
  bool isChecked241 = false; bool isChecked242 =false;  bool isChecked243 = false; bool isChecked244 =false; bool isChecked245 = false; bool isChecked246 =false;   bool isChecked247 = false;bool isChecked248 =false; bool isChecked249 = false;bool isChecked250 = false; bool isChecked251 = false;  bool isChecked252 =false;  bool isChecked253 = false;bool isChecked254 = false; bool isChecked255 = false;
  bool isChecked256 =  false;  bool isChecked257 = false;bool isChecked258 = false;  bool isChecked259 = false; bool isChecked260 =false; bool isChecked261 = false; bool isChecked262 =  false; bool isChecked263 = false; bool isChecked264 =  false;  bool isChecked265 = false;bool isChecked266 =false; bool isChecked267 = false;bool isChecked268 =false; bool isChecked269=false;bool isChecked270 =false; bool isChecked271 = false;bool isChecked272 =  false; bool isChecked273 = false; bool isChecked274 =false; 
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Permissions'),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              const Text("Add New Permissions",
              style: TextStyle(fontSize: 20),),
              const SizedBox(height: 40,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-rolePermission'),
                    value: isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked1 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-rolePermission'),
                    value: isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-rolePermission'),
                    value: isChecked3,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked3 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-rolePermission'),
                    value: isChecked4,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked4 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-rolePermission'),
                    value: isChecked5,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked5 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-transaction'),
                    value: isChecked6,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked6 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-transaction'),
                    value: isChecked7,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked7 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-transaction'),
                    value: isChecked8,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked8 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-tranasaction'),
                    value: isChecked9,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked9 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-tranasaction'),
                    value: isChecked10,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked10 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-Permission'),
                    value: isChecked11,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked11 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-Permission'),
                    value: isChecked12,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked12 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-Permission'),
                    value: isChecked13,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked13 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-Permission'),
                    value: isChecked14,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked14 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-Permission'),
                    value: isChecked15,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked15 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-dashboard'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-dashboard'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-dashboard'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-dashboard'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-dashboard'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });
                    },),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-user'),
                    value: isChecked21,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked21 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-user'),
                    value: isChecked22,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked22 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-user'),
                    value: isChecked23,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked23 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-user'),
                    value: isChecked24,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked24 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-user'),
                    value: isChecked25,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked25 = value!;
                      });
                    },),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-role'),
                    value: isChecked26,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked26 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-role'),
                    value: isChecked27,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked27 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-role'),
                    value: isChecked28,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked28 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-role'),
                    value: isChecked29,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked29 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-role'),
                    value: isChecked30,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked30 = value!;
                      });},),
                ],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-designation'),
                    value: isChecked31,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked31 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-designation'),
                    value: isChecked32,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked32 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-designation'),
                    value: isChecked33,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked33 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-designation'),
                    value: isChecked34,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked34 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-designation'),
                    value: isChecked35,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked35 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-account'),
                    value: isChecked36,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked36 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-account'),
                    value: isChecked37,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked37 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-account'),
                    value: isChecked38,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked38 = value!;
                      });},
                  ),
                  CheckboxListTile(
                    title: const Text('update-account'),
                    value: isChecked39,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked39 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-account'),
                    value: isChecked40,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked40 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-email'),
                    value: isChecked41,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked41 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-email'),
                    value: isChecked42,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked42 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-email'),
                    value: isChecked43,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked43 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-email'),
                    value: isChecked44,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked44 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-email'),
                    value: isChecked45,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked45 = value!;
                      });
                    },),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-setting'),
                    value: isChecked46,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked46 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-setting'),
                    value: isChecked47,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked47 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-setting'),
                    value: isChecked48,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked48 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-setting'),
                    value: isChecked49,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked49 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-setting'),
                    value: isChecked50,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked50 = value!;
                      });},),
                ],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-attendance'),
                    value: isChecked51,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked51 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-attendance'),
                    value: isChecked52,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked52 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-attendance'),
                    value: isChecked53,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked53 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-attendance'),
                    value: isChecked54,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked54 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-attendance'),
                    value: isChecked55,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked55 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-department'),
                    value: isChecked56,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked56 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-department'),
                    value: isChecked57,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked57 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-department'),
                    value: isChecked58,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked58 = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('update-department'),
                    value: isChecked59,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked59 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-department'),
                    value: isChecked60,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked60 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-education'),
                    value: isChecked61,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked61= value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-education'),
                    value: isChecked62,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked62 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-education'),
                    value: isChecked63,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked63 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-education'),
                    value: isChecked64,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked64 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-education'),
                    value: isChecked65,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked66 = value!;
                      });
                    },),
                ],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-payroll'),
                    value: isChecked67,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked67 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-payroll'),
                    value: isChecked68,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked68 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-payroll'),
                    value: isChecked69,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked69 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-payroll'),
                    value: isChecked70,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked70 = value!;
                      });},),

                  CheckboxListTile(
                    title: const Text('delete-payroll'),
                    value: isChecked71,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked71 = value!;
                      });
                    },),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-shift'),
                    value: isChecked72,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked72 = value!;
                      });
                    }),
                  CheckboxListTile(
                    title: const Text('readAll-shift'),
                    value: isChecked73,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked73 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-shift'),
                    value: isChecked74,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked74 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-shift'),
                    value: isChecked75,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked75 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-shift'),
                    value: isChecked76,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked76 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-leaveApplication'),
                    value: isChecked77,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked77 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-leaveApplication'),
                    value: isChecked78,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked78 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-leaveApplication'),
                    value: isChecked79,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked79 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-leaveApplication'),
                    value: isChecked80,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked80 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-leaveApplication'),
                    value: isChecked81,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked81 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-announcement'),
                    value: isChecked82,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked82 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-announcement'),
                    value: isChecked83,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked83 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-announcement'),
                    value: isChecked84,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked84 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-announcement'),
                    value: isChecked85,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked85 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-announcement'),
                    value: isChecked86,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked86 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-employmentStatus'),
                    value: isChecked90,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-employmentStatus'),
                    value: isChecked91,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-employmentStatus'),
                    value: isChecked92,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked92 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-employmentStatus'),
                    value: isChecked93,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked93 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-employmentStatus'),
                    value: isChecked94,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked94 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-salaryHistory'),
                    value: isChecked95,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked95 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-salaryHistory'),
                    value: isChecked96,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked96 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-salaryHistory'),
                    value: isChecked97,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked97 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-salaryHistory'),
                    value: isChecked98,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked98 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-salaryHistory'),
                    value: isChecked99,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked99 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-designationHistory'),
                    value: isChecked100,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked100 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-designationHistory'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-designationHistory'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-designationHistory'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-designationHistory'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-award'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-award'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-award'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-award'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-award'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-awardHistory'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-awardHistory'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-awardHistory'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-awardHistory'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-awardHistory'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-file'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-file'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-file'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-file'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-file'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-leavePolicy'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-leavePolicy'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-leavePolicy'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-leavePolicy'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-leavePolicy'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-weeklyHoliday'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-weeklyHoliday'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-weeklyHoliday'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-weeklyHoliday'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-weeklyHoliday'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-publicHoliday'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-publicHoliday'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-publicHoliday'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-publicHoliday'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-publicHoliday'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-project'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-project'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-project'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-project'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-project'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-milestone'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-milestone'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-milestone'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-milestone'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-milestone'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-task'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-task'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-task'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-task'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-task'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-projectTeam'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-projectTeam'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-projectTeam'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},
                  ), CheckboxListTile(
                    title: const Text('update-projectTeam'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-projectTeam'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},
                  ),],
              ),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-taskDependency'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-taskDependency'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-taskDependency'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-taskDependency'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-taskDependency'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},
                  ),
                ],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-taskStatus'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-taskStatus'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-taskStatus'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-taskStatus'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-taskStatus'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });
                    },),
                ],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-taskTime'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-taskTime'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},
                  ), CheckboxListTile(
                    title: const Text('readSingle-taskTime'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-taskTime'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-taskTime'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),
                ],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-priority'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-priority'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-priority'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-priority'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-priority'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},
                  ),],),
              const Divider(color: Colors.black,),
              Column(
                children: [
                  CheckboxListTile(
                    title: const Text('create-assignedTask'),
                    value: isChecked16,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked16 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readAll-assignedTask'),
                    value: isChecked17,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked17 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('readSingle-assignedTask'),
                    value: isChecked18,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked18 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('update-assignedTask'),
                    value: isChecked19,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked19 = value!;
                      });},),
                  CheckboxListTile(
                    title: const Text('delete-assignedTask'),
                    value: isChecked20,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked20 = value!;
                      });},),
                ],),],
          ),
        ),
      ),
    );
  }
  @override
  List<Object?> get props => [_formKey, permission, isChecked];
}
