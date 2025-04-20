import 'package:flutter/material.dart';
import '../../Helper/Colors.dart';

class LogoutLoadingScreen extends StatelessWidget {
  const LogoutLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(muColor),
              ),
              SizedBox(height: 10,),
              Text('Logging out...'),

            ],
          ),
        ),
      ),
    );
  }
}
