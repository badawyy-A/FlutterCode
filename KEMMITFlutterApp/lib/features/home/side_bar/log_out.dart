import 'package:flutter/material.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Out')),
      body: const Center(child: Text('Logging out...')),
    );
  }
}
