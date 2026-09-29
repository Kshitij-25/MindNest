import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

enum LegalDoc { privacy, terms }

// TEMPLATE TEXT — have a lawyer review and complete this before launch
// (Digital Personal Data Protection Act 2023, Mental Healthcare Act 2017,
// IT Act 2000 and the Telemedicine / RCI practice guidelines).
// Replace every [bracketed] placeholder.
const _updated = '[DD Month YYYY]';
const _company = '[Company legal name]';
const _address = '[Registered address, India]';
const _grievanceOfficer = '[Grievance Officer name]';

const _privacy = <(String, String)>[
  (
    'Who we are',
    'MindNest is operated by $_company, $_address ("we", "us"). This policy explains how we handle your personal data '
        'when you use the MindNest app, in line with the Digital Personal Data Protection Act, 2023.',
  ),
  (
    'What we collect',
    '• Account details: name, email address, role (client or professional), and phone number if you add one.\n'
        '• Wellbeing data you choose to enter: questionnaire answers, mood check-ins, journal entries.\n'
        '• Session data: bookings, messages with your professional, reviews you write.\n'
        '• Professionals: credentials and documents submitted for verification, practice notes about clients.\n'
        '• Device data: a push-notification token and basic technical logs.',
  ),
  (
    'Why we use it',
    'To run your account, match you with professionals, schedule and hold sessions, send notifications you’ve turned on, '
        'verify professionals, keep the service safe (including acting on reports), and meet legal obligations. '
        'We do not sell your data or use your wellbeing data for advertising.',
  ),
  (
    'Your consent',
    'We process your data on the basis of the consent you give when you create an account, and for the specific '
        'purposes above. You can withdraw consent at any time by deleting your account in Settings.',
  ),
  (
    'Who can see it',
    'Your journal and mood check-ins are visible only to you. Your professional sees the booking details, messages '
        'and anything you share with them. Professionals’ client notes are visible only to that professional. '
        'We use Google Firebase (Google LLC) to store data and deliver notifications; data may be processed outside India '
        'under Google’s safeguards.',
  ),
  (
    'How long we keep it',
    'We keep your data while your account is active. When you delete your account, your personal data is erased from '
        'the app immediately and from backups within [30] days, except records we must keep by law.',
  ),
  (
    'Your rights',
    'You can access, correct or erase your data, withdraw consent, and nominate someone to exercise these rights on '
        'your behalf. Use Settings → Data & export or Delete account, or write to us.',
  ),
  (
    'Grievances',
    'Grievance Officer: $_grievanceOfficer, $_company, $_address. Email: ${LinkConfig.supportEmail}. We respond within '
        '[30] days. If you’re not satisfied, you may complain to the Data Protection Board of India.',
  ),
  (
    'Children',
    'MindNest is for people aged 18 and over. We do not knowingly collect data from children.',
  ),
];

const _terms = <(String, String)>[
  (
    'About these terms',
    'These terms are an agreement between you and $_company. By creating an account you accept them.',
  ),
  (
    'Not an emergency service',
    'MindNest is not a crisis or emergency service. If you are in danger or thinking about harming yourself, call 112 '
        'or Tele-MANAS on 14416 immediately.',
  ),
  (
    'Eligibility',
    'You must be 18 or older to use MindNest.',
  ),
  (
    'Professionals',
    'Professionals are independent practitioners, not our employees. We check the credentials they submit before listing '
        'them, but each professional is responsible for their own advice and care, and for holding a valid registration '
        '(for example with the Rehabilitation Council of India where required).',
  ),
  (
    'Payments',
    'Sessions are paid directly to the professional at the price shown. MindNest does not process payments and is not '
        'party to that payment.',
  ),
  (
    'Acceptable use',
    'Don’t harass, threaten or impersonate anyone, share others’ private information, post unlawful or harmful content, '
        'or misuse the service. We may remove content and suspend accounts that break these rules. You can report content '
        'or block a user at any time.',
  ),
  (
    'Your content',
    'You own what you write. You give us permission to store and display it as needed to run the service. Professionals '
        'grant us permission to display articles they publish.',
  ),
  (
    'Liability',
    'The service is provided "as is". To the extent the law allows, we are not liable for indirect losses or for the '
        'advice given by professionals.',
  ),
  (
    'Ending your account',
    'You can delete your account at any time in Settings. We may suspend accounts that break these terms.',
  ),
  (
    'Law and disputes',
    'These terms are governed by the laws of India. Courts at [city] have exclusive jurisdiction.',
  ),
];

@RoutePage()
class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.doc});
  final LegalDoc doc;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (title, sections) = switch (doc) {
      LegalDoc.privacy => ('Privacy policy', _privacy),
      LegalDoc.terms => ('Terms of use', _terms),
    };
    return MnPage(
      maxWidth: 680,
      header: MnNavHeader(title: title),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 36),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Last updated $_updated', style: context.text.cap.copyWith(color: c.ink3)),
          for (final (heading, body) in sections) ...[
            const SizedBox(height: 20),
            Text(heading, style: context.text.headline),
            const SizedBox(height: 6),
            Text(body, style: context.text.callout.copyWith(color: c.ink2, height: 1.5)),
          ],
        ],
      ),
    );
  }
}
