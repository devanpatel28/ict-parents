import 'package:flutter/material.dart';
import 'package:ict_mu_parents/Helper/Components.dart';

import 'Helper/Colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard",style: TextStyle(color: Colors.black,fontFamily: "mu_reg",fontSize: 23)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlackTag(
              Dark1,
              null,
              null,
              "Devan Bhensdadiya",
              "Sem: 7  ""  Class: TK1 - A",
                Image.asset(
                  "assets/images/prof.png",
                  fit: BoxFit.cover,
                ),
              true
            ),
            SizedBox(height: 20,),
            BlackTag(
                Dark1,
                null,
                null,
                "Upcoming Event",
                "Engineer's Day Celebration",
                Image.asset(
                  "assets/images/prof.png",
                  fit: BoxFit.cover,
                ),
                false
            ),
          ],
        ),
      ),
    );
  }
}
