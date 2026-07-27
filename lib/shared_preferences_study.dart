import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPCounterWidget extends StatefulWidget {
  const SPCounterWidget({super.key});

  @override
  State<SPCounterWidget> createState() => _SPCounterWidgetState();
}

class _SPCounterWidgetState extends State<SPCounterWidget> {
  String countString = '';
  String localCountString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('基于 SharedPreferences 实现计数器')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Increment Counter and Save'),
            ),
            ElevatedButton(
              onPressed: _getCounter,
              child: const Text('Get Counter from SharedPreferences'),
            ),
            Text(countString, style: const TextStyle(fontSize: 48)),
            Text(localCountString, style: const TextStyle(fontSize: 48)),
          ],
        ),
      ),
    );
  }

  Future<void> _incrementCounter() async {
    final prefs = SharedPreferencesAsync();
    if (!mounted) {
      return;
    }
    setState(() {
      countString = "$countString 1";
    });
    final counter = (await prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', counter);
  }

  Future<void> _getCounter() async {
    final prefs = SharedPreferencesAsync();
    final counter = await prefs.getInt('counter') ?? 0;
    if (!mounted) {
      return;
    }
    setState(() {
      localCountString = counter.toString();
    });
  }
}
