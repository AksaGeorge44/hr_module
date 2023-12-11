import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_module/dashboard/onboarding.dart';

class OnboardingChecklist extends StatelessWidget {
  const OnboardingChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: "Welcome to HR Module",
      description: "Discover powerful HR management features.",
    ),
    OnboardingItem(
      title: "Introduction to HR Module",
      description:
          "The HR module is an integral part of our ERP system, offering comprehensive tools for managing your organization's workforce. It helps in employee data management, attendance tracking, payroll, and more.",
    ),
    OnboardingItem(
      title: "User Benefits",
      description: "By using our HR module, you can experience benefits such as improved employee management, streamlined HR processes, increased efficiency, and enhanced decision-making.",
    ),
    OnboardingItem(
      title: "Manage Employees",
      description: "Effortlessly manage employee records.",
    ),
    OnboardingItem(
      title: "Track Leaves",
      description: "Keep track of employee leaves and attendance.",
    ),
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: onboardingItems.length,
        itemBuilder: (context, index) {
          return OnboardingPage(item: onboardingItems[index], isLastPage: index == onboardingItems.length - 1);
        },
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;


  OnboardingItem({required this.title, required this.description,});
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final bool isLastPage;

  const OnboardingPage({super.key, required this.item, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20.0),
          Text(item.title, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10.0),
          Text(item.description, style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
          const SizedBox(height: 30.0),
          if (isLastPage)
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const OnboardingChecklistScreen()));
              },
              child: const Text("Next"),
            ),
        ],
      ),
    );
  }
}
