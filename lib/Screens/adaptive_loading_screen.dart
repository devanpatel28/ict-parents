import 'package:flutter/material.dart';

import '../Helper/Colors.dart';

class AdaptiveLoadingScreen extends StatelessWidget {
  const AdaptiveLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation(muColor),

        ),
      ),
    );
  }
}
