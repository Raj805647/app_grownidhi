import 'package:flutter/material.dart';

import 'help_widget.dart';

class FinanceItem extends StatelessWidget {
  final String title;
  final String value;

  const FinanceItem({super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
          ),
        ),

       spaceHeight( 6),

        Text(
          value,

          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}