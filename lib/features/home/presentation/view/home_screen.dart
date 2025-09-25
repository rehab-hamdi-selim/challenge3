import 'package:challenge3/features/home/presentation/view/widgets/dot.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sequential Loading Dots'), centerTitle: true),
      body: Center(
        child: DotsLoading(
          dotColor: Colors.blue,
          dotSize: 20,
          spacing: 6,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
