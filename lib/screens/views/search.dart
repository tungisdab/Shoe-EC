import 'package:app_shoes_ec/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.bgColor,
      body: const SafeArea(child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            
            TextField(
              decoration: InputDecoration(
                border:  OutlineInputBorder(),
                prefixIcon: SizedBox(
                  height: 20,
                  child: Icon(IconlyBroken.edit)),
                labelText: 'Search',
              ),
            ),
            // Expanded(child: )
          ],
        ),
      )
      )
    );
  }
}