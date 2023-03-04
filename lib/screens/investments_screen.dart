import 'package:flutter/material.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('AssetsDash portfolio tracker ||  Investments',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            )),
      ),
      body: const Center(
        child: Text('Screen'),
      ),
    );
  }
}
