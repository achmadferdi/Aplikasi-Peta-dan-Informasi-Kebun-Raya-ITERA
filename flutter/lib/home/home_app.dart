import 'package:flutter/material.dart';

class HomeApp extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  HomeApp({super.key, required this.scaffoldKey});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                "assets/logo_full.png",
                width: 70,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () => print("notification"),
            ),
          ],
        ),
      ],
    );
  }
}
