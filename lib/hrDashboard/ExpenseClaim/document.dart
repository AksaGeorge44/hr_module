import 'package:flutter/material.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
      ),
      body:  const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Center(
                child: Text("Expense Claim Form Documentation",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Text("Purpose",style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              Text("The expense claim form is used by employees to request reimbursement for business-related expenses they have paid for out of their own pockets"),
              SizedBox(height: 25,),

              Text("Who Should Use This Form?",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),

              Text("All employees who have incurred business-related expenses are required to use this form to request reimbursement."),
              SizedBox(height: 25,),

              Text("How to Use This Form?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),

              ),
              SizedBox(height: 20,),

              Text("*Complete all sections of the form accurately and legibly."),
              SizedBox(height: 20,),

              Text("*Attach copies of all receipts or other supporting documentation for your expenses."),
              SizedBox(height: 20,),

              Text("*Obtain the necessary approvals from designated managers or supervisors before submitting the form."),
              SizedBox(height: 20,),

              Text("*Submit the completed form to the Accounts Payable department for processing."),
              SizedBox(height: 20,),

              Text("*Reimbursement Process"),
              SizedBox(height: 20,),

              Text("*Upon receipt of the completed expense claim form, the Accounts Payable department will review the form and supporting documentation."),
              SizedBox(height: 20,),

              Text("*If the form is approved, the employee will be reimbursed for their eligible expenses."),
              SizedBox(height: 20,),

              Text("*If the form is not approved, the employee will be notified of the reason for non-approval."),
              SizedBox(height: 20,),

              Text("Frequently Asked Questions",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  color: Colors.blue
                ),),
              SizedBox(height: 20,),

              Text("What types of expenses are eligible for reimbursement?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),

              Text("Only business-related expenses that are necessary for the performance of your job duties are eligible for reimbursement. Examples include transportation costs, meals, accommodation, office supplies, and other costs incurred while on business trips or performing work-related tasks."),
              SizedBox(height: 20,),

              Text("What is the deadline for submitting expense claim forms?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),

              Text("Expense claim forms must be submitted within 30 days of incurring the expense."),
              SizedBox(height: 20,),

              Text("What happens if I lose my receipts?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),

              Text("If you lose your receipts, you may still be able to be reimbursed for your expenses if you have other supporting documentation, such as credit card statements or bank records."),
              SizedBox(height: 20,),

              Text("What if my expense claim form is denied?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),

              Text("If your expense claim form is denied, you will be notified of the reason for non-approval. You may be able to resubmit the form with additional supporting documentation."),
              SizedBox(height: 20,),

              Text("Who can I contact if I have questions about expense reimbursement?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),

              Text("If you have any questions about expense reimbursement, please contact the Accounts Payable department."),
              SizedBox(height: 20,),

              Text("Additional Information",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),

              Text("For more information about expense reimbursement policies, please refer to the company's employee handbook.")


            ],
          ),
        ),
      ),
    );
  }
}
