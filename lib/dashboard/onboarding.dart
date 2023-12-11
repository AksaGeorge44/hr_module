import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnboardingChecklistScreen extends StatefulWidget {
  const OnboardingChecklistScreen({super.key});

  @override
  State<OnboardingChecklistScreen> createState() =>
      _OnboardingChecklistScreenState();
}

class _OnboardingChecklistScreenState extends State<OnboardingChecklistScreen> {
  final List<ChecklistItem> firstDayChecklistItems = [
    ChecklistItem(
        title: "Send a welcome email or letter to the new employee",
        completed: false),
    ChecklistItem(
        title:
            "Provide the employee with essential information, including start date, time, location, dress code, and any required documentation.",
        completed: false),
    ChecklistItem(
        title:
            "Prepare the employee's workspace, including a computer, phone, and necessary supplies.",
        completed: false),
    ChecklistItem(
        title:
            "Request necessary access to systems and tools, such as email, HR software, and security access.",
        completed: false),
    ChecklistItem(
        title: "Schedule an orientation session for the new employee.",
        completed: false),
    ChecklistItem(
        title:
            "Ensure that all required paperwork is ready, such as tax forms, employment agreements, and benefits documentation.",
        completed: false),
  ];
  final List<ChecklistItem> firstWeekChecklistItems = [
    ChecklistItem(
        title: "Review the company's mission, vision, and values.",
        completed: false),
    ChecklistItem(
        title: "Provide an overview of the HR module and its features.",
        completed: false),
    ChecklistItem(
        title:
            "Complete necessary paperwork, including tax forms and company policies acknowledgment.",
        completed: false),
    ChecklistItem(
        title:
            "Provide login credentials for the HR module and other relevant systems.",
        completed: false),
    ChecklistItem(
        title: "Schedule one-on-one meetings with key team members or mentors.",
        completed: false),
    ChecklistItem(
        title: "Review the company's code of conduct and expectations.",
        completed: false),
  ];
  final List<ChecklistItem> firstMonthChecklistItems = [
    ChecklistItem(
        title:
            "Complete an orientation program, covering company culture, policies, and procedures.",
        completed: false),
    ChecklistItem(
        title: "Review the employee's job description and responsibilities.",
        completed: false),
    ChecklistItem(
        title:
            "Provide training on how to use the HR module, including time tracking, leave requests, and accessing personal information.",
        completed: false),
    ChecklistItem(
        title: "Discuss performance expectations and goals.", completed: false),
    ChecklistItem(
        title:
            "Explain the benefits and perks offered by the company, including health insurance, retirement plans, and any other benefits.",
        completed: false),
  ];
  final List<ChecklistItem> ongoingChecklistItems = [
    ChecklistItem(
        title:
            "Schedule regular check-ins with the new employee to address any questions or concerns.",
        completed: false),
    ChecklistItem(
        title: "Complete any required training sessions or courses.",
        completed: false),
    ChecklistItem(
        title: "Complete any required training sessions or courses.",
        completed: false),
    ChecklistItem(
        title:
            "Conduct a performance review and set clear goals for the first quarter.",
        completed: false),
    ChecklistItem(
        title:
            "Encourage the employee to provide feedback on their onboarding experience.",
        completed: false),
  ];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadChecklistItems();
  }

  Future<void> loadChecklistItems() async {
    await loadChecklistItemsForType(
        'firstDayChecklist', firstDayChecklistItems);
    await loadChecklistItemsForType(
        'firstWeekChecklist', firstWeekChecklistItems);
    await loadChecklistItemsForType(
        'firstMonthChecklist', firstMonthChecklistItems);
    await loadChecklistItemsForType('ongoingChecklist', ongoingChecklistItems);
  }

  Future<void> loadChecklistItemsForType(
      String collectionName, List<ChecklistItem> checklistItems) async {
    final QuerySnapshot querySnapshot =
        await firestore.collection(collectionName).get();
    checklistItems.clear();
    querySnapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final title = data['title'] as String;
      final completed = data['completed'] as bool;
      checklistItems.add(ChecklistItem(title: title, completed: completed));
    });
  }

  Future<void> updateChecklistItem(
      ChecklistItem item, String collectionName) async {
    await firestore.collection(collectionName).doc(item.title).set({
      'title': item.title,
      'completed': item.completed,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding Checklist"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Before the Employee's First Day:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: firstDayChecklistItems.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(firstDayChecklistItems[index].title),
                  value: firstDayChecklistItems[index].completed,
                  onChanged: (value) {
                    setState(() {
                      firstDayChecklistItems[index].completed = value!;
                      updateChecklistItem(
                        firstDayChecklistItems[index],
                        'firstDayChecklist',
                      );
                    });
                  },
                  secondary: firstDayChecklistItems[index].completed
                      ? const Icon(Icons.check, color: Colors.green) // Checkmark icon when completed
                      : null, // Null when not completed
                );

              },
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "First Day of Employment:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: firstWeekChecklistItems.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(firstWeekChecklistItems[index].title),
                  value: firstWeekChecklistItems[index].completed,
                  onChanged: (value) {
                    setState(() {
                      firstWeekChecklistItems[index].completed = value!;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "First Week:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: firstMonthChecklistItems.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(firstMonthChecklistItems[index].title),
                  value: firstMonthChecklistItems[index].completed,
                  onChanged: (value) {
                    setState(() {
                      firstDayChecklistItems[index].completed = value!;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Ongoing:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: ongoingChecklistItems.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(ongoingChecklistItems[index].title),
                  value: ongoingChecklistItems[index].completed,
                  onChanged: (value) {
                    setState(() {
                      ongoingChecklistItems[index].completed = value!;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class ChecklistItem {
  final String title;
  bool completed;

  ChecklistItem({required this.title, required this.completed});
}
