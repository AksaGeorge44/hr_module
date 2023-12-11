import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static Future<void> sendReminderEmail({
    required String recipientEmail,
    required String candidateName,
    required String interviewDate,
    required String interviewTime,
    required String position,
  }) async {
    final smtpServer = gmail('aksageorge97@gmail.com', 'Sujageorge44*'); // Replace with your email and password

    final message = Message()
      ..from = const Address('aksageorge97@gmail.com', 'Aksa George') // Replace with your email and name
      ..recipients.add(recipientEmail)
      ..subject = 'Interview Reminder for $candidateName'
      ..text = '''
Hello $candidateName,

This is a reminder for your interview scheduled on $interviewDate at $interviewTime for the position of $position.

Best regards,
Your Name
      ''';

    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Message sent to $recipientEmail: ${sendReport.toString()}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Message not sent to $recipientEmail. Error: $e');
      }
    }
  }
}
