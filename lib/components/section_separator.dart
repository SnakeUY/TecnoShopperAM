import 'package:flutter/material.dart';

import '../pages/helpers/styles.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24.0),
      color: FormStyles.lightGrayColor,
      height: 1,
    );
  }
}
