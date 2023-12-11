import 'package:flutter/material.dart';
import 'package:hr_module/hrDashboard/InterviewCand/candidate.dart';
import 'package:hr_module/dashboard/widgets/circleWidget.dart';
import 'package:hr_module/dashboard/widgets/date.dart';
import 'package:hr_module/hrDashboard/hr/modules.dart';

import '../../dashboard/dashboard.dart';
import '../../dashboard/help.dart';
import '../../job/jobvaccancy.dart';
class HRDashboard extends StatefulWidget {
  const HRDashboard({super.key});

  @override
  State<HRDashboard> createState() => _HRDashboardState();
}

class _HRDashboardState extends State<HRDashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Icon(Icons.message_outlined),
          const SizedBox(width: 10,),
          const Icon(Icons.notifications),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'my profile') {
              }
              else if (value == 'account settings') {

              }
              else if(value=='candidates')
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const InterviewReminderScreen()));

                }
              else if(value=='recruiters')
                {

                }
              else if(value=='job vaccancy')
                {

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
                  value: 'my profile',
                  child: Text('My Profile'),
                ),
                const PopupMenuItem<String>(
                    value: 'account settings', child: Text("Account Settings")),
                const PopupMenuItem(
                    value:'candidates',
                    child: Text("Candidates")),

                const PopupMenuItem(
                    value:'recruiters',
                    child: Text("Recruiters")),
                const PopupMenuItem(
                    value:'job vaccancy',
                    child: Text("Job Vaccancy")),
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
        title: const Text('HR Dashboard'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                const Text(
                  'Welcome HR',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 900,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Modules()));

                }, child:const Text("Modules")),
                const SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  const JobVacanciesSection()));
                    },
                    child: const Text("Job Vaccancy")),

              ],),
            ),
            CurrentDateTimeWidget(),
            const CircularOverviewWidget(),
              const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Timing Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          ListTile(
                            leading: Icon(Icons.calendar_view_day),
                            title: Text('Mon-Fri'),
                          ),
                          ListTile(
                            leading: Icon(Icons.timer),
                            title: Text('9.00 AM - 5.45 PM'),
                          ),
                          ListTile(
                            leading: Icon(Icons.access_time_outlined),
                            title: Text('Duration:5.45 Hrs'),
                          ),
                          ListTile(
                            leading: Icon(Icons.timer),
                            title: Text('Lunch Break:35 minutes'),
                          ),
                        ],
                      ),
                    ),
                  ),
              Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Upcoming Tasks',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(Icons.assignment),
                      title: Text('Complete HR training'),
                    ),
                    ListTile(
                      leading: Icon(Icons.event),
                      title: Text('Team meeting at 2 PM'),
                    ),
                  ],
                ),
              ),
              ),
              SizedBox(height: 16),
              Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Recent Notifications',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('New leave request from Alice'),
                      subtitle: Text('2 hours ago'),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Payroll processing completed'),
                      subtitle: Text('1 day ago'),
                    ),
                  ],
                ),
              ),
              ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
