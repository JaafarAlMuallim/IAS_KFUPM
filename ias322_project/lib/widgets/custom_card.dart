import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String paragraph;

  const CustomCard({
    super.key,
    required this.title,
    required this.paragraph,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        child: Card(
          color: ThemeData.light().colorScheme.inversePrimary,
          child: Center(
            child: ListTile(
              leading: Icon(
                icon,
                size: 30,
              ),
              title: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              subtitle: Text(paragraph),
            ),
          ),
        ),
      ),
    );
  }
}
