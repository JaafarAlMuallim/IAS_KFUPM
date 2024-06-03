import 'package:flutter/material.dart';
import 'package:ias322_project/models/advice_struct.dart';
import 'package:ias322_project/widgets/bottom_navbar.dart';
import 'package:ias322_project/widgets/custom_card.dart';

class AdviceScreen extends StatelessWidget {
  const AdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.background,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: ThemeData.light().colorScheme.primaryContainer,
        elevation: 4.0,
        title: Center(
          child: Text(
            'نصائح عامة',
            style: TextStyle(
              color: ThemeData.light().colorScheme.onBackground,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: Advices.advices
                .map((advice) => CustomCard(
                    title: advice.title,
                    paragraph: advice.paragraph,
                    icon: advice.icon))
                .toList(),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
