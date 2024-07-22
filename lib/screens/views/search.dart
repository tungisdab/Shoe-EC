import 'package:app_shoes_ec/styles/style.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(child: Padding(padding:const EdgeInsets.all(16),
        child: Column(
          children: [
            
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: SizedBox(
                  height: 20,
                  child: Image.asset('assets/icons/shoes/sneakerss.png')),
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