import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/dashboard/widgets/calendar.dart';
import 'package:hr_module/dashboard/widgets/drawer.dart';
import 'package:hr_module/dashboard/help.dart';
import 'package:hr_module/dashboard/widgets/integration.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../user/login.dart';
import 'widgets/dashbox.dart';
import 'widgets/kpiWidget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final List<FlSpot> revenueData = [
    const FlSpot(0, 5000),
    const FlSpot(1, 6000),
    const FlSpot(2, 5500),
    const FlSpot(3, 7000),
  ];

    Future<void> exportReport() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Sample Report Content'),
        );
      },
    ));

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/sample_report.pdf';
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());

    shareReport(file.path);
  }

  void shareReport(String filePath) {
    //Share.shareFiles([filePath], text: 'Share the report');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ERP Dashboard'),
        actions: [
          const Icon(Icons.notification_important),
          const SizedBox(width: 10,),
          IconButton(
            tooltip: "messages",
            onPressed: () {
              showNewMessagesDialog(context);
            },
            icon: const Icon(Icons.message_outlined),
          ),
          IconButton(
            tooltip: "share",
            onPressed: () {
              exportReport();
            },
            icon: const Icon(Icons.share),
          ),

          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
              }
              else if (value == 'account settings') {
              }
              else if(value=='help & support')
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HelpAndSupportWidget()));
                }
              else if (value == 'logout') {
                performLogout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Profile'),
                ),
                const PopupMenuItem<String>(
                    value: 'account settings', child: Text("Account Settings")),
                const PopupMenuItem<String>(
                  value:'help & support',

                    child: Text("Help & Support")),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Welcome', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                ],),
              const SizedBox(height: 30,),
              const Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KPIWidget(
                    label: 'Sales',
                    value: '\₹10,500',
                  ),
                  KPIWidget(
                    label: 'Revenue',
                    value: '\₹15,750',
                  ),
                  KPIWidget(
                    label: 'Expenses',
                    value: '\₹5,250',
                  ),
                  KPIWidget(
                    label: 'Production Efficiency',
                    value: '85%',
                  ),
                  KPIWidget(
                    label: 'Inventory Levels',
                    value: '2,500 units',
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 300,
                          child: LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: false),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                  color: const Color(0xff37434d),
                                  width: 1,
                                ),
                              ),
                              minX: 0,
                              maxX: 6,
                              minY: 0,
                              maxY: 6,
                              titlesData: const FlTitlesData(
                                  show: false), // Hide built-in titles
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    const FlSpot(0, 3),
                                    const FlSpot(1, 1),
                                    const FlSpot(2, 4),
                                    const FlSpot(3, 3),
                                    const FlSpot(4, 5),
                                    const FlSpot(5, 2),
                                    const FlSpot(6, 4),
                                  ],
                                  isCurved: true,
                                  color: Colors.blue,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              
              CalendarWidget(),
              const IntegrationWidget(),

              const SizedBox(height: 20,),
              const Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                     DashboardBox(
                    label: 'Users',
                    value: '167',
                  ),
                  DashboardBox(
                    label: 'Sessions',
                    value: '1,234',
                  ),
                  DashboardBox(
                    label: 'Page Views',
                    value: '8,901',
                  ),
                  DashboardBox(
                    label: 'Bounce Rate',
                    value: '25%',
                  ),
               
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showNewMessagesDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You have new messages'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.message),
                title: Text('New Message 1'),
                subtitle: Text('This is the content of the first message.'),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('New Message 2'),
                subtitle: Text('This is the content of the second message.'),
              ),
              // Add more new messages here as needed
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

void performLogout(BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) =>
        const LoginScreen(),
  ));
}



