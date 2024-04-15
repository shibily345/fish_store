import 'package:betta_store/core/utils/widgets/spaces.dart';
import 'package:betta_store/core/utils/widgets/text.dart';
import 'package:flutter/material.dart';

class TermsAndPolicyPage extends StatelessWidget {
  const TermsAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy TOS"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bigSpace,
            textWidget(
                text: "Terms of services",
                fontSize: 20,
                color: Theme.of(context).indicatorColor,
                fontWeight: FontWeight.bold),
            smallSpace,
            for (String section in termsOfServiceContent)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SectionText(section),
              ),
            bigSpace,
            textWidget(
                text: "Privecy policies",
                fontSize: 20,
                color: Theme.of(context).indicatorColor,
                fontWeight: FontWeight.bold),
            smallSpace,
            for (String section in privacyPolicyContent)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SectionText(section),
              ),
          ],
        ),
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  final String text;

  const SectionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}

const List<String> termsOfServiceContent = [
  '1. Acceptance of Terms\n \nBy using the BettaStore mobile application, you agree to comply with and be bound by these terms and conditions.',
  '2. Account Registration\n \nTo use certain features of the app, you may be required to register for an account. You are responsible for maintaining the confidentiality of your account information.',
  '3. User Conduct\n \nYou agree not to engage in any conduct that may hinder the operation of the app, including but not limited to, violating any applicable laws or regulations.',
  '4. Purchases\n \nBettaStore allows you to purchase a variety of aquarium fishes, plants, feeds, and other related products. By making a purchase, you agree to pay the specified amount for the selected items.',
  '5. Selling Products\n \nUsers may have the option to sell products on BettaStore. Sellers are responsible for providing accurate product information and fulfilling orders promptly.',
  '6. Intellectual Property\n \nAll content and materials available on BettaStore, including but not limited to logos, text, images, and software, are the property of BettaStore and are protected by applicable intellectual property laws.',
  '7. Termination\n \nBettaStore reserves the right to terminate or suspend your account at its discretion, without prior notice, for any violation of these terms.',
  '8. Disclaimer of Warranties\n \nBettaStore is provided "as is" without any warranties, expressed or implied. BettaStore does not guarantee the accuracy, completeness, or reliability of any content.',
  '9. Limitation of Liability\n \nIn no event shall BettaStore be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with the use of BettaStore.',
];

const List<String> privacyPolicyContent = [
  '1. Information Collection\n \nBettaStore may collect personal information such as names, addresses, and payment details for the purpose of processing orders and improving user experience.',
  '2. Information Usage\n \nCollected information may be used to process transactions, personalize user experience, and send periodic emails regarding orders and promotions.',
  '3. Security\n \nBettaStore employs industry-standard security measures to protect the confidentiality of user information.',
  '4. Third-Party Services\n \nBettaStore may utilize third-party services for payment processing and analytics. These services have their own privacy policies, and users are encouraged to review them.',
  '5. Cookies\n \nThe app may use cookies to enhance user experience. Users can control cookie preferences through their browser settings.',
  '6. Changes to Privacy Policy\n \nBettaStore reserves the right to update this privacy policy at any time. Users will be notified of any changes.',
  '7. Contact Information\n \nFor questions or concerns about the Terms of Service or Privacy Policy, please contact BettaStore at bettast0re.bs@gmail.com.',
];
